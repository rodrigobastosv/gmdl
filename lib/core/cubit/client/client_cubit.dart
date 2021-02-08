import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'client_state.dart';

const QUEUE_TIME = Duration(seconds: 3);

class ClientCubit extends Cubit<ClientState> {
  ClientCubit() : super(ClientInitial());

  final queue = <Future>[];
  StreamController<Future> queueStreamController;
  StreamSubscription queueSubscription;

  void init() {
    queueStreamController = StreamController();
    queueSubscription = queueStreamController.stream.listen((func) async {
      await Future.delayed(QUEUE_TIME);
      await func;
      emit(RequestDequeued());
    });
  }

  Future<void> schedule(Future func) async {
    queueStreamController.add(func);
    emit(RequestEnqueued());
  }

  @override
  Future<void> close() {
    queueStreamController?.close();
    queueSubscription?.cancel();
    return super.close();
  }
}
