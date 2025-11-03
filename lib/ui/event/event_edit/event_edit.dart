import 'package:evently_app/core/colors/app_color.dart';
import 'package:evently_app/core/routes/app_routes.dart';
import 'package:evently_app/extensions/date_time_extensions.dart';
import 'package:evently_app/extensions/extension_home_screen.dart';
import 'package:flutter/material.dart';
import '../../../database/model/EventsDao.dart';
import '../../../database/model/category.dart';
import '../../../database/model/event.dart';
import '../../register/app_form_field.dart';
import '../../tabs/events_tab.dart';

class EventEdit extends StatefulWidget {
  Event event;

  EventEdit({required this.event});

  @override
  State<EventEdit> createState() => _EventEditState();
}

class _EventEditState extends State<EventEdit> {
  int selectedTabIndex = 0;
  List<Category> allCategories = Category.getCategories(includeAll: false);

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  // Event eventUpdated = Event();
  // String? titleEvent;
  // String? descEvent;
  // late String? eventId;

  // @override
  // void didChangeDependencies() {
  //   final event = ModalRoute.of(context)!.settings.arguments as Event;
  //   eventUpdated = event;
  //   titleController.text = titleEvent ?? 'error in title';
  //   descriptionController.text = descEvent ?? "error in description";
  // }

  @override
  void initState() {
    super.initState();
    titleController.text = widget.event.title!;
    descriptionController.text = widget.event.desc!;
  }

  @override
  Widget build(BuildContext context) {
    final eventTime = TimeOfDay.fromDateTime(
      widget.event.time!,
    ).format(context);
    TimeOfDay initialTime = TimeOfDay.fromDateTime(widget.event.time!);

    return Scaffold(
      appBar: AppBar(
        foregroundColor: AppColor.bluePrimaryColor,
        title: Text('Edit Event'),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.only(bottom: 30),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    spacing: 16,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image(
                          image: AssetImage(
                            Category.getCategoryImage(
                              allCategories[selectedTabIndex].id,
                            ),
                          ),
                        ),
                      ),
                      EventsTab(
                        reverse: true,
                        allCategories,
                        selectedTabIndex,
                        (index, category) {
                          setState(() {
                            selectedTabIndex = index;
                          });
                        },
                      ),
                      Text('title', style: context.fonts.titleSmall),
                      AppFormField(
                        controller: titleController,
                        labelText: "Event Title",
                        icon: Icons.edit,
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return "please enter title";
                          }
                          return null;
                        },
                      ),
                      Text('Description', style: context.fonts.titleSmall),
                      AppFormField(
                        controller: descriptionController,
                        labelText: "Description",
                        lines: 5,
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return "please enter description";
                          }
                          return null;
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.date_range_outlined),
                              Text(
                                "Event Date",
                                style: context.fonts.titleSmall,
                              ),
                            ],
                          ),
                          TextButton(
                            onPressed: () {
                              chooseDate(widget.event.date);
                            },
                            child: Text(
                              selectedDate == null
                                  ? "${widget.event.date?.format()}"
                                  : selectedDate?.format() ?? "",
                              style: context.fonts.titleSmall,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.timer_outlined),
                              Text(
                                "Event time",
                                style: context.fonts.titleSmall,
                              ),
                            ],
                          ),
                          TextButton(
                            onPressed: () {
                              chooseTime(initialTime);
                            },
                            child: Text(
                              " ${(selectedTime == null) ? eventTime : selectedTime?.format(context)}",
                              style: context.fonts.titleSmall,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  AcceptOrNO();
                },
                child: Text(
                  "Update Event",
                  style: context.fonts.titleMedium?.copyWith(
                    color: AppColor.whitePrimaryColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  void chooseDate(DateTime? initialDate) async {
    var date = await showDatePicker(
      initialDate: selectedDate ?? initialDate,
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 60)),
    );
    if (date != null) {
      setState(() {
        selectedDate = date;
      });
    }
  }

  void chooseTime(TimeOfDay initialTime) async {
    var time = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? initialTime,
    );
    if (time != null) {
      setState(() {
        selectedTime = time;
      });
    }
  }

  // bool isValidData() {
  //   var isValid = formKey.currentState?.validate() ?? false;
  //   if (selectedDate == null) {
  //     // show error message
  //     context.showMessageDialog("please Choose Event Date");
  //     isValid = false;
  //   } else if (selectedTime == null) {
  //     // show error message
  //     context.showMessageDialog("please Choose Event time");
  //     isValid = false;
  //   }
  //   return isValid;
  // }

  void updateEvent() async {
    widget.event.title = titleController.text;
    widget.event.desc = descriptionController.text;
    if (selectedTime != TimeOfDay.fromDateTime(widget.event.time!) &&
        selectedTime != null) {
      widget.event.time = selectedTime?.changeTimeToDateTime(
        selectedDate ?? widget.event.date,
        selectedTime,
      );
    }

    if (selectedDate != widget.event.date && selectedDate != null) {
      widget.event.date = selectedDate;
    }


    widget.event.categoryId = allCategories[selectedTabIndex].id;
    await EventsDao.updateEvent(widget.event);
  }

  void AcceptOrNO() async {
    context.showMessageDialog(
      'you need to Update your event',
      isDismissible: false,
      negActionText: 'No',
      onNegActionClick: () => Navigator.pop(context),
      posActionText: 'Yes',
      onPosActionClick: () async {
        updateEvent();
        Navigator.popUntil(context, (route) => route.isFirst);
      },
    );
  }
}
