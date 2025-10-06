import 'package:evently_app/database/model/app_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AppAuthProvider extends ChangeNotifier {
  final _authService = FirebaseAuth.instance;
  Future<AuthResponse> signIn(
    String email,
    String pass,

  ) async {
    try {

      final credential = await _authService.signInWithEmailAndPassword(
        email: email,
        password: pass,
      );



      return AuthResponse(success: true, cred: credential);

    } on FirebaseAuthException catch (e) {
      if (e.code == AuthFailure.userNotFound.code) {
        return AuthResponse(success: false, failure: AuthFailure.userNotFound);
      } else if (e.code == AuthFailure.wrongPassword.code) {
        return AuthResponse(
          success: false,
          failure: AuthFailure.wrongPassword,
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
  AppUser? user;

  AuthResponse({required this.success, this.failure, this.cred,this.user});
}

enum AuthFailure {
  userNotFound('user-not-found'),
  wrongPassword('wrong-password'),
  general('general');

  final String code;

  const AuthFailure(this.code);
}
