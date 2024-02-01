part of 'auth_bloc.dart';

class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

final class SignInEvent extends AuthEvent {
  const SignInEvent({
    required this.phone,
    required this.password,
  });
  final int phone;
  final String password;

  @override
  List<Object> get props => [
        phone,
        password,
      ];
}

final class SignOutEvent extends AuthEvent {
  const SignOutEvent();
  @override
  List<Object> get props => [];
}

final class ResetPasswordEvent extends AuthEvent {
  const ResetPasswordEvent({
    required this.phone,
    required this.password,
    required this.confirmPassword,
  });
  final int phone;
  final String password;
  final String confirmPassword;
  @override
  List<Object> get props => [phone, password, confirmPassword];
}
