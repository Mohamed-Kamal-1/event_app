// // // // import 'package:evently_app/database/model/app_user.dart';
// // // // import 'package:firebase_auth/firebase_auth.dart';
// // // // import 'package:flutter/cupertino.dart';
// // // //
// // // // class AppAuthProvider extends ChangeNotifier {
// // // //   final _authService = FirebaseAuth.instance;
// // // //   Future<AuthResponse> signIn(
// // // //     String email,
// // // //     String pass,
// // // //
// // // //   ) async {
// // // //     try {
// // // //
// // // //       final credential = await _authService.signInWithEmailAndPassword(
// // // //         email: email,
// // // //         password: pass,
// // // //       );
// // // //
// // // //
// // // //
// // // //       return AuthResponse(success: true, cred: credential);
// // // //
// // // //     } on FirebaseAuthException catch (e) {
// // // //       if (e.code == AuthFailure.userNotFound.code) {
// // // //         return AuthResponse(success: false, failure: AuthFailure.userNotFound);
// // // //       } else if (e.code == AuthFailure.wrongPassword.code) {
// // // //         return AuthResponse(
// // // //           success: false,
// // // //           failure: AuthFailure.wrongPassword,
// // // //         );
// // // //       } else {
// // // //         return AuthResponse(success: false, failure: AuthFailure.general);
// // // //       }
// // // //     } catch (e) {
// // // //       return AuthResponse(success: false, failure: AuthFailure.general);
// // // //     }
// // // //   }
// // // // }
// // // //
// // // // class AuthResponse {
// // // //   bool success;
// // // //   AuthFailure? failure;
// // // //   UserCredential? cred;
// // // //   AppUser? user;
// // // //
// // // //   AuthResponse({required this.success, this.failure, this.cred,this.user});
// // // // }
// // // //
// // // // enum AuthFailure {
// // // //   userNotFound('user-not-found'),
// // // //   wrongPassword('wrong-password'),
// // // //   general('general');
// // // //
// // // //   final String code;
// // // //
// // // //   const AuthFailure(this.code);
// // // // }
// // // import 'package:firebase_auth/firebase_auth.dart';
// // // import 'package:flutter/cupertino.dart';
// // // import 'package:google_sign_in/google_sign_in.dart';
// // //
// // // class AppAuthProviderWithGoogle extends ChangeNotifier {
// // //   static String? webClientId =
// // //       "233691880915-3nhq0h85cb996cf9cmq2j9eqaofv05a8.apps.googleusercontent.com";
// // //
// // //   static final GoogleSignIn googleSignIn = GoogleSignIn.instance;
// // //
// // //   static late bool isInitialize = false;
// // //
// // //   static Future<void> initSignin() async {
// // //     if (!isInitialize) {
// // //       await googleSignIn.initialize(serverClientId: webClientId);
// // //     }
// // //     isInitialize = true;
// // //   }
// // //
// // //   static Future<UserCredential> signinWithGoogle() async {
// // //     await initSignin();
// // //     final GoogleSignInAccount account = await googleSignIn.authenticate();
// // //
// // //     throw FirebaseAuthException(
// // //       code: 'SIGNIN ABORTED BY USER',
// // //       message: 'ignin incompleted',
// // //     );
// // //
// // //
// // //     final idTaken = account.authentication.idToken;
// // //     final authClient = account.authorizationClient;
// // //     GoogleSignInClientAuthorization? auth = await authClient.authorizationForScopes(['email','profile']);
// // //   }
// // // }
// //
// //
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:flutter/cupertino.dart';
// // import 'package:google_sign_in/google_sign_in.dart';
// //
// // class AppAuthProviderWithGoogle extends ChangeNotifier{
// //   Future<UserCredential?> loginWithGoogle()async {
// //     try{
// //       final GoogleSignInAccount? googleUser = await GoogleSignIn.instance.authenticate();
// //
// //       if(googleUser == null){
// //         return null;
// //       }
// //       final GoogleSignInAuthentication googleAuth = googleUser.authentication;
// //       final credential = GoogleAuthProvider.credential(accessToken: googleAuth.idToken ,idToken: googleAuth.idToken);
// //       return await FirebaseAuth.instance.signInWithCredential(credential);
// //     }
// //     catch(e){
// //       return null;
// //     }
// //   }
// // }
//
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';
//
// class AppAuthProviderWithGoogle extends ChangeNotifier {
//
//   Future<void> _handleGoogleSignIn() async {
//     try {
//       final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
//
//       if (googleUser == null) {
//         print('User cancelled the Google sign-in process.');
//         return;
//       }
//
//       final GoogleSignInAuthentication googleAuth = await googleUser
//           .authentication;
//       final AuthCredential credential = GoogleAuthProvider.credential(
//         accessToken: googleAuth.accessToken,
//         idToken: googleAuth.idToken,
//       );
//       final UserCredential userCredential = await FirebaseAuth.instance
//           .signInWithCredential(credential);
//
//       if (userCredential.user != null &&
//           mounted) { // 'mounted' checks if the widget is still in the tree
//         print("Sign-in successful: ${userCredential.user?.displayName}");
//         // Navigator.pushReplacementNamed(context, AppRoutes.HomeScreen.name);
//       }
//     } catch (e) {
//       print("Error during Google sign-in: $e");
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//               content: Text(
//                   'Failed to sign in with Google. Please try again.')),
//         );
//       }
//     }
//   }
// }