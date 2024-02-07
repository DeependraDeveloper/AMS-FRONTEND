import 'dart:async';

import 'package:amsystm/data/models/user.dart';
import 'package:amsystm/data/repositories/user.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends HydratedBloc<AuthEvent, AuthState> {
  AuthBloc({
    required this.repository,
  }) : super(const AuthState()) {
    on<SignInEvent>(_onSignInEvent);
    on<SignUpEvent>(_onSignUpEvent);
    on<SignOutEvent>(_onSignOutEvent);
    on<ResetPasswordEvent>(_onResetPasswordEvent);
  }

  final UserRepository repository;

  // signIn
  FutureOr<void> _onSignInEvent(
      SignInEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(isLoading: true, error: '', message: ''));

    try {
      final response = await repository.signIn(
        phone: event.phone,
        password: event.password,
      );

      if (response.success) {
        final data = response.data as User;
        await HydratedBloc.storage.write('token', data.token);

        emit(state.copyWith(
          isLoading: false,
          user: data,
          message: response.message,
        ));
      } else {
        emit(
          state.copyWith(
            isLoading: false,
            error: 'Error : ${response.message}',
          ),
        );
      }
    } on Exception catch (_) {
      emit(
        state.copyWith(
          isLoading: false,
          error: 'Error : $_',
        ),
      );
    }
  }

  // signUp
  FutureOr<void> _onSignUpEvent(
      SignUpEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(isLoading: true, error: '', message: ''));

    try {
      final response = await repository.signUp(
        name: event.name,
        email: event.email,
        phone: event.phone,
        password: event.password,
        department: event.department,
        designation: event.designation,
        organization: event.organization,
      );

      if (response.success) {
        final data = response.data as User;
        await HydratedBloc.storage.write('token', data.token);

        emit(state.copyWith(
          isLoading: false,
          user: data,
          message: response.message,
        ));
      } else {
        emit(
          state.copyWith(
            isLoading: false,
            error: 'Error : ${response.message}',
          ),
        );
      }
    } on Exception catch (_) {
      emit(
        state.copyWith(
          isLoading: false,
          error: 'Error : $_',
        ),
      );
    }
  }

  // signOut
  FutureOr<void> _onSignOutEvent(
      SignOutEvent event, Emitter<AuthState> emit) async {
    await HydratedBloc.storage.delete('token');
    emit(const AuthState());
  }

  // resetPassword
  Future<FutureOr<void>> _onResetPasswordEvent(
      ResetPasswordEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(isLoading: true, error: '', message: ''));

    try {
      final response = await repository.resetPasswrod(
        phone: event.phone,
        password: event.password,
        confirmPassword: event.confirmPassword,
      );

      if (response.success) {
        final data = response.data as User;
        await HydratedBloc.storage.write('token', data.token);

        emit(state.copyWith(
          isLoading: false,
          user: data,
          message: response.message,
        ));
      } else {
        emit(
          state.copyWith(
            isLoading: false,
            error: 'Error : ${response.message}',
          ),
        );
      }
    } on Exception catch (_) {
      emit(
        state.copyWith(
          isLoading: false,
          error: 'Error : $_',
        ),
      );
    }
  }

  @override
  AuthState? fromJson(Map<String, dynamic> json) => AuthState.fromJson(json);

  @override
  Map<String, dynamic>? toJson(AuthState state) => state.toJson();
}
