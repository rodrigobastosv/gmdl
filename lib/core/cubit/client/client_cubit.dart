import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'client_state.dart';

const QUEUE_TIME = Duration(seconds: 5);

class ClientCubit extends Cubit<ClientState> {
  ClientCubit() : super(ClientInitial());

  final queue = <Future>[];
  StreamSubscription queueSubscription;

  void init() {
    queueSubscription = Stream.periodic(QUEUE_TIME).listen((_) async {
      if (queue.isNotEmpty) {
        await _dequeue();
      }
    });
  }

  Future<void> schedule(Future func) async {
    queue.add(func);
    emit(RequestEnqueued());
  }

  Future<void> _dequeue() async {
    try {
      final func = queue[0];
      await func;
      queue.removeAt(0);
      emit(RequestDequeued());
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<void> close() {
    queueSubscription?.cancel();
    return super.close();
  }
}
