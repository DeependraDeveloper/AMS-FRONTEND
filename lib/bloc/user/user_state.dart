part of 'user_bloc.dart';

class UserState extends Equatable {
  const UserState({
    this.attendence = const Attendence(), // particular user single attendence
    this.leaves = const <Leave>[], // particular user all leaves
    this.employeeLeaves = const <Leave>[], // all employees leaves
    this.attendences = const <Attendence>[], //particular user attendences
    this.users = const <User>[], // all users
    this.user = const User(), // particular user
    this.allAttendences = const <AllAttendence>[], // particular user all attendences
    this.dateRangeAttendences = const <Attendence>[], // particular user attendences in date range
    this.isLoading = false,
    this.error = '',
    this.message = '',
  });

  final List<Leave> leaves;
  final List<Leave> employeeLeaves;
  final Attendence attendence;
  final List<Attendence> attendences;
  final List<User> users;
  final User user;
  final List<AllAttendence> allAttendences;
  final List<Attendence> dateRangeAttendences;
  final bool isLoading;
  final String error;
  final String message;

  UserState copyWith({
    final List<Leave>? employeeLeaves,
    List<Leave>? leaves,
    Attendence? attendence,
    List<Attendence>? attendences,
    List<User>? users,
    User? user,
    List<AllAttendence>? allAttendences,
    List<Attendence>? dateRangeAttendences,
    bool? isLoading,
    String? error,
    String? message,
  }) {
    return UserState(
      employeeLeaves: employeeLeaves ?? this.employeeLeaves,
      leaves: leaves ?? this.leaves,
      attendence: attendence ?? this.attendence,
      attendences: attendences ?? this.attendences,
      users: users ?? this.users,
      user: user ?? this.user,
      allAttendences: allAttendences ?? this.allAttendences,
      dateRangeAttendences: dateRangeAttendences ?? this.dateRangeAttendences,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [
        employeeLeaves,
        leaves,
        attendence,
        attendences,
        users,
        user,
        allAttendences,
        dateRangeAttendences,
        isLoading,
        error,
        message
      ];
}
