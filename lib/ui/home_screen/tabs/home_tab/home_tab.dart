
import 'package:evently_app/ui/home_screen/tabs/home_tab/event_home_tap.dart';
import 'package:evently_app/ui/home_screen/tabs/home_tab/stream_update_widget.dart';
import 'package:flutter/material.dart';

class HomeTab extends StatelessWidget {
  HomeTab();

  int selectedCategoryIndex = 0;



  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 16,
      children: [
      EventHomeTap(selectedCategoryIndex: selectedCategoryIndex,),
        Expanded(
          child:StreamUpdateWidget(selectedCategoryIndex: selectedCategoryIndex,),
        ),
      ],
    );
  }
}
