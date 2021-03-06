import 'dart:async';

import 'package:flutter/foundation.dart';

import 'package:bloc/bloc.dart';
import 'package:connectivity/connectivity.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:equatable/equatable.dart';

part 'connectivity_state.dart';

class ConnectivityCubit extends Cubit<ConnectivityState> {
  ConnectivityCubit({
    @required Connectivity connectivity,
  })  : assert(connectivity != null),
        _connectivity = connectivity,
        super(ConnectivityHasConnection(true));

  final Connectivity _connectivity;
  StreamSubscription<ConnectivityResult> _subscription;

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }

  void intiConnectionListener() {
    _subscription =
        _connectivity.onConnectivityChanged.skip(1).listen((result) async {
      if (result != ConnectivityResult.none) {
        final hasConnection = await DataConnectionChecker().hasConnection;
        emit(ConnectivityHasConnection(hasConnection));
      } else {
        emit(ConnectivityHasConnection(false));
      }
    });
  }
}
