import 'package:evently_app/core/images/app_image.dart';
import 'package:flutter/material.dart';

class RegistrScreen extends StatelessWidget {
  const RegistrScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Column(
        children: [
          Flex(direction: Axis.vertical,
            children: [
              Image.asset(AppImage.logo),
              Text('Evently'),
            ],


          ),

        ],
      ),
    );
  }
}
