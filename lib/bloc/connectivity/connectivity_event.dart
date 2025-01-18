part of 'connectivity_bloc.dart';

sealed class ConnectivityEvent extends Equatable {
  const ConnectivityEvent();
  @override
  List<Object> get props => [];
}

final class ConnectivitySetter extends ConnectivityEvent {
  const ConnectivitySetter({
    required this.status,
    required this.connectivityTypes,
    this.busy = false,
    this.error = '',
    this.message = '',
  });
  final ConnectivityStatus status;
  final List<ConnectivityResult> connectivityTypes;
  final bool busy;
  final String error;
  final String message;
  @override
  List<Object> get props => [status, connectivityTypes, busy, error, message];
}

final class ConnectivityChecker extends ConnectivityEvent {
  const ConnectivityChecker();
  @override
  List<Object> get props => [];
}

final class InternetChecker extends ConnectivityEvent {
  const InternetChecker({required this.connectivityTypes});
  final List<ConnectivityResult> connectivityTypes;
  @override
  List<Object> get props => [connectivityTypes];
}
