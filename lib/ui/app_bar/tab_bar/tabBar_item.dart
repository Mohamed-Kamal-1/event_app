import 'package:flutter/material.dart';

import '../../../../core/colors/app_color.dart';

class TabbarItem extends StatefulWidget {
  final String title;
  final IconData icon;
  final int index;
  final int currentIndex;
   TabbarItem({
    required this.title,
    required this.icon,
    required this.index,
    required this.currentIndex,
  });

  @override
  State<TabbarItem> createState() => _TabbarItemState();
}

class _TabbarItemState extends State<TabbarItem> {
  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color:  (widget.currentIndex == widget.index) ? Colors.white :  Colors.transparent, //inside:,
        border: Border.all(width: 1, color: Colors.white), // border
        borderRadius: BorderRadius.circular(46),
      ),
      child: Row(
        children: [
          Icon(
            widget.icon,
            color: widget.currentIndex == widget.index
                ? AppColor.bluePrimaryColor //inside icon when select
                : Colors.white,
          ),
          const SizedBox(width: 10),
          Text(
            widget.title,
            style: textTheme.titleSmall?.copyWith(
              color: widget.currentIndex == widget.index
                  ? AppColor.bluePrimaryColor // inside text when select
                  : Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
