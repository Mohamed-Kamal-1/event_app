import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../database/model/app_user.dart';
import '../database/model/user_dao.dart';

class AuthSignIn {
  final _firebaseAuth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn.instance;

  Future<UserCredential?> signinwithGoogle() async {
    try {
      await _googleSignIn.initialize();
      final account = await _googleSignIn.authenticate();
      final auth = account.authentication;
      final cred = GoogleAuthProvider.credential(idToken: auth.idToken);
      UserCredential? userCredential = await _firebaseAuth.signInWithCredential(
        cred,
      );
      AppUser user = AppUser(
        userId: userCredential.user?.uid,
        email: userCredential.user?.email,
        name: userCredential.user?.displayName,
        phone: userCredential.user?.phoneNumber,
      );
      await UserDao.addUser(user);
      return userCredential;
    } catch (e) {
      return null;
    }
  }
}
