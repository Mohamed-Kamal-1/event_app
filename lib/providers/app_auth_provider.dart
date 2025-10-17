import 'package:evently_app/database/model/app_user.dart';
import 'package:evently_app/database/model/user_dao.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AppAuthProvider extends ChangeNotifier {
  final _authService = FirebaseAuth.instance;
  User? fbAuthUser = FirebaseAuth.instance.currentUser;

  final _googleSignIn = GoogleSignIn.instance;

  AppUser? databaseUser;

  AppAuthProvider() {
    retrieveUserFormDatabase();
  }

  Future<void> retrieveUserFormDatabase() async {
    if (fbAuthUser != null) {
      databaseUser = await UserDao.getUserById(fbAuthUser?.uid);
    }
  }

  bool isLoggedInBefore() {
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return false;
    }

    return true;
  }

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
        phone: phone,
      );

      await UserDao.addUser(user);
      return AuthResponse(success: true, cred: credential, user: user);
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

  Future<AuthResponse> signIn(String email, String pass) async {
    try {
      final credential = await _authService.signInWithEmailAndPassword(
        email: email,
        password: pass,
      );

      AppUser? user = await UserDao.getUserById(credential.user!.uid);

      return AuthResponse(success: true, cred: credential, user: user);
    } on FirebaseAuthException catch (e) {
      if (e.code == AuthFailure.invalidCredentials.code) {
        return AuthResponse(
          success: false,
          failure: AuthFailure.invalidCredentials,
        );
      }
    }
    return AuthResponse(success: false, failure: AuthFailure.general);
  }




  Future<UserCredential?> signInWithGoogle() async {
    try {
      await _googleSignIn.initialize();
      final account = await _googleSignIn.authenticate();
      final auth = account.authentication;
      final cred = GoogleAuthProvider.credential(idToken: auth.idToken);
       final credential = _authService.signInWithCredential(cred);

      return await credential;
    } catch (e) {
      return null;
    }
  }
}

class AuthResponse {
  bool success;
  AuthFailure? failure;
  UserCredential? cred;
  AppUser? user;

  AuthResponse({required this.success, this.failure, this.cred, this.user});
}

enum AuthFailure {
  weakPassword('weak-password'),
  emailAlreadyExist('email-already-in-use'),
  invalidCredentials('invalid-credential'),
  general('general');

  final String code;

  const AuthFailure(this.code);
}
