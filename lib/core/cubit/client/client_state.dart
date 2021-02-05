part of 'client_cubit.dart';

abstract class ClientState extends Equatable {
  const ClientState();

  @override
  List<Object> get props => [];
}

class ClientInitial extends ClientState {}

class RequestEnqueued extends ClientState {}

class RequestDequeued extends ClientState {}
