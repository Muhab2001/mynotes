import 'package:mynotes/services/auth/auth_user.dart';

abstract class AuthProvider {
  Future<void> intialize();
  // user getter
  AuthUser? get currentUser;
  // abstract method
  Future<AuthUser?> login({
    required String email,
    required String password,
  });
  Future<AuthUser> createUser({
    required String email,
    required String password,
  });
  Future<void> logOut();
  Future<void> sendEmailVerification();
  Future<void> sendPasswordReset({required String toEmail});
}
