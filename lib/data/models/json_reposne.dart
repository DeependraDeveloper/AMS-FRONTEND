import 'package:equatable/equatable.dart';

class JsonResponse extends Equatable {
  final String message;
  final bool success;
  final int statusCode;
  final Object? data;

  const JsonResponse({
    required this.message,
    required this.success,
    required this.statusCode,
    this.data,
  });

  JsonResponse copyWith({
    String? message,
    bool? success,
    int? statusCode,
    Object? data,
  }) =>
      JsonResponse(
        message: message ?? this.message,
        success: success ?? this.success,
        statusCode: statusCode ?? this.statusCode,
        data: data ?? this.data,
      );

  factory JsonResponse.success({String message = 'success', Object? data}) =>
      JsonResponse(
        success: true,
        statusCode: 200,
        message: message,
        data: data,
      );

  factory JsonResponse.failure(
          {int statusCode = 500, String message = 'failure', Object? data}) =>
      JsonResponse(
        success: false,
        statusCode: statusCode,
        message: message,
        data: data,
      );

  factory JsonResponse.fromJson(Map<String, dynamic> json) => JsonResponse(
        message: json['message'] as String,
        success: json['success'] as bool,
        statusCode: json['statusCode'] as int,
        data: json['data'] as Object?,
      );

  Map<String, dynamic> toJson() => {
        'message': message,
        'success': success,
        'statusCode': statusCode,
        'data': data,
      };

  @override
  List<Object?> get props => [
        message,
        success,
        statusCode,
        data,
      ];
}
