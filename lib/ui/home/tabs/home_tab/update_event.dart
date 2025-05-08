import 'package:event_planning_app/model/event.dart';
import 'package:event_planning_app/ui/home/tabs/home_tab/event_tab_item.dart';
import 'package:event_planning_app/ui/home/widget/custom_elevated_button.dart';
import 'package:event_planning_app/ui/home/widget/custom_text_field.dart';
import 'package:event_planning_app/ui/home/widget/event_date_or_time.dart';
import 'package:event_planning_app/utils/app_assets.dart';
import 'package:event_planning_app/utils/app_colors.dart';
import 'package:event_planning_app/utils/app_styles.dart';
import 'package:event_planning_app/utils/toast_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../../providers/event_list_provider.dart';
import '../../../../providers/event_provider.dart';
import '../../../../providers/theme_provider.dart';
import '../../../../providers/user_provider.dart';

class UpdateEvent extends StatefulWidget {
  static const String routeName = 'UpdateEvent';

  const UpdateEvent({super.key});

  @override
  State<UpdateEvent> createState() => _UpdateEventState();
}

var formKey = GlobalKey<FormState>();

class _UpdateEventState extends State<UpdateEvent> {
  int selectedIndex = 0;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  late EventProvider eventProvider;
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late List<String> eventsNameList = [];
  late List<String> imageSelectedEventList = [];
  late String selectedImage;
  late String selectedEventName;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    eventsNameList.addAll([
      AppLocalizations.of(context)!.sport,
      AppLocalizations.of(context)!.birthday,
      AppLocalizations.of(context)!.meeting,
      AppLocalizations.of(context)!.gaming,
      AppLocalizations.of(context)!.workshop,
      AppLocalizations.of(context)!.book_club,
      AppLocalizations.of(context)!.exhibition,
      AppLocalizations.of(context)!.holiday,
      AppLocalizations.of(context)!.eating,
    ]);

    imageSelectedEventList = [
      AppAssets.sportImg,
      AppAssets.birthdayImg,
      AppAssets.meetingImg,
      AppAssets.gamingImg,
      AppAssets.workshopImg,
      AppAssets.bookClubImg,
      AppAssets.exhibitionImg,
      AppAssets.holidayImg,
      AppAssets.eatingImg,
    ];
    eventProvider = Provider.of<EventProvider>(context);

    titleController = TextEditingController(
      text: eventProvider.selectedEvent?.title ?? '',
    );
    descriptionController = TextEditingController(
      text: eventProvider.selectedEvent?.description ?? '',
    );

    // Initialize date and time
    selectedDate = eventProvider.selectedEvent?.dateTime.toLocal();

    ///eventProvider.selectedEvent?.dateTime;
    selectedTime =
        eventProvider.selectedEvent?.dateTime != null
            ? TimeOfDay.fromDateTime(
              eventProvider.selectedEvent!.dateTime.toLocal(),
            )
            : null;

    var initialEventName = eventProvider.selectedEvent?.eventName;
    if (initialEventName != null && eventsNameList.contains(initialEventName)) {
      selectedIndex = eventsNameList.indexOf(initialEventName);
    } else if (imageSelectedEventList.isNotEmpty) {
      selectedImage = imageSelectedEventList[0];
    }

    if (imageSelectedEventList.isNotEmpty &&
        selectedIndex < imageSelectedEventList.length) {
      selectedImage = imageSelectedEventList[selectedIndex];
    } else if (eventProvider.selectedEvent?.image != null) {
      selectedImage = eventProvider.selectedEvent!.image;
    } else if (imageSelectedEventList.isNotEmpty) {
      selectedImage = imageSelectedEventList[0];
    }

    if (eventsNameList.isNotEmpty && selectedIndex < eventsNameList.length) {
      selectedEventName = eventsNameList[selectedIndex];
    } else if (eventProvider.selectedEvent?.eventName != null) {
      selectedEventName = eventProvider.selectedEvent!.eventName;
    } else if (eventsNameList.isNotEmpty) {
      selectedEventName = eventsNameList[0];
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var themeProvider = Provider.of<ThemeProvider>(context);
    selectedImage = imageSelectedEventList[selectedIndex];

    ///selectedEventName = eventsNameList[selectedIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.update_event,
          style: AppStyles.medium20Primary,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.04),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(selectedImage),

                ///eventProvider.selectedEvent?.image ??
              ),
              SizedBox(height: height * 0.02),
              SizedBox(
                height: height * 0.06,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        selectedIndex = index;
                        setState(() {});
                      },
                      child: EventTabItem(
                        borderColor: AppColors.primaryLight,
                        selectedTextStyle: AppStyles.medium16white,
                        unSelectedTextStyle:
                            Theme.of(context).textTheme.headlineSmall!,
                        selectedBackgroundColor: AppColors.primaryLight,
                        eventName: eventsNameList[index],
                        isSelected: selectedIndex == index,
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(width: width * 0.02);
                  },
                  itemCount: eventsNameList.length,
                ),
              ),
              SizedBox(height: height * 0.02),
              Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.title,
                      style:
                          themeProvider.currentTheme == ThemeMode.light
                              ? AppStyles.medium16black
                              : AppStyles.medium16white,
                    ),
                    SizedBox(height: height * 0.01),
                    CustomTextField(
                      controller: titleController,
                      borderColor:
                          themeProvider.currentTheme == ThemeMode.light
                              ? AppColors.greyColor
                              : AppColors.primaryLight,
                      validator: (text) {
                        if (text!.isEmpty) {
                          return AppLocalizations.of(
                            context,
                          )!.please_enter_event_title;
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: height * 0.02),
                    Text(
                      AppLocalizations.of(context)!.description,
                      style:
                          themeProvider.currentTheme == ThemeMode.light
                              ? AppStyles.medium16black
                              : AppStyles.medium16white,
                    ),
                    SizedBox(height: height * 0.01),
                    CustomTextField(
                      maxLines: 4,
                      controller: descriptionController,
                      borderColor:
                          themeProvider.currentTheme == ThemeMode.light
                              ? AppColors.greyColor
                              : AppColors.primaryLight,
                      validator: (text) {
                        if (text!.isEmpty) {
                          return AppLocalizations.of(
                            context,
                          )!.please_enter_event_description;
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: height * 0.02),
                    EventDateOrTime(
                      iconDateOrTime:
                          themeProvider.currentTheme == ThemeMode.light
                              ? AppAssets.calenderIcon
                              : AppAssets.calenderIconDark,
                      eventDateOrTime: AppLocalizations.of(context)!.event_date,
                      choosetDateOrTime:
                          selectedDate == null
                              ? AppLocalizations.of(context)!.choose_date
                              : '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}',
                      onChooseDateOrTime: _chooseDate,
                    ),
                    SizedBox(height: height * 0.01),
                    EventDateOrTime(
                      iconDateOrTime:
                          themeProvider.currentTheme == ThemeMode.light
                              ? AppAssets.timeIcon
                              : AppAssets.timeIconDark,
                      eventDateOrTime: AppLocalizations.of(context)!.event_time,
                      choosetDateOrTime:
                          selectedTime == null
                              ? AppLocalizations.of(context)!.choose_time
                              : selectedTime!.format(context),
                      onChooseDateOrTime: _chooseTime,
                    ),
                    SizedBox(height: height * 0.02),
                    CustomElevatedButton(
                      onButtonClick: _updateEvent,
                      text: AppLocalizations.of(context)!.update_event,
                    ),
                    SizedBox(height: height * 0.02),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _chooseDate() async {
    var pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder:
          (context, child) => Theme(
            data: ThemeData().copyWith(
              colorScheme: ColorScheme.light(
                primary: AppColors.primaryLight,
                onPrimary: AppColors.whiteColor,
              ),
            ),
            child: child!,
          ),
    );
    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  void _chooseTime() async {
    var pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );
    if (pickedTime != null) {
      setState(() {
        selectedTime = pickedTime;
      });
    }
  }

  Future<void> _updateEvent() async {
    if (formKey.currentState!.validate()) {
      if (selectedDate == null || selectedTime == null) {
        ToastUtils.toastMsg(
          msg: AppLocalizations.of(context)!.please_select_date_and_time,
          bgColor: AppColors.redColor,
          textColor: AppColors.whiteColor,
        );
        return;
      }

      var userProvider = Provider.of<UserProvider>(context, listen: false);

      ///final selectedImage = imageSelectedEventList[selectedIndex];
      ///final selectedEventName = eventsNameList[selectedIndex];

      try {
        DateTime updatedDateTime = DateTime(
          selectedDate!.year,
          selectedDate!.month,
          selectedDate!.day,
        );

        Event updatedEvent = Event(
          id: eventProvider.selectedEvent!.id,
          title: titleController.text,
          description: descriptionController.text,
          dateTime: updatedDateTime,
          image: selectedImage,
          eventName: selectedEventName,
          time: selectedTime!.format(context),
        );

        await Provider.of<EventListProvider>(
          context,
          listen: false,
        ).updateEvent(userProvider.currentUser!.id, updatedEvent);

        ToastUtils.toastMsg(
          msg: 'Event Updated Successfully',
          bgColor: AppColors.greenColor,
          textColor: AppColors.whiteColor,
        );
        Navigator.of(context).pop();
      } catch (e) {
        print("Error updating event: $e");
        ToastUtils.toastMsg(
          msg: 'Failed to update event: $e',
          bgColor: Colors.red,
          textColor: AppColors.whiteColor,
        );
      }
    }
  }
}
