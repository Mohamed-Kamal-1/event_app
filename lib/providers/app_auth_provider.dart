import 'package:evently_app/database/model/app_user.dart';
import 'package:evently_app/database/model/user_dao.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../database/model/event.dart';

class AppAuthProvider extends ChangeNotifier {
  late FirebaseAuth _authService = FirebaseAuth.instance;
  User? _fbAuthUser = FirebaseAuth.instance.currentUser;
  AppUser? _databaseUser;
  final _googleSignIn = GoogleSignIn.instance;

  void authServiceAfterLogin(FirebaseAuth authServiceAfterLogin) {
    _authService = authServiceAfterLogin;
  }

  AppAuthProvider() {
    retrieveUserFormDatabase();
  }

  Future<void> retrieveUserFormDatabase() async {
    if (_fbAuthUser != null) {
      _databaseUser = await UserDao.getUserById(_fbAuthUser?.uid);
      notifyListeners();
    }
  }

  Future<void> loadUserAfterLogin(String userId) async {
    _databaseUser = await UserDao.getUserById(userId);
    notifyListeners();
  }
  bool isFavorite(Event event){
    return _databaseUser?.favorites.contains(event.id)?? false;
  }
  AppUser? getUser() {
    return _databaseUser;
  }
  void updateFavorites(List<String> favorites){
    _databaseUser?.favorites = favorites;
  }

  bool isLoggedInBefore() {
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return false;
    }

    return true;
  }


  void logout() {
    _authService.signOut();
    _fbAuthUser = null;
    _databaseUser = null;
    notifyListeners();
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

  static final _google = GoogleSignIn.instance;
  static bool isInitialize = false;

  static Future<void> _initSignIn() async {
    if (!isInitialize) {
      _google.initialize(
        serverClientId:
            "406099696497-a12gakvts4epfk5pkio7dphc1anjiggc.apps.googleusercontent.com",
      );
    }
    isInitialize = true;
  }

  Future<UserCredential?> signinwithGoogle() async {
    try {
      await _googleSignIn.initialize();
      final account = await _googleSignIn.authenticate();
      final auth = account.authentication;
      final cred = GoogleAuthProvider.credential(idToken: auth.idToken);
      UserCredential? userCredential = await _authService.signInWithCredential(
        cred,
      );
      AppUser user = AppUser(
        userId: userCredential.user?.uid,
        email: userCredential.user?.email,
        name: userCredential.user?.displayName,
        phone: userCredential.user?.phoneNumber,
      );
      await UserDao.addUser(user);
      loadUserAfterLogin(userCredential.user!.uid);
      notifyListeners();
      return userCredential;
    } catch (e) {
      return null;
    }
  }

  // Future<UserCredential?> signInWithGoogle() async {
  //   _initSignIn();
  //
  //   GoogleSignInAccount account = await _google.authenticate();
  //   final String? idToken = account.authentication.idToken;
  //   final GoogleSignInAuthorizationClient authClient =
  //       account.authorizationClient;
  //   final GoogleSignInClientAuthorization? auth = await authClient
  //       .authorizationForScopes(['email', 'profile']);
  //
  //   String? accessToken = auth?.accessToken;
  //   OAuthCredential credential = GoogleAuthProvider.credential(idToken: idToken,accessToken: accessToken);
  //   UserCredential  userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
  //   return userCredential;
  //   // AppUser user = AppUser(
  //   //   userId: userCredential.user?.uid,
  //   //   email: userCredential.user?.email,
  //   //   name: userCredential.user?.displayName,
  //   //   phone: userCredential.user?.phoneNumber,
  //   // );
  //   // await UserDao.addUser(user);
  //
  //   //
  //   // AppUser? reciveUser = await UserDao.getUserById(userCredential.user?.uid);
  //   // print('====================================================');
  //   // print("User is $reciveUser");
  //   // print('====================================================');
  //
  //   // try {
  //   //   await _googleSignIn.initialize();
  //   //   final account = await _googleSignIn.authenticate();
  //   //   final auth = account.authentication;
  //   //   final cred = GoogleAuthProvider.credential(idToken: auth.idToken);
  //   //   final credential = _authService.signInWithCredential(cred);
  //   //   return await credential;
  //   // } catch (e) {
  //   //   return null;
  //   // }
  // }
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
