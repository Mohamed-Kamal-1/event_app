import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AppAuthProvider extends ChangeNotifier {
  final _authService = FirebaseAuth.instance;

  Future<AuthResponse> register(
    String email,
    String pass,
    String name,
    String phone,
  ) async {
    try {
      final credential = await _authService.createUserWithEmailAndPassword(
        email: email,
        password: pass,
      );

      return AuthResponse(success: true, cred: credential);
    } on FirebaseAuthException catch (e) {
      if (e.code == AuthFailure.weakPassword.code) {
        return AuthResponse(success: false, failure: AuthFailure.weakPassword);
      } else if (e.code == AuthFailure.emailAlreadyExist.code) {
        return AuthResponse(
          success: false,
          failure: AuthFailure.emailAlreadyExist,
        );
      } else {
        return AuthResponse(success: false, failure: AuthFailure.general);
      }
    } catch (e) {
      return AuthResponse(success: false, failure: AuthFailure.general);
    }
  }
}

class AuthResponse {
  bool success;
  AuthFailure? failure;
  UserCredential? cred;

  AuthResponse({required this.success, this.failure, this.cred});
}

enum AuthFailure {
  weakPassword('weak-password'),
  emailAlreadyExist('email-already-in-use'),
  general('general');

  final String code;

  const AuthFailure(this.code);
}
