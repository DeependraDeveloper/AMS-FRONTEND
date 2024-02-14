import 'dart:async';

import 'package:amsystm/data/models/all_attendence.dart';
import 'package:amsystm/data/models/attendence.dart';
import 'package:amsystm/data/models/leave.dart';
import 'package:amsystm/data/models/user.dart';
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
    on<AddEmployeeEvent>(_onAddEmployeeEvent);
    on<GetAllAttendencesEvent>(_onGetAllAttendanceEvent);
    on<GetAllEmployeesEvent>(_onGetAllEmployeesEvent);
    on<UpdateUserEvent>(_onUpdateUserEvent);
    on<GetUserEvent>(_onGetUserEvent);
    on<ApproveOrRejectLeaveEvent>(_onApproveOrRejectLeaveEvent);
    on<DownloadAttendanceEvent>(_onDownloadAttendanceEvent);
    on<GetAttendencesOfParticularUserEvent>(
        _onGetAttendencesOfParticularUserEvent);
    on<UpdateAttendenceEvent>(_onUpdateAttendenceEvent);
    on<GetAttendenceReportMonthlyEvent>(_onGetAttendenceReportMonthlyEvent);
    on<GetAttendenceWithDateRangeEvent>(_onGetAttendenceWithDateRangeEvent);
    on<UpdateAttendencesEvent>(_onUpdateAttendencesEvent);
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

  Future<FutureOr<void>> _onAddEmployeeEvent(
      AddEmployeeEvent event, Emitter<UserState> emit) async {
    emit(state.copyWith(isLoading: true, error: '', message: ''));
    try {
      final response = await repository.addEmployee(
        id: event.id,
        name: event.name,
        email: event.email,
        phone: event.phone,
        password: event.password,
        department: event.department,
        designation: event.designation,
      );

      if (response.success) {
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

  Future<FutureOr<void>> _onGetAllAttendanceEvent(
      GetAllAttendencesEvent event, Emitter<UserState> emit) async {
    emit(state.copyWith(isLoading: true, error: '', message: ''));
    try {
      final response = await repository.getAllAttendences(
        id: event.id,
      );

      if (response.success) {
        final data = response.data as List<Attendence>;
        emit(state.copyWith(
          isLoading: false,
          message: response.message,
          attendences: data,
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

  Future<FutureOr<void>> _onGetAllEmployeesEvent(
      GetAllEmployeesEvent event, Emitter<UserState> emit) async {
    emit(state.copyWith(isLoading: true, error: '', message: ''));
    try {
      final response = await repository.getAllUsers(
        organization: event.organization,
      );

      if (response.success) {
        final data = response.data as List<User>;
        emit(state.copyWith(
            isLoading: false, message: response.message, users: data));
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

  // update user or admin
  Future<FutureOr<void>> _onUpdateUserEvent(
      UpdateUserEvent event, Emitter<UserState> emit) async {
    emit(state.copyWith(isLoading: true, error: '', message: ''));
    try {
      final response = await repository.updateUser(
        id: event.id,
        name: event.name,
        email: event.email,
        phone: event.phone,
        department: event.department,
        designation: event.designation,
        organization: event.organization,
      );

      if (response.success) {
        add(GetUserEvent(id: event.id));
        emit(state.copyWith(isLoading: false, message: response.message));
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

  // get user event for admin and employee
  Future<FutureOr<void>> _onGetUserEvent(
      GetUserEvent event, Emitter<UserState> emit) async {
    emit(state.copyWith(isLoading: true, error: '', message: ''));
    try {
      final response = await repository.getUser(
        id: event.id,
      );

      if (response.success) {
        emit(
          state.copyWith(
              isLoading: false,
              message: response.message,
              user: response.data as User),
        );
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

  Future<FutureOr<void>> _onApproveOrRejectLeaveEvent(
      ApproveOrRejectLeaveEvent event, Emitter<UserState> emit) async {
    emit(state.copyWith(isLoading: true, error: '', message: ''));
    try {
      final response = await repository.approveOrRejectLeave(
        userId: event.userId,
        leaveId: event.leaveId,
      );

      if (response.success) {
        add(GetLeavesEvent(id: event.userId));
        emit(state.copyWith(isLoading: false, message: response.message));
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

  Future<FutureOr<void>> _onDownloadAttendanceEvent(
      DownloadAttendanceEvent event, Emitter<UserState> emit) async {
    emit(state.copyWith(isLoading: true, error: '', message: ''));
    try {
      final response = await repository.downloadAttendence(
        id: event.id,
      );

      if (response.success) {
        emit(state.copyWith(isLoading: false, message: response.message));
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

  Future<FutureOr<void>> _onGetAttendencesOfParticularUserEvent(
      GetAttendencesOfParticularUserEvent event,
      Emitter<UserState> emit) async {
    emit(state.copyWith(isLoading: true, error: '', message: ''));
    try {
      final response = await repository.getAttendencesOfParticularUser(
        id: event.id,
      );

      if (response.success) {
        final data = response.data as List<AllAttendence>;
        emit(state.copyWith(
            isLoading: false, message: response.message, allAttendences: data));
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

  Future<FutureOr<void>> _onUpdateAttendenceEvent(
      UpdateAttendenceEvent event, Emitter<UserState> emit) async {
    emit(state.copyWith(isLoading: true, error: '', message: ''));
    try {
      final response = await repository.updateAttendence(
        id: event.id,
        status: event.status,
        inTime: event.inTime,
        outTime: event.outTime,
      );

      if (response.success) {
        emit(state.copyWith(isLoading: false, message: response.message));
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

  Future<FutureOr<void>> _onGetAttendenceReportMonthlyEvent(
      GetAttendenceReportMonthlyEvent event, Emitter<UserState> emit) async {
    emit(state.copyWith(isLoading: true, error: '', message: ''));
    try {
      final response = await repository.downloadAttendenceMonthy(
        id: event.id,
        month: event.month,
        year: event.year,
      );

      if (response.success) {
        emit(state.copyWith(isLoading: false, message: response.message));
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

  Future<FutureOr<void>> _onGetAttendenceWithDateRangeEvent(
      GetAttendenceWithDateRangeEvent event, Emitter<UserState> emit) async {
    emit(state.copyWith(isLoading: true, error: '', message: ''));
    try {
      final response = await repository.getAttendenceWithDateRange(
        id: event.id,
        startDate: event.startDate,
        endDate: event.endDate,
      );

      if (response.success) {
        final data = response.data as List<Attendence>;
        emit(state.copyWith(
            isLoading: false,
            message: response.message,
            dateRangeAttendences: data));
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

  Future<FutureOr<void>> _onUpdateAttendencesEvent(UpdateAttendencesEvent event, Emitter<UserState> emit) async {
     emit(state.copyWith(isLoading: true, error: '', message: ''));
    try {
      
      final response = await repository.updateAttendences(
        ids: event.ids,
        status: event.status,
        inTime: event.inTime,
        outTime: event.outTime,
      );

      if (response.success) {
        emit(state.copyWith(isLoading: false, message: response.message));
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
