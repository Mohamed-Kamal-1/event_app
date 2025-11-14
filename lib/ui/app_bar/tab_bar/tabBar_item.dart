import 'package:evently_app/extensions/extension_home_screen.dart';
import 'package:flutter/material.dart';

import '../../../../core/colors/app_color.dart';

class TabBarItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final int index;
  final int currentIndex;
  final bool reverse;

  TabBarItem({
    required this.reverse,
    required this.title,
    required this.icon,
    required this.index,
    required this.currentIndex,
  });

  bool get isSelected => index == currentIndex;

  @override
  Widget build(BuildContext context) {
    final Color borderColor = reverse
        ? AppColor.bluePrimaryColor
        : Colors.white;

    final Color backgroundColor = reverse
        ? (isSelected ? AppColor.bluePrimaryColor : Colors.transparent)
        : (isSelected ? Colors.white : Colors.transparent);
    final Color iconAndTextColor = reverse
        ? (isSelected ? Colors.white : AppColor.bluePrimaryColor)
        : (isSelected ? AppColor.bluePrimaryColor : Colors.white);

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(width: 1, color: borderColor),
        borderRadius: BorderRadius.circular(46),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: iconAndTextColor,

          ),
          const SizedBox(width: 10),
          Text(
            title,
            style: context.fonts.titleSmall?.copyWith(
              // color: (!reverse) ?  ((currentIndex == index) ?  AppColor.bluePrimaryColor : Colors.white ) : ((currentIndex == index) ?  Colors.white : AppColor.bluePrimaryColor),
              color: iconAndTextColor,
              // color: widget.currentIndex == widget.index
              //     ? AppColor.bluePrimaryColor // inside text when select
              //     : Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
