import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/routes/app_routes.dart';
import '../../../../database/model/EventsDao.dart';
import '../../../../database/model/category.dart';
import '../../../../providers/app_auth_provider.dart';
import '../../events/events_card.dart';

class StreamUpdateWidget extends StatelessWidget {
  final int selectedCategoryIndex;
   StreamUpdateWidget({super.key,required this.selectedCategoryIndex});
  final List<Category> allCategories = Category.getCategories(includeAll: true);

  @override
  Widget build(BuildContext context) {
    AppAuthProvider provider = Provider.of<AppAuthProvider>(context);

    return  StreamBuilder(
      stream: EventsDao.getRealTimeUpdatesForEvents(
        allCategories[selectedCategoryIndex].id != 0
            ? allCategories[selectedCategoryIndex].id
            : null,
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Something went Wrong"));
        }
        var events = snapshot.data?.toList();
        events?.forEach((element) {});
        if (events == null || events.isEmpty == true) {
          return Center(
            child: Text(
              "No Events Found",
              style: TextStyle(color: Colors.black),
            ),
          );
        }
        return ListView.separated(
          itemBuilder: (context, index) {
            var event = events[index];
            var isFavorite = provider.isFavorite(event);
            event.isFavorite = isFavorite;
            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  AppRoutes.EventDetails.name,
                  arguments: event,
                );
              },
              child: EventsCard(event: event),
            );
          },
          separatorBuilder: (context, index) => SizedBox(height: 16),
          itemCount: events.length,
        );
      },
    );
  }
}
