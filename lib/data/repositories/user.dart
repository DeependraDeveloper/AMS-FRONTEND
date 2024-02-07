import 'package:amsystm/data/models/json_reposne.dart';
import 'package:amsystm/data/services/user.dart';

abstract class UserRepository {
  // signIn
  Future<JsonResponse> signIn({
    required int phone,
    required String password,
  });

  // signUp
  Future<JsonResponse> signUp({
    required String name,
    required String email,
    required int phone,
    required String password,
    required String department,
    required String designation,
    required String organization,
  });

  // resetPasswrod
  Future<JsonResponse> resetPasswrod({
    required int phone,
    required String password,
    required String confirmPassword,
  });

  // clockInOut
  Future<JsonResponse> clockInOut({
    required String id,
    required String time,
  });

  // getAttendence
  Future<JsonResponse> getAttendence({
    required String id,
  }); 


  // addLeaveRequest
  Future<JsonResponse> addLeaveRequest({
    required String leaveType,
    required String leaveReason,
    required String leaveFrom,
    required String leaveTo,
    required String id,
  });

  // getLeaves

  Future<JsonResponse> getLeaveRequests({
    required String id,
  });


  // addEmployee
  Future<JsonResponse> addEmployee({
    required String id,
    required String name,
    required String email,
    required String phone,
    required String password,
    required String department,
    required String designation,
  });


  // getAllAttendences
  Future<JsonResponse> getAllAttendences({
    required String id,
  });


  // getAllUsers
  Future<JsonResponse> getAllUsers({
    required String organization,
  });

}

class UserRepositoryImpl implements UserRepository {
  const UserRepositoryImpl({required this.userService});

  final UserService userService;

  // signIn
  @override
  Future<JsonResponse> signIn({
    required int phone,
    required String password,
  }) {
    return userService.signIn(
      phone: phone,
      password: password,
    );
  }

  // signUp
  @override
  Future<JsonResponse> signUp({
    required String name,
    required String email,
    required int phone,
    required String password,
    required String department,
    required String designation,
    required String organization,
  }) {
    return userService.signUp(
      name: name,
      email: email,
      phone: phone,
      password: password,
      department: department,
      designation: designation,
      organization: organization,
    );
  }

  // resetPassword
  @override
  Future<JsonResponse> resetPasswrod({
    required int phone,
    required String password,
    required String confirmPassword,
  }) {
    return userService.resetPasswrod(
      phone: phone,
      password: password,
      confirmPassword: confirmPassword,
    );
  }

  // clockInOut
  @override
  Future<JsonResponse> clockInOut({
    required String id,
    required String time,
  }) {
    return userService.clockInOut(
      id: id,
      time: time,
    );
  }


  // getAttendence
  @override
  Future<JsonResponse> getAttendence({
    required String id,
  }) {
    return userService.getAttendence(
      id: id,
    );
  }

  // addLeaveRequest
  @override
  Future<JsonResponse> addLeaveRequest({
    required String leaveType,
    required String leaveReason,
    required String leaveFrom,
    required String leaveTo,
    required String id,
  }) {
    return userService.addLeaveRequest(
      leaveType: leaveType,
      leaveReason: leaveReason,
      leaveFrom: leaveFrom,
      leaveTo: leaveTo,
      id: id,
    );
  }


  // getLeaves
  @override
  Future<JsonResponse> getLeaveRequests({
    required String id,
  }) {
    return userService.getLeaveRequests(
      id: id,
    );
  }


   // addEmployee
  @override
  Future<JsonResponse> addEmployee({
    required String id,
    required String name,
    required String email,
    required String phone,
    required String password,
    required String department,
    required String designation,
  }) {
    return userService.addEmployee(
      id: id,
      name: name,
      email: email,
      phone: phone,
      password: password,
      department: department,
      designation: designation,
    );
  }


  // getAllAttendences
  @override
  Future<JsonResponse> getAllAttendences({
    required String id,
  }) {
    return userService.getAllAttendences(
      id: id,
    );
  }


  // getAllUsers
  @override
  Future<JsonResponse> getAllUsers({
    required String organization,
  }) {
    return userService.getAllUsers(
      organization: organization,
    );
  }

}
