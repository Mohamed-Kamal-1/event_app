import 'package:evently_app/core/colors/app_color.dart';
import 'package:evently_app/extensions/date_time_extensions.dart';
import 'package:evently_app/extensions/extension_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

import '../../../database/model/EventsDao.dart';
import '../../../database/model/category.dart';
import '../../../database/model/event.dart';
import '../../../providers/app_auth_provider.dart';
import '../../register/app_form_field.dart';
import '../../tabs/events_tab.dart';

class CreateEventScreen extends StatefulWidget {
  CreateEventScreen({super.key});

  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  int selectedTabIndex = 0;
  List<Category> allCategories = Category.getCategories(includeAll: false);

  // List<Category> allCategories = Category.getCategories(includeAll: false);
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  var formKey = GlobalKey<FormState>();
@override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.whitePrimaryColor,
        foregroundColor: AppColor.bluePrimaryColor,
          title: Text('Create Event')),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                        // reversed: true,
                       selectedTabIndex,
                         (index, category) {
                          setState(() {
                            selectedTabIndex = index;
                          });
                        },
                      ),
                      Text('title',style: context.fonts.titleSmall),
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
                        labelText: "Event Description",
                        lines: 5,
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return "please enter description";
                          }
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
                                  style: context.fonts.titleSmall
                              ),
                            ],
                          ),
                          TextButton(
                            onPressed: () {
                              chooseDate();
                            },
                            child: Text(
                              selectedDate == null
                                  ? "Choose Date"
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
                                style: context.fonts.titleSmall

                              ),
                            ],
                          ),
                          TextButton(
                            onPressed: () {
                              chooseTime();
                            },
                            child: Text(
                              selectedTime == null
                                  ? "Choose time"
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
                  createEvent();
                },
                child: Text("Add Event"),
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

  void createEvent() async {
    if (!isValidData()) {
      return;
    }

    // show Loading Dialog
    var authProvider = Provider.of<AppAuthProvider>(context, listen: false);
    var event = Event(
      title: titleController.text,
      desc: descriptionController.text,
      date: selectedDate,
      time: selectedTime?.toDateTime(),
      categoryId: allCategories[selectedTabIndex].id,
      creatorUserId: authProvider.getUser()?.userId,
    );
    context.showLoadingDialog(
      message: "Creating Event ...",
      isDismissible: false,
    );
    await EventsDao.addEvent(event);
    // hideLoading Dialog
    Navigator.pop(context);
    context.showMessageDialog(
      "Event Created Successfully",
      posActionText: "ok",
      onPosActionClick: () {
        Navigator.pop(context);
      },
      isDismissible: false,
    );
  }
}
