import 'package:evently_app/core/images/app_image.dart';
import 'package:evently_app/providers/app_auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

import '../../../../core/routes/app_routes.dart';

class ProfileTab extends StatefulWidget {

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  String selectedLanguage = 'Arabic';
  String selectedTheme = 'Light';

  @override
  Widget build(BuildContext context) {
    AppAuthProvider appAuthProvider = Provider.of<AppAuthProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Color(0xFF5C6BFF),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                ),
              ),
              child: Row(
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
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "John Safwat",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "johnsafwat.route@gmail.com",
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: const Text(
                  "Language",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            _buildDropdown(
              value: selectedLanguage,
              items: const ['Arabic', 'English'],
              onChanged: (value) {
                setState(() => selectedLanguage = value!);
              },
            ),

            const SizedBox(height: 30),

            // ---------------- Theme ----------------
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: const Text(
                  "Theme",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            _buildDropdown(
              value: selectedTheme,
              items: const ['Light', 'Dark'],
              onChanged: (value) {
                setState(() => selectedTheme = value!);
              },
            ),

            const Spacer(),

            // ---------------- Logout ----------------
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
      ),
    );
  }

  // ---------------- Dropdown Builder ----------------
  Widget _buildDropdown({
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blueAccent),
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButton<String>(
        isExpanded: true,
        dropdownColor: const Color(0xFF1A1B3C),
        value: value,
        underline: const SizedBox(),
        icon: const Icon(
          Icons.keyboard_arrow_down_outlined,
          color: Colors.blueAccent,
        ),
        style: const TextStyle(color: Colors.blueAccent, fontSize: 16),
        onChanged: onChanged,
        items: items
            .map((item) => DropdownMenuItem(value: item, child: Text(item)))
            .toList(),
      ),
    );
  }
}
