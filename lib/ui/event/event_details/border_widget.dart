import 'package:flutter/material.dart';

import '../../../core/colors/app_color.dart';

class BorderWidget extends StatelessWidget {
  Widget child;

  IconData icon;

  BorderWidget({super.key, required this.child, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColor.bluePrimaryColor, width: 2),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColor.bluePrimaryColor,
              borderRadius: BorderRadius.circular(8),
            ),

            child: Icon(icon, color: Colors.white, size: 24),
          ),
          SizedBox(width: 10),
          child,
        ],
      ),
    );
  }
}
