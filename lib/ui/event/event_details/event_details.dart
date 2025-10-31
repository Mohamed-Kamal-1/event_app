import 'package:evently_app/core/colors/app_color.dart';
import 'package:evently_app/core/routes/app_routes.dart';
import 'package:evently_app/database/model/EventsDao.dart';
import 'package:evently_app/extensions/date_time_extensions.dart';
import 'package:evently_app/extensions/extension_home_screen.dart';
import 'package:flutter/material.dart';
import '../../../database/model/category.dart';
import '../../../database/model/event.dart';
import '../../home_screen/tabs/map_tab/map_tab.dart';

class EventDetails extends StatelessWidget {
  final int selectedTabIndex = 0;
  final List<Category> allCategories = Category.getCategories(
    includeAll: false,
  );
  final formKey = GlobalKey<FormState>();
  final DateTime? selectedDate = null;
  final TimeOfDay? selectedTime = null;

  EventDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final Event event = ModalRoute.of(context)!.settings.arguments as Event;
    final eventTime = TimeOfDay.fromDateTime(event.time!).format(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.whitePrimaryColor,
        foregroundColor: AppColor.bluePrimaryColor,
        title: Text('Event Details'),
        centerTitle: true,
        actions: [
          IconButton(
            enableFeedback: false,
            color: AppColor.bluePrimaryColor,
            onPressed: () {
              Navigator.pushNamed(
                context,
                AppRoutes.EventEdit.name,
                arguments: event,
              );
            },
            icon: Icon(Icons.edit),
          ),
          IconButton(
            color: Colors.red,
            onPressed: () {
              context.showMessageDialog('Are you sure you want to delete this event ?',
                negActionText: 'No',
                onNegActionClick: () => Navigator.pop(context),
                posActionText: 'Yes',
                onPosActionClick: () {
                  EventsDao.deleteEvent(event);
                  Navigator.pop(context);
                },
                
              );
            },
            icon: Icon(Icons.delete),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image(image: AssetImage(event.getCategoryImage())),
              ),
              const SizedBox(height: 16),
              Text(
                '${event.title}',
                style: context.fonts.headlineSmall?.copyWith(
                  color: AppColor.bluePrimaryColor,
                ),
              ),
              SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 14,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: AppColor.bluePrimaryColor,
                    width: 2,
                  ),
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

                      child: Icon(
                        Icons.calendar_month_sharp,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      children: [
                        Text(
                          "${event.date?.format()}",
                          style: context.fonts.titleSmall?.copyWith(
                            color: AppColor.bluePrimaryColor,
                          ),
                        ),

                        Text("$eventTime", style: context.fonts.titleSmall),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 14,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: AppColor.bluePrimaryColor,
                    width: 2,
                  ),
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
                      child: Icon(Icons.gps_fixed, color: Colors.white),
                    ),
                    const SizedBox(width: 10),
                    Text("Cairo, Egypt", style: context.fonts.titleSmall),
                    Spacer(),
                    const Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: AppColor.bluePrimaryColor,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Container(
                child: Container(
                  height: 381,
                  width: 381,
                  clipBehavior: Clip.antiAlias,
                  child: MapTab(),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: AppColor.bluePrimaryColor,
                      width: 2,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              Text("Description", style: context.fonts.titleSmall),
              const SizedBox(height: 6),
              Text('${event.desc}', style: context.fonts.titleSmall),
            ],
          ),
        ),
      ),
    );
  }
}
