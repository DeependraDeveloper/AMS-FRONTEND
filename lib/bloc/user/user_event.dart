part of 'user_bloc.dart';

class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

// clock in/out event for employee and admin
final class ClockInOutEvent extends UserEvent {
  const ClockInOutEvent({
    required this.id,
    required this.time,
  });
  final String id;
  final String time;

  @override
  List<Object> get props => [
        id,
        time,
      ];
}

// get attendance event for admin and employee for today
final class GetAttendanceEvent extends UserEvent {
  const GetAttendanceEvent({
    required this.id,
  });
  final String id;

  @override
  List<Object> get props => [
        id,
      ];
}

// add leave request event for employee
final class AddLeaveRequestEvent extends UserEvent {
  const AddLeaveRequestEvent({
    required this.leaveType,
    required this.leaveReason,
    required this.leaveFrom,
    required this.leaveTo,
    required this.id,
  });
  final String leaveType;
  final String leaveReason;
  final String leaveFrom;
  final String leaveTo;
  final String id;

  @override
  List<Object> get props => [
        leaveType,
        leaveReason,
        leaveFrom,
        leaveTo,
        id,
      ];
}

// get leaves event for admin and employee
final class GetLeavesEvent extends UserEvent {
  const GetLeavesEvent({
    required this.id,
  });
  final String id;

  @override
  List<Object> get props => [
        id,
      ];
}

// add employee event for admin
final class AddEmployeeEvent extends UserEvent {
  const AddEmployeeEvent({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
    required this.department,
    required this.designation,
  });
  final String id;
  final String name;
  final String email;
  final String phone;
  final String password;
  final String department;
  final String designation;

  @override
  List<Object> get props => [
        id,
        name,
        email,
        phone,
        password,
        department,
        designation,
      ];
}

// get all attendences event for employee
final class GetAllAttendencesEvent extends UserEvent {
  const GetAllAttendencesEvent({
    required this.id,
  });
  final String id;

  @override
  List<Object> get props => [
        id,
      ];
}

// get all employees event for admin

final class GetAllEmployeesEvent extends UserEvent {
  const GetAllEmployeesEvent({
    required this.organization,
  });
  final String organization;

  @override
  List<Object> get props => [
        organization,
      ];
}

// update user event for admin and employee

final class UpdateUserEvent extends UserEvent {
  const UpdateUserEvent({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.department,
    required this.designation,
    required this.organization,
  });
  final String id;
  final String name;
  final String email;
  final String phone;
  final String department;
  final String designation;
  final String organization;

  @override
  List<Object> get props => [
        id,
        name,
        email,
        phone,
        department,
        designation,
        organization,
      ];
}

// get user event for admin and employee

final class GetUserEvent extends UserEvent {
  const GetUserEvent({
    required this.id,
  });
  final String id;

  @override
  List<Object> get props => [
        id,
      ];
}

// approve or reject leave event for admin

final class ApproveOrRejectLeaveEvent extends UserEvent {
  const ApproveOrRejectLeaveEvent({
    required this.userId,
    required this.leaveId,
  });
  final String userId;
  final String leaveId;

  @override
  List<Object> get props => [
        userId,
        leaveId,
      ];
}


// Download attendance event for admin

final class DownloadAttendanceEvent extends UserEvent {
  const DownloadAttendanceEvent({
    required this.id,
  });
  final String id;

  @override
  List<Object> get props => [
        id,
      ];
}
