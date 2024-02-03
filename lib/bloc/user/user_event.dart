part of 'user_bloc.dart';

class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

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
