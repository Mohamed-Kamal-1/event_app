import 'package:evently_app/core/images/app_image.dart';
import 'package:evently_app/extensions/extension_home_screen.dart';
import 'package:evently_app/providers/app_auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

import '../../../../core/routes/app_routes.dart';

class ProfileTab extends StatelessWidget {

  final String selectedLanguage = 'Arabic';

  final String selectedTheme = 'Light';

  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {

    AppAuthProvider appAuthProvider = Provider.of<AppAuthProvider>(context);
    String?  user = appAuthProvider.getUser()?.name;
    String?  email = appAuthProvider.getUser()?.email;
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 220,
            padding: const EdgeInsets.all(20),
            decoration:  BoxDecoration(
              color:context.color.onSecondaryFixedVariant,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(100),
                    bottomLeft: Radius.circular(100),
                    bottomRight: Radius.circular(100),

                  ),
                  child: Image.asset(AppImage.profile,

                    fit: BoxFit.cover,
                    width: 124,
                  ),
                ),
                const SizedBox(width: 16),
                Padding(
                  padding: EdgeInsets.only(top: 32),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FittedBox(
                        child: Text(
                          user ?? "",
                          style: const TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      // const SizedBox(height: 8),
                      Text(
                        email ?? "",
                        style: const TextStyle(
                            color: Colors.white, fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),

          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 20.0),
          //   child: Align(
          //     alignment: Alignment.centerLeft,
          //     child: const Text(
          //       "Language",
          //       style: TextStyle(
          //         color: Colors.white,
          //         fontWeight: FontWeight.bold,
          //         fontSize: 16,
          //       ),
          //     ),
          //   ),
          // ),
          // const SizedBox(height: 10),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 20.0),
          //   child: Align(
          //     alignment: Alignment.centerLeft,
          //     child: const Text(
          //       "Theme",
          //       style: TextStyle(
          //         color: Colors.white,
          //         fontWeight: FontWeight.bold,
          //         fontSize: 16,
          //       ),
          //     ),
          //   ),
          // ),
          // const SizedBox(height: 10),


          const Spacer(),

          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 20,
            ),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: () {
                  appAuthProvider.logout();
                  Navigator.pushReplacementNamed(
                    context,
                    AppRoutes.LoginScreen.name,
                  );
                },
                icon: const Icon(Iconsax.logout_outline, color: Colors.white),
                label: const Text(
                  "Logout",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF5C5C),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
