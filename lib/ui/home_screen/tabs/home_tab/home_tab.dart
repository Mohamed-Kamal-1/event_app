import 'package:evently_app/core/colors/app_color.dart';
import 'package:evently_app/core/images/app_image.dart';
import 'package:evently_app/extensions/extension_home_screen.dart';
import 'package:evently_app/ui/home_screen/events/events_card.dart';
import 'package:flutter/material.dart';

class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) => EventsCard(),
              separatorBuilder: (context, index) => SizedBox(height: 16),
              itemCount: 15,
            ),
          ),
        ],
      ),
    );
  }
}
