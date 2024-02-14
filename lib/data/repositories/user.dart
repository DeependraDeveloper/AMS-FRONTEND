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

  // updateUser

  Future<JsonResponse> updateUser({
    required String id,
    required String name,
    required String email,
    required String phone,
    required String department,
    required String designation,
    required String organization,
  });

  // get user
  Future<JsonResponse> getUser({
    required String id,
  });

  // approveOrRejectLeave
  Future<JsonResponse> approveOrRejectLeave({
    required String userId,
    required String leaveId,
  });

  // downloadAttendence
  Future<JsonResponse> downloadAttendence({
    required String id,
  });

  // getAttendencesOfParticularUser
  Future<JsonResponse> getAttendencesOfParticularUser({
    required String id,
  });

  // updateAttendence

  Future<JsonResponse> updateAttendence({
    required String id,
    required String inTime,
    required String outTime,
    required String status,
  });

  // downloadAttendenceMonthy
  Future<JsonResponse> downloadAttendenceMonthy(
      {required String id, required int month, required int year});

  // getAttendenceWithDateRange
  Future<JsonResponse> getAttendenceWithDateRange({
    required String id,
    required String startDate,
    required String endDate,
  });

  // updateAttendences

  Future<JsonResponse> updateAttendences({
    required List<String> ids,
    required String inTime,
    required String outTime,
    required String status,
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

  // updateUser
  @override
  Future<JsonResponse> updateUser({
    required String id,
    required String name,
    required String email,
    required String phone,
    required String department,
    required String designation,
    required String organization,
  }) {
    return userService.updateUser(
      id: id,
      name: name,
      email: email,
      phone: phone,
      department: department,
      designation: designation,
      organization: organization,
    );
  }

  // get user
  @override
  Future<JsonResponse> getUser({
    required String id,
  }) {
    return userService.getUser(
      id: id,
    );
  }

  // approveOrRejectLeave
  @override
  Future<JsonResponse> approveOrRejectLeave({
    required String userId,
    required String leaveId,
  }) {
    return userService.approveOrRejectLeave(
      userId: userId,
      leaveId: leaveId,
    );
  }

  // downloadAttendence
  @override
  Future<JsonResponse> downloadAttendence({
    required String id,
  }) {
    return userService.downloadAttendence(
      id: id,
    );
  }

  // getAttendencesOfParticularUser
  @override
  Future<JsonResponse> getAttendencesOfParticularUser({
    required String id,
  }) {
    return userService.getAttendencesOfParticularUser(
      id: id,
    );
  }

  // updateAttendence
  @override
  Future<JsonResponse> updateAttendence({
    required String id,
    required String inTime,
    required String outTime,
    required String status,
  }) {
    return userService.updateAttendence(
      id: id,
      inTime: inTime,
      outTime: outTime,
      status: status,
    );
  }

  // downloadAttendenceMonthy
  @override
  Future<JsonResponse> downloadAttendenceMonthy(
      {required String id, required int month, required int year}) {
    return userService.downloadAttendenceMonthy(
        id: id, month: month, year: year);
  }

  // getAttendenceWithDateRange
  @override
  Future<JsonResponse> getAttendenceWithDateRange({
    required String id,
    required String startDate,
    required String endDate,
  }) {
    return userService.getAttendenceWithDateRange(
      id: id,
      startDate: startDate,
      endDate: endDate,
    );
  }


  @override
   Future<JsonResponse> updateAttendences({
    required List<String> ids,
    required String inTime,
    required String outTime,
    required String status,
  }) {
    return userService.updateAttendences(
      ids: ids,
      inTime: inTime,
      outTime: outTime,
      status: status,
    );
  }
}
