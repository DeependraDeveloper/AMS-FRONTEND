import 'dart:io';

import 'package:amsystm/data/models/all_attendence.dart';
import 'package:amsystm/data/models/attendence.dart';
import 'package:amsystm/data/models/json_reposne.dart';
import 'package:amsystm/data/models/leave.dart';
import 'package:amsystm/data/models/user.dart';
import 'package:amsystm/utils/constants.dart';
import 'package:dio/dio.dart';
import 'package:external_path/external_path.dart';

class UserService {
  UserService({required this.dio}) {
    dio.options.baseUrl = httpBaseUrl;
    dio.options.sendTimeout = const Duration(seconds: 10);
    dio.options.receiveTimeout = const Duration(seconds: 10);
    dio.options.connectTimeout = const Duration(seconds: 10);
    dio.options.responseType = ResponseType.json;
    dio.options.headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
    ));
  }

  final Dio dio;

  // signIn
  Future<JsonResponse> signIn({
    required int phone,
    required String password,
  }) async {
    try {
      final Response response = await dio.post(
        '/signin',
        data: {
          'phone': phone,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        final data = User.fromJson(response.data ?? <String, dynamic>{});

        return JsonResponse.success(
          message: 'Signed In Successfully!',
          data: data,
        );
      } else {
        final error = response.data?["message"]?.toString();
        return JsonResponse.failure(
          statusCode: response.statusCode ?? 500,
          message: error ?? 'something went wrong!',
        );
      }
    } on DioException catch (e) {
      final error = e.response?.data?["message"]?.toString();
      return JsonResponse.failure(
        message: error.toString(),
        statusCode: e.response?.statusCode ?? 500,
      );
    } on Exception catch (_) {
      return JsonResponse.failure(
        message: 'Something went wrong!',
      );
    }
  }

  // signUp
  Future<JsonResponse> signUp({
    required String name,
    required String email,
    required int phone,
    required String password,
    required String department,
    required String designation,
    required String organization,
  }) async {
    try {
      final Response response = await dio.post(
        '/signup',
        data: {
          'name': name,
          'email': email,
          'phone': phone,
          'password': password,
          'department': department,
          'designation': designation,
          'organization': organization,
        },
      );
      if (response.statusCode == 200) {
        final data = User.fromJson(response.data ?? <String, dynamic>{});

        return JsonResponse.success(
          message: 'Signed Up Successfully!',
          data: data,
        );
      } else {
        final error = response.data?["message"]?.toString();
        return JsonResponse.failure(
          statusCode: response.statusCode ?? 500,
          message: error ?? 'Something went wrong!',
        );
      }
    } on DioException catch (e) {
      final error = e.response?.data?["message"]?.toString();
      return JsonResponse.failure(
        message: error.toString(),
        statusCode: e.response?.statusCode ?? 500,
      );
    } on Exception catch (_) {
      return JsonResponse.failure(
        message: 'Something went wrong!',
      );
    }
  }

  // resetPasswrod
  Future<JsonResponse> resetPasswrod({
    required int phone,
    required String password,
    required String confirmPassword,
  }) async {
    try {
      final Response response = await dio.post(
        '/reset-password',
        data: {
          'phone': phone,
          'password': password,
          'confirmPassword': confirmPassword,
        },
      );
      if (response.statusCode == 200) {
        final data = User.fromJson(response.data ?? <String, dynamic>{});

        return JsonResponse.success(
          message: 'Password Reset Successfully!',
          data: data,
        );
      } else {
        final error = response.data?["message"]?.toString();
        return JsonResponse.failure(
          statusCode: response.statusCode ?? 500,
          message: error ?? 'Something went wrong!',
        );
      }
    } on DioException catch (e) {
      final error = e.response?.data?["message"]?.toString();
      return JsonResponse.failure(
        message: error.toString(),
        statusCode: e.response?.statusCode ?? 500,
      );
    } on Exception catch (_) {
      return JsonResponse.failure(
        message: 'Something went wrong!',
      );
    }
  }

  // clockInOut
  Future<JsonResponse> clockInOut({
    required String id,
    required String time,
  }) async {
    try {
      final Response response = await dio.post(
        '/clock-in-out',
        data: {
          'id': id,
          'time': time,
        },
      );
      if (response.statusCode == 200) {
        return JsonResponse.success(
          message: response.data?["message"]?.toString() ?? 'Success!',
        );
      } else {
        final error = response.data?["message"]?.toString();
        return JsonResponse.failure(
          statusCode: response.statusCode ?? 500,
          message: error ?? 'Something went wrong!',
        );
      }
    } on DioException catch (e) {
      final error = e.response?.data?["message"]?.toString();
      return JsonResponse.failure(
        message: error.toString(),
        statusCode: e.response?.statusCode ?? 500,
      );
    } on Exception catch (_) {
      return JsonResponse.failure(
        message: 'Something went wrong!',
      );
    }
  }

  // getAttendence
  Future<JsonResponse> getAttendence({
    required String id,
  }) async {
    try {
      final Response response = await dio.get(
        '/attendence/$id',
      );

      if (response.statusCode == 200) {
        final data = Attendence.fromJson(response.data ?? <String, dynamic>{});

        return JsonResponse.success(
          message: 'Attendence Fetched Successfully!',
          data: data,
        );
      } else {
        final error = response.data?["message"]?.toString();
        return JsonResponse.failure(
          statusCode: response.statusCode ?? 500,
          message: error ?? 'Something went wrong!',
        );
      }
    } on DioException catch (e) {
      final error = e.response?.data?["message"]?.toString();
      return JsonResponse.failure(
        message: error.toString(),
        statusCode: e.response?.statusCode ?? 500,
      );
    } on Exception catch (_) {
      return JsonResponse.failure(
        message: 'Something went wrong!',
      );
    }
  }

  // addLeaveRequest

  Future<JsonResponse> addLeaveRequest({
    required String leaveType,
    required String leaveReason,
    required String leaveFrom,
    required String leaveTo,
    required String id,
  }) async {
    try {
      final Response response = await dio.post(
        '/leave-request',
        data: {
          'leaveType': leaveType,
          'leaveReason': leaveReason,
          'leaveFrom': leaveFrom,
          'leaveTo': leaveTo,
          'id': id,
        },
      );
      if (response.statusCode == 200) {
        return JsonResponse.success(
          message: response.data?["message"]?.toString() ?? 'Success!',
        );
      } else {
        final error = response.data?["message"]?.toString();
        return JsonResponse.failure(
          statusCode: response.statusCode ?? 500,
          message: error ?? 'Something went wrong!',
        );
      }
    } on DioException catch (e) {
      final error = e.response?.data?["message"]?.toString();
      return JsonResponse.failure(
        message: error.toString(),
        statusCode: e.response?.statusCode ?? 500,
      );
    } on Exception catch (_) {
      return JsonResponse.failure(
        message: 'Something went wrong!',
      );
    }
  }

  // getLeaves

  Future<JsonResponse> getLeaveRequests({
    required String id,
  }) async {
    try {
      final Response response = await dio.get(
        '/leave-request/$id',
      );
      if (response.statusCode == 200) {
        final data =
            List.from(response.data).map((e) => Leave.fromJson(e)).toList();
        return JsonResponse.success(
          message: 'Leaves Fetched Successfully!',
          data: data,
        );
      } else {
        final error = response.data?["message"]?.toString();
        return JsonResponse.failure(
          statusCode: response.statusCode ?? 500,
          message: error ?? 'Something went wrong!',
        );
      }
    } on DioException catch (e) {
      final error = e.response?.data?["message"]?.toString();
      return JsonResponse.failure(
        message: error.toString(),
        statusCode: e.response?.statusCode ?? 500,
      );
    } on Exception catch (_) {
      return JsonResponse.failure(
        message: 'Something went wrong!',
      );
    }
  }

  // addEmployee
  Future<JsonResponse> addEmployee({
    required String id,
    required String name,
    required String email,
    required String phone,
    required String password,
    required String department,
    required String designation,
  }) async {
    try {
      final Response response = await dio.post(
        '/add-employee',
        data: {
          'id': id,
          'name': name,
          'email': email,
          'phone': phone,
          'password': password,
          'department': department,
          'designation': designation,
        },
      );
      if (response.statusCode == 200) {
        return JsonResponse.success(
          message: response.data?["message"]?.toString() ?? 'Success!',
        );
      } else {
        final error = response.data?["message"]?.toString();
        return JsonResponse.failure(
          statusCode: response.statusCode ?? 500,
          message: error ?? 'Something went wrong!',
        );
      }
    } on DioException catch (e) {
      final error = e.response?.data?["message"]?.toString();
      return JsonResponse.failure(
        message: error.toString(),
        statusCode: e.response?.statusCode ?? 500,
      );
    } on Exception catch (_) {
      return JsonResponse.failure(
        message: 'Something went wrong!',
      );
    }
  }

  // getAllAttendences
  Future<JsonResponse> getAllAttendences({
    required String id,
  }) async {
    try {
      final Response response = await dio.get(
        '/attendences/$id',
      );
      if (response.statusCode == 200) {
        final data = List.from(response.data)
            .map((e) => Attendence.fromJson(e))
            .toList();
        return JsonResponse.success(
          message: 'Attendences Fetched Successfully!',
          data: data,
        );
      } else {
        final error = response.data?["message"]?.toString();
        return JsonResponse.failure(
          statusCode: response.statusCode ?? 500,
          message: error ?? 'Something went wrong!',
        );
      }
    } on DioException catch (e) {
      final error = e.response?.data?["message"]?.toString();
      return JsonResponse.failure(
        message: error.toString(),
        statusCode: e.response?.statusCode ?? 500,
      );
    } on Exception catch (_) {
      return JsonResponse.failure(
        message: 'Something went wrong!',
      );
    }
  }

  // getAllUsers

  Future<JsonResponse> getAllUsers({
    required String organization,
  }) async {
    try {
      final Response response = await dio.get(
        '/users/$organization',
      );
      if (response.statusCode == 200) {
        final data =
            List.from(response.data).map((e) => User.fromJson(e)).toList();
        return JsonResponse.success(
          message: 'Users Fetched Successfully!',
          data: data,
        );
      } else {
        final error = response.data?["message"]?.toString();
        return JsonResponse.failure(
          statusCode: response.statusCode ?? 500,
          message: error ?? 'Something went wrong!',
        );
      }
    } on DioException catch (e) {
      final error = e.response?.data?["message"]?.toString();
      return JsonResponse.failure(
        message: error.toString(),
        statusCode: e.response?.statusCode ?? 500,
      );
    } on Exception catch (_) {
      return JsonResponse.failure(
        message: 'Something went wrong!',
      );
    }
  }

  // updateUser
  Future<JsonResponse> updateUser({
    required String id,
    required String name,
    required String email,
    required String phone,
    required String department,
    required String designation,
    required String organization,
  }) async {
    try {
      var updateObj = {};
      if (id.isNotEmpty) updateObj['id'] = id;
      if (name.isNotEmpty) updateObj['name'] = name;
      if (email.isNotEmpty) updateObj['email'] = email;
      if (phone.isNotEmpty) updateObj['phone'] = phone;
      if (department.isNotEmpty) updateObj['department'] = department;
      if (designation.isNotEmpty) updateObj['designation'] = designation;
      if (organization.isNotEmpty) updateObj['organization'] = organization;

      final Response response = await dio.post(
        '/update-user',
        data: updateObj,
      );

      if (response.statusCode == 200) {
        return JsonResponse.success(
          message: response.data?["message"]?.toString() ?? 'Success!',
        );
      } else {
        final error = response.data?["message"]?.toString();
        return JsonResponse.failure(
          statusCode: response.statusCode ?? 500,
          message: error ?? 'Something went wrong!',
        );
      }
    } on DioException catch (e) {
      final error = e.response?.data?["message"]?.toString();
      return JsonResponse.failure(
        message: error.toString(),
        statusCode: e.response?.statusCode ?? 500,
      );
    } on Exception catch (_) {
      return JsonResponse.failure(
        message: 'Something went wrong!',
      );
    }
  }

  // getUser
  Future<JsonResponse> getUser({
    required String id,
  }) async {
    try {
      final Response response = await dio.get(
        '/$id',
      );

      if (response.statusCode == 200) {
        final data = User.fromJson(response.data ?? <String, dynamic>{});

        return JsonResponse.success(
          message: 'User Fetched Successfully!',
          data: data,
        );
      } else {
        final error = response.data?["message"]?.toString();
        return JsonResponse.failure(
          statusCode: response.statusCode ?? 500,
          message: error ?? 'Something went wrong!',
        );
      }
    } on DioException catch (e) {
      final error = e.response?.data?["message"]?.toString();
      return JsonResponse.failure(
        message: error.toString(),
        statusCode: e.response?.statusCode ?? 500,
      );
    } on Exception catch (_) {
      return JsonResponse.failure(
        message: 'Something went wrong!',
      );
    }
  }

  // approveOrRejectLeave
  Future<JsonResponse> approveOrRejectLeave({
    required String userId,
    required String leaveId,
  }) async {
    try {
      final Response response = await dio.post(
        '/approve-reject-leave',
        data: {
          'userId': userId,
          'leaveId': leaveId,
        },
      );
      if (response.statusCode == 200) {
        return JsonResponse.success(
          message: response.data?["message"]?.toString() ?? 'Success!',
        );
      } else {
        final error = response.data?["message"]?.toString();
        return JsonResponse.failure(
          statusCode: response.statusCode ?? 500,
          message: error ?? 'Something went wrong!',
        );
      }
    } on DioException catch (e) {
      final error = e.response?.data?["message"]?.toString();
      return JsonResponse.failure(
        message: error.toString(),
        statusCode: e.response?.statusCode ?? 500,
      );
    } on Exception catch (_) {
      return JsonResponse.failure(
        message: 'Something went wrong!',
      );
    }
  }

  // downloadAttendence
  Future<JsonResponse> downloadAttendence({
    required String id,
  }) async {
    try {
      final Response response = await dio.get(
        '/attendence-csv/$id',
        options: Options(responseType: ResponseType.bytes),
      );
      if (response.statusCode == 200) {
        var path = await ExternalPath.getExternalStoragePublicDirectory(
            ExternalPath.DIRECTORY_DOCUMENTS);

        final String filePath = '$path/attendence.csv';

        final File file = File(filePath);

        await file.writeAsBytes(response.data as dynamic, flush: true);

        return JsonResponse.success(
          message: 'Attendence Csv Downloaded Successfully!',
        );
      } else {
        final error = response.data?["message"]?.toString();
        return JsonResponse.failure(
          statusCode: response.statusCode ?? 500,
          message: error ?? 'Something went wrong!',
        );
      }
    } on DioException catch (e) {
      final error = e.response?.data?["message"]?.toString();
      return JsonResponse.failure(
        message: error.toString(),
        statusCode: e.response?.statusCode ?? 500,
      );
    } on Exception catch (_) {
      return JsonResponse.failure(
        message: 'Something went wrong!',
      );
    }
  }

  // getAttendencesOfParticularUser

  Future<JsonResponse> getAttendencesOfParticularUser({
    required String id,
  }) async {
    try {
      final Response response = await dio.get(
        '/attendence-by-month-year/$id',
      );

      if (response.statusCode == 200) {
        final data = List.from(response.data)
            .map((e) => AllAttendence.fromJson(e))
            .toList();
        return JsonResponse.success(
          message: 'All Attendences Fetched Successfully!',
          data: data,
        );
      } else {
        final error = response.data?["message"]?.toString();
        return JsonResponse.failure(
          statusCode: response.statusCode ?? 500,
          message: error ?? 'Something went wrong!',
        );
      }
    } on DioException catch (e) {
      final error = e.response?.data?["message"]?.toString();
      return JsonResponse.failure(
        message: error.toString(),
        statusCode: e.response?.statusCode ?? 500,
      );
    } on Exception catch (_) {
      return JsonResponse.failure(
        message: 'Something went wrong!',
      );
    }
  }

  // updateAttendence

  Future<JsonResponse> updateAttendence({
    required String id,
    required String inTime,
    required String outTime,
    required String status,
  }) async {
    try {
      final Response response = await dio.post(
        '/update-attendence',
        data: {
          'id': id,
          'inTime': inTime,
          'outTime': outTime,
          'status': status,
        },
      );
      if (response.statusCode == 200) {
        return JsonResponse.success(
          message: response.data?["message"]?.toString() ?? 'Success!',
        );
      } else {
        final error = response.data?["message"]?.toString();
        return JsonResponse.failure(
          statusCode: response.statusCode ?? 500,
          message: error ?? 'Something went wrong!',
        );
      }
    } on DioException catch (e) {
      final error = e.response?.data?["message"]?.toString();
      return JsonResponse.failure(
        message: error.toString(),
        statusCode: e.response?.statusCode ?? 500,
      );
    } on Exception catch (_) {
      return JsonResponse.failure(
        message: 'Something went wrong!',
      );
    }
  }

  // downloadAttendenceMonthy
  Future<JsonResponse> downloadAttendenceMonthy({
    required String id,
    required int month,
    required int year,
  }) async {
    try {
      final Response response = await dio.post(
        '/attendence-csv-month-wise',
        data: {
          'id': id,
          'month': month,
          'year': year,
        },
        options: Options(responseType: ResponseType.bytes),
      );
      if (response.statusCode == 200) {
        var path = await ExternalPath.getExternalStoragePublicDirectory(
            ExternalPath.DIRECTORY_DOCUMENTS);

        final String filePath = '$path/attendence.csv';

        final File file = File(filePath);

        await file.writeAsBytes(response.data as dynamic, flush: true);

        return JsonResponse.success(
          message: 'Attendence Csv Monthly Downloaded Successfully!',
        );
      } else {
        final error = response.data?["message"]?.toString();
        return JsonResponse.failure(
          statusCode: response.statusCode ?? 500,
          message: error ?? 'Something went wrong!',
        );
      }
    } on DioException catch (e) {
      final error = e.response?.data?["message"]?.toString();
      return JsonResponse.failure(
        message: error.toString(),
        statusCode: e.response?.statusCode ?? 500,
      );
    } on Exception catch (_) {
      return JsonResponse.failure(
        message: 'Something went wrong!',
      );
    }
  }

  // getAttendenceWithDateRange
  Future<JsonResponse> getAttendenceWithDateRange({
    required String id,
    required String startDate,
    required String endDate,
  }) async {
    try {
      final Response response = await dio.post(
        '/attendence-by-date-range',
        data: {
          'id': id,
          'startDate': startDate,
          'endDate': endDate,
        },
      );

      if (response.statusCode == 200) {
        final data = List.from(response.data)
            .map((e) => Attendence.fromJson(e))
            .toList();
        return JsonResponse.success(
          message: 'Attendences Fetched Successfully For Date Range!',
          data: data,
        );
      } else {
        final error = response.data?["message"]?.toString();
        return JsonResponse.failure(
          statusCode: response.statusCode ?? 500,
          message: error ?? 'Something went wrong!',
        );
      }
    } on DioException catch (e) {
      final error = e.response?.data?["message"]?.toString();
      return JsonResponse.failure(
        message: error.toString(),
        statusCode: e.response?.statusCode ?? 500,
      );
    } on Exception catch (_) {
      return JsonResponse.failure(
        message: 'Something went wrong!',
      );
    }
  }


   // updateAttendences

  Future<JsonResponse> updateAttendences({
    required List<String> ids,
    required String inTime,
    required String outTime,
    required String status,
  }) async {
    try {
      final Response response = await dio.post(
        '/update-attendences',
        data: {
          'ids': ids,
          'inTime': inTime,
          'outTime': outTime,
          'status': status,
        },
      );
      if (response.statusCode == 200) {
        return JsonResponse.success(
          message: response.data?["message"]?.toString() ?? 'Success!',
        );
      } else {
        final error = response.data?["message"]?.toString();
        return JsonResponse.failure(
          statusCode: response.statusCode ?? 500,
          message: error ?? 'Something went wrong!',
        );
      }
    } on DioException catch (e) {
      final error = e.response?.data?["message"]?.toString();
      return JsonResponse.failure(
        message: error.toString(),
        statusCode: e.response?.statusCode ?? 500,
      );
    } on Exception catch (_) {
      return JsonResponse.failure(
        message: 'Something went wrong!',
      );
    }
  }
}



// final String dir = (await getExternalStorageDirectory())!.path;
//final String dir = (await getApplicationDocumentsDirectory()).path;
// Save the file to the download directory
// final String filePath = '$dir/attendence.csv';
// final File file = File(filePath);
 