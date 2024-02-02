part of 'user_bloc.dart';

class UserState extends Equatable {
  const UserState({
    this.attendence = const Attendence(),
    this.isLoading = false,
    this.error = '',
    this.message = '',
  });

  final Attendence attendence;
  final bool isLoading;
  final String error;
  final String message;

  UserState copyWith({
    Attendence? attendence,
    bool? isLoading,
    String? error,
    String? message,
  }) {
    return UserState(
      attendence: attendence ?? this.attendence,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [
        // user,
        isLoading, error, message
      ];
}
