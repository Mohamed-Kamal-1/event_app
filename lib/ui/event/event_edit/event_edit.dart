import 'package:evently_app/core/colors/app_color.dart';
import 'package:evently_app/extensions/date_time_extensions.dart';
import 'package:evently_app/extensions/extension_home_screen.dart';
import 'package:flutter/material.dart';
import '../../../database/model/EventsDao.dart';
import '../../../database/model/category.dart';
import '../../../database/model/event.dart';
import '../../register/app_form_field.dart';
import '../../tabs/events_tab.dart';

class EventEdit extends StatefulWidget {
  @override
  State<EventEdit> createState() => _EventEditState();

}

class _EventEditState extends State<EventEdit> {
  int selectedTabIndex = 0;
  List<Category> allCategories = Category.getCategories(includeAll: false);

  // List<Category> allCategories = Category.getCategories(includeAll: false);
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  Event eventUpdated = Event();
  late String? eventId;

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final event = ModalRoute.of(context)!.settings.arguments as Event;
     eventId = event.id;
    titleController.text = event.title!;
    descriptionController.text = event.desc!;

    // selectedTabIndex = allCategories.indexOf(category);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.whitePrimaryColor,
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
                      EventsTab( reverse:  true ,allCategories, selectedTabIndex, (
                        index,
                        category,

                      ) {
                        setState(() {
                          selectedTabIndex = index;
                        });
                      }),
                      Text('Description',style: context.fonts.titleSmall),
                      AppFormField(
                        controller: titleController,
                        labelText: "Event Title",
                        icon: Icons.edit,
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return "please enter title";
                          }
                        },
                      ),
                      Text('Description',style: context.fonts.titleSmall),
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
                              chooseDate();
                            },
                            child: Text(
                              selectedDate == null
                                  ? "${event.date?.format()}"
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
                              chooseTime();
                            },
                            child: Text(
                              selectedTime == null
                                  ? "${event.time}"
                                  : selectedTime?.format(context) ?? "",
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

                  updateEvent();
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

  void chooseDate() async {
    var date = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 60)),
    );
    setState(() {
      selectedDate = date;
    });
  }

  void chooseTime() async {
    var time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    setState(() {
      selectedTime = time;
    });
  }

  bool isValidData() {
    var isValid = formKey.currentState?.validate() ?? false;
    if (selectedDate == null) {
      // show error message
      context.showMessageDialog("please Choose Event Date");
      isValid = false;
    } else if (selectedTime == null) {
      // show error message
      context.showMessageDialog("please Choose Event time");
      isValid = false;
    }
    return isValid;
  }

  void updateEvent() async {
    if (!isValidData()) {
      return;
    }
      eventUpdated.id = eventId;
      eventUpdated.title = titleController.text;
      eventUpdated.desc =  descriptionController.text;
      eventUpdated.date =  selectedDate;
      eventUpdated.time =  selectedTime?.toDateTime();
      eventUpdated.categoryId =  allCategories[selectedTabIndex].id;

    context.showLoadingDialog(
      message: "Update Event ...",
      isDismissible: false,
    );
    await EventsDao.updateEvent(eventUpdated);
    // hideLoading Dialog
    Navigator.pop(context);
    context.showMessageDialog(
      "Event Updated Successfully",
      posActionText: "ok",
      onPosActionClick: () {
        Navigator.pop(context);
      },
      isDismissible: false,
    );
  }
}
