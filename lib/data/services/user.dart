import 'dart:math';

import 'package:amsystm/data/models/json_reposne.dart';
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
}
