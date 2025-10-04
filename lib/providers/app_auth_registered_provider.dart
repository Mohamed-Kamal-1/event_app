import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_app/database/model/app_user.dart';
import 'package:evently_app/database/model/user_dao.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
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
      AppUser user = AppUser(
        userId: credential.user?.uid,
        email: email,
        name: name,
        phone: phone
      );

      await UserDao.addUser(user);
      return AuthResponse(success: true, cred: credential,user: user);

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
  AppUser? user;

  AuthResponse({required this.success, this.failure, this.cred,this.user});
}

enum AuthFailure {
  weakPassword('weak-password'),
  emailAlreadyExist('email-already-in-use'),
  general('general');

  final String code;

  const AuthFailure(this.code);
}
