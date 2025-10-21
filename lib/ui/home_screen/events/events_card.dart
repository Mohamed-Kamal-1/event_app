import 'package:evently_app/extensions/extension_home_screen.dart';
import 'package:flutter/material.dart';

import '../../../core/colors/app_color.dart';
import '../../../core/images/app_image.dart';

class EventsCard extends StatelessWidget {
  const EventsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 203.06,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: AssetImage(AppImage.birthday),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 50,
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.all(8),
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColor.whitePrimaryColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '21',
                  style: context.fonts.titleMedium?.copyWith(
                      color: AppColor.bluePrimaryColor
                  ),
                ),
                Text(
                    'Nov',
                    style: context.fonts.titleSmall?.copyWith(
                        color: AppColor.bluePrimaryColor
                    )
                ),
              ],
            ),
          ),

          Container(
            height: 49,
            margin: EdgeInsets.all(8),
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColor.whitePrimaryColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'This is a Birthday Party',
                  style: context.fonts.titleSmall,
                ),
                Icon(
                  Icons.favorite,
                  size: 34,
                  color: AppColor.bluePrimaryColor,
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
