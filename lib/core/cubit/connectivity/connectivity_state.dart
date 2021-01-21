part of 'connectivity_cubit.dart';

abstract class ConnectivityState extends Equatable {
  const ConnectivityState();

  @override
  List<Object> get props => [];
}

class HasConnection extends ConnectivityState {
  HasConnection(this.hasConnection);

  final hasConnection;

  @override
  List<Object> get props => [
        hasConnection,
      ];
}
