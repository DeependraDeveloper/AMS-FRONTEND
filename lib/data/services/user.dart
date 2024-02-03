import 'package:amsystm/data/models/attendence.dart';
import 'package:amsystm/data/models/json_reposne.dart';
import 'package:amsystm/data/models/leave.dart';
import 'package:amsystm/data/models/user.dart';
import 'package:amsystm/utils/constants.dart';
import 'package:dio/dio.dart';

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
    dio.interceptors.add(LogInterceptor());
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
}
