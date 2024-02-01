part of 'auth_bloc.dart';

class AuthState extends Equatable {
  const AuthState({
    this.user = const User(),
    this.isLoading = false,
    this.error = '',
    this.message = '',
  });

  final User user;
  final bool isLoading;
  final String error;
  final String message;

  AuthState copyWith({
    User? user,
    bool? isLoading,
    String? error,
    String? message,
  }) {
    return AuthState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      message: message ?? this.message,
    );
  }

  factory AuthState.fromJson(Map<String, dynamic> json) => AuthState(
        user: User.fromJson(json['user'] ?? <String, dynamic>{}),
      );

  Map<String, dynamic> toJson() => {
        'user': user.toJson(),
      };

  @override
  List<Object?> get props => [user, isLoading, error, message];
}
