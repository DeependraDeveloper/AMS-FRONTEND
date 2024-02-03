import 'dart:async';

import 'package:amsystm/data/models/attendence.dart';
import 'package:amsystm/data/models/leave.dart';
import 'package:amsystm/data/repositories/user.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc({
    required this.repository,
  }) : super(const UserState()) {
    on<ClockInOutEvent>(_onClockInOutEvent);
    on<GetAttendanceEvent>(_onGetAttendanceEvent);
    on<AddLeaveRequestEvent>(_onAddLeaveRequestEvent);
    on<GetLeavesEvent>(_onGetLeavesEvent);
  }

  final UserRepository repository;

  Future<FutureOr<void>> _onClockInOutEvent(
      ClockInOutEvent event, Emitter<UserState> emit) async {
    emit(state.copyWith(isLoading: true, error: '', message: ''));
    try {
      final response = await repository.clockInOut(
        id: event.id,
        time: event.time,
      );

      if (response.success) {
        add(GetAttendanceEvent(id: event.id));
        emit(state.copyWith(
          isLoading: false,
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

  Future<FutureOr<void>> _onGetAttendanceEvent(
      GetAttendanceEvent event, Emitter<UserState> emit) async {
    emit(state.copyWith(isLoading: true, error: '', message: ''));
    try {
      final response = await repository.getAttendence(
        id: event.id,
      );

      if (response.success) {
        final data = response.data as Attendence;

        emit(state.copyWith(
          attendence: data,
          isLoading: false,
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

  Future<FutureOr<void>> _onAddLeaveRequestEvent(
      AddLeaveRequestEvent event, Emitter<UserState> emit) async {
    emit(state.copyWith(isLoading: true, error: '', message: ''));
    try {
      final response = await repository.addLeaveRequest(
        leaveType: event.leaveType,
        leaveReason: event.leaveReason,
        leaveFrom: event.leaveFrom,
        leaveTo: event.leaveTo,
        id: event.id,
      );

      if (response.success) {
        add(GetLeavesEvent(id: event.id));

        emit(state.copyWith(
          isLoading: false,
          message: 'Leave request submitted successfully!',
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

  Future<FutureOr<void>> _onGetLeavesEvent(
      GetLeavesEvent event, Emitter<UserState> emit) async {
    emit(state.copyWith(isLoading: true, error: '', message: ''));
    try {
      final response = await repository.getLeaveRequests(
        id: event.id,
      );

      if (response.success) {
        final data = response.data as List<Leave>;
        emit(state.copyWith(
          isLoading: false,
          message: response.message,
          leaves: data,
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
}
