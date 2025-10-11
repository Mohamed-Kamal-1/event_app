import 'package:evently_app/core/icons/app_icon.dart';
import 'package:evently_app/logic/switch_language_and_theme/switch_language.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

import '../../core/colors/app_color.dart';
import '../../core/images/app_image.dart';
import '../../core/routes/app_routes.dart';
import '../../l10n/app_localizations.dart';
import '../../providers/app_auth_registered_provider.dart';
import '../../providers/app_auth_signIn_provider.dart';
import  'app_form/app_form_login_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {


// // **ملاحظة:** يجب أن تكون هذه الدالة ضمن Widget (عادةً StatefulWidget)
// // للوصول إلى `mounted` و `ScaffoldMessenger.of(context)`.
//
// // 1. **تعريف كائن GoogleSignIn:** يفضل تعريفه مرة واحدة مع تحديد النطاقات
//   final GoogleSignIn _googleSignIn = GoogleSignIn(
//     scopes: <String>[
//       'email', // نطاق ضروري لجلب البريد الإلكتروني
//       'profile', // نطاق ضروري لجلب معلومات الملف الشخصي
//     ],
//   );
//
//   Future<void> _handleGoogleSignIn(BuildContext context, bool mounted) async {
//     try {
//       // 2. **بدء عملية تسجيل الدخول:** نستخدم .signIn() بعد تهيئة النطاقات
//       final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
//
//       if (googleUser == null) {
//         print('User cancelled the Google sign-in process.');
//         return;
//       }
//
//       // 3. **جلب رموز المصادقة:**
//       final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
//
//       // 💡 **تحقق قبل الاستخدام:** يجب التأكد من وجود الـ idToken على الأقل
//       if (googleAuth.idToken == null) {
//         print('Error: Failed to retrieve ID Token. Check Firebase setup.');
//         // يمكنك إظهار رسالة خطأ للمستخدم هنا
//         return;
//       }
//
//       // 4. **إنشاء بيانات اعتماد Firebase:**
//       final AuthCredential credential = GoogleAuthProvider.credential(
//         // ⬅️ تم تصحيح الخطأ هنا. القيمة الصحيحة هي googleAuth.accessToken
//         accessToken: googleAuth.accessToken,
//         idToken: googleAuth.idToken,
//       );
//
//       // 5. **تسجيل الدخول إلى Firebase:**
//       final UserCredential userCredential = await FirebaseAuth.instance
//           .signInWithCredential(credential);
//
//       if (userCredential.user != null && mounted) {
//         print("Sign-in successful: ${userCredential.user?.displayName}");
//         // Navigator.pushReplacementNamed(context, AppRoutes.HomeScreen.name);
//
//         // مثال: إظهار رسالة نجاح
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('تم تسجيل الدخول بنجاح!')),
//         );
//       }
//     } catch (e) {
//       print("Error during Google sign-in: $e");
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//               content: Text(
//                   'فشل تسجيل الدخول عبر Google. الرجاء التأكد من إعدادات SHA-1 أو الاتصال بالإنترنت.')),
//         );
//       }
//     }
//   }
//





  @override
  Widget build(BuildContext context) {

    // AppAuthProviderWithGoogle appAuthProviderWithGoogle = Provider.of<AppAuthProviderWithGoogle>(context);
    TextTheme textTheme = Theme.of(context).textTheme;
    AppLocalizations? appLocale = AppLocalizations.of(context);

    return Scaffold(

      appBar: AppBar(
        foregroundColor: AppColor.bluePrimaryColor,
        title: Text(
          textAlign: TextAlign.center,
          appLocale!.login,
          style: textTheme.titleMedium?.copyWith(
            color: AppColor.bluePrimaryColor,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                children: [
                  Image.asset(AppImage.registerLogo, fit: BoxFit.cover),
                  Text(
                    appLocale.evently,
                    style: GoogleFonts.jockeyOne(
                      textStyle: textTheme.headlineMedium,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24),

              AppFormLoginScreen(),
              SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(appLocale.doNotHaveAccount,style: textTheme.titleSmall,),
                  SizedBox(width: 10,),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.RegistrScreen.name);
                    },
                    child: Text(
                      appLocale.createAccount,
                      style: textTheme.titleSmall?.copyWith(
                        fontStyle: FontStyle.italic,
                        color: AppColor.bluePrimaryColor,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 34,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Text(appLocale.or),

                  Container(color: AppColor.offWhite,
                  margin: EdgeInsets.symmetric(
                      horizontal: 20
                  ),
                  height: 1.5,
                  width: 129,
                  ),
                  Text(appLocale.or,style: textTheme.titleSmall?.copyWith(
                    color: AppColor.bluePrimaryColor
                  )),
                  Container(color: AppColor.offWhite,
                    margin: EdgeInsets.symmetric(
                        horizontal: 20
                    ),
                  height: 1.5,
                  width: 129,
                  ),

                ],
              ),
              SizedBox(height: 24,),
              InkWell(
                onTap: (){

                },
                child: Container(
                  height: 57.67,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(
                      width: 1.5,
                      color: AppColor.bluePrimaryColor
                    ),
                    borderRadius: BorderRadius.circular(16)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(AppIcon.ic_google),
                      SizedBox(width: 15,),
                      Text('Login With Google',style: textTheme.titleMedium?.copyWith(
                        color: AppColor.bluePrimaryColor
                      ),),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 24,),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.26,
                  child: AppSwitchLanguage()),
            ],
          ),
        ),
      ),
    );
  }
}