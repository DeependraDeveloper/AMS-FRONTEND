import 'package:amsystm/data/models/json_reposne.dart';
import 'package:amsystm/data/services/user.dart';

abstract class UserRepository {
  Future<JsonResponse> signIn({
    required int phone,
    required String password,
  });

  Future<JsonResponse> resetPasswrod({
    required int phone,
    required String password,
    required String confirmPassword,
  });
}

class UserRepositoryImpl implements UserRepository {
  const UserRepositoryImpl({required this.userService});

  final UserService userService;

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
}
