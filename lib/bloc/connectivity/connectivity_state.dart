part of 'connectivity_bloc.dart';

enum ConnectivityStatus {
  connected,
  disconnected,
}

class ConnectivityState extends Equatable {
  const ConnectivityState({
    this.status = ConnectivityStatus.connected,
    this.connectivityTypes = const <ConnectivityResult>[],
    this.busy = false,
    this.error = '',
    this.message = '',
  });

  final ConnectivityStatus status;
  final List<ConnectivityResult> connectivityTypes;
  final bool busy;
  final String error;
  final String message;

  /// copyWith method
  ConnectivityState copyWith({
    ConnectivityStatus? status,
    List<ConnectivityResult>? connectivityTypes,
    bool? busy,
    String? error,
    String? message,
  }) {
    return ConnectivityState(
      status: status ?? this.status,
      connectivityTypes: connectivityTypes ?? this.connectivityTypes,
      busy: busy ?? this.busy,
      error: error ?? this.error,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [status, connectivityTypes, busy, error, message];
}
