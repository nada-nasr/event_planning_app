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

import '../../../../firebase_utils.dart';
import '../../../../providers/event_list_provider.dart';
import '../../../../providers/theme_provider.dart';
import '../../../../providers/user_provider.dart';

class AddEvent extends StatefulWidget {
  static const String routeName = 'add_event';

  const AddEvent({super.key});

  @override
  State<AddEvent> createState() => _AddEventState();
}

var formKey = GlobalKey<FormState>();

class _AddEventState extends State<AddEvent> {
  int selectedIndex = 0;
  DateTime? selectedDate;
  String? formatTime = '';
  TimeOfDay? selectedTime;
  String selectedImage = '';
  String selectedEventName = '';
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  var formKey = GlobalKey<FormState>();
  late EventListProvider eventListProvider;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var themeProvider = Provider.of<ThemeProvider>(context);
    eventListProvider = Provider.of<EventListProvider>(context);
    List<String> eventsNameList = [
      AppLocalizations.of(context)!.sport,
      AppLocalizations.of(context)!.birthday,
      AppLocalizations.of(context)!.meeting,
      AppLocalizations.of(context)!.gaming,
      AppLocalizations.of(context)!.workshop,
      AppLocalizations.of(context)!.book_club,
      AppLocalizations.of(context)!.exhibition,
      AppLocalizations.of(context)!.holiday,
      AppLocalizations.of(context)!.eating,
    ];
    List<String> imageSelectedEventList = [
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
    selectedImage = imageSelectedEventList[selectedIndex];
    selectedEventName = eventsNameList[selectedIndex];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.create_event,
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

                        ///iconName: Icons.directions_bike_rounded,
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
                      hintText: AppLocalizations.of(context)!.event_title,
                      hintStyle:
                          themeProvider.currentTheme == ThemeMode.light
                              ? AppStyles.medium16Gray
                              : AppStyles.medium16white,
                      prefixIcon:
                          themeProvider.currentTheme == ThemeMode.light
                              ? Image.asset(AppAssets.editIcon)
                              : Image.asset(AppAssets.editIconDark),
                      borderColor:
                          themeProvider.currentTheme == ThemeMode.light
                              ? AppColors.greyColor
                              : AppColors.primaryLight,
                      validator: (text) {
                        if (text!.isEmpty) {
                          return 'Please enter event title ';
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
                      hintText: AppLocalizations.of(context)!.event_description,
                      hintStyle:
                          themeProvider.currentTheme == ThemeMode.light
                              ? AppStyles.medium16Gray
                              : AppStyles.medium16white,
                      borderColor:
                          themeProvider.currentTheme == ThemeMode.light
                              ? AppColors.greyColor
                              : AppColors.primaryLight,
                      validator: (text) {
                        if (text!.isEmpty) {
                          return 'Please enter event description ';
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
                      onChooseDateOrTime: chooseDate,
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

                      ///formatTime!,
                      onChooseDateOrTime: chooseTime,
                    ),
                    SizedBox(height: height * 0.02),
                    Text(
                      AppLocalizations.of(context)!.location,
                      style:
                          themeProvider.currentTheme == ThemeMode.light
                              ? AppStyles.medium16black
                              : AppStyles.medium16white,
                    ),
                    SizedBox(height: height * 0.02),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: width * 0.02,
                        vertical: height * 0.008,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: AppColors.primaryLight,
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          themeProvider.currentTheme == ThemeMode.light
                              ? Image.asset(AppAssets.locationIcon)
                              : Image.asset(AppAssets.locationIconDark),
                          SizedBox(width: width * 0.02),
                          Expanded(
                            child: Text(
                              AppLocalizations.of(
                                context,
                              )!.choose_event_location,
                              style: AppStyles.medium16Primary,
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.arrow_forward_ios_outlined,
                              color: AppColors.primaryLight,
                            ),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: height * 0.02),
                    CustomElevatedButton(
                      onButtonClick: addEvent,
                      text: AppLocalizations.of(context)!.add_event,
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

  void chooseDate() async {
    var chooseDate = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
      builder: (context, child) =>
          Theme(
            data: ThemeData().copyWith(
                colorScheme: ColorScheme.light(
                    primary: AppColors.primaryLight,
                    onPrimary: AppColors.whiteColor
                )),
            child: child!,
          ),
    );
    if (chooseDate != null) {
      setState(() {
        selectedDate = chooseDate;
      });
    }
  }

  void chooseTime() async {
    var chooseTime = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );
    if (chooseTime != null) {
      setState(() {
        selectedTime = chooseTime;
        formatTime = selectedTime!.format(context);
      });
    }
  }

  void addEvent() {
    if (formKey.currentState!.validate() == true) {}
    if (selectedDate == null || selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please select date and time'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    //todo: add event to database
    Event event = Event(
      image: selectedImage,
      title: titleController.text,
      description: descriptionController.text,
      eventName: selectedEventName,
      time: formatTime!,
      dateTime: selectedDate!,
    );
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    FirebaseUtils.addEventToFireStore(event, userProvider.currentUser!.id)
        .then((value) {
      //todo: toast
      ToastUtils.toastMsg(
        bgColor: AppColors.primaryLight,
        textColor: AppColors.whiteColor,
        msg: 'Event Added Successfully',
      );
      //todo: refresh events
      eventListProvider.getAllEvents(userProvider.currentUser!.id);
      Navigator.pop(context);
    },
    ).timeout(
      Duration(milliseconds: 500),
      onTimeout: () {
        //todo: toast
        ToastUtils.toastMsg(
          bgColor: AppColors.primaryLight,
          textColor: AppColors.whiteColor,
          msg: 'Event Added Successfully',
        );
        //todo: refresh events
        eventListProvider.getAllEvents(userProvider.currentUser!.id);
        Navigator.pop(context);
      },
    );

    /// success offline
    /// FirebaseUtils.addEventToFireStore(event).then(); /// success online
  }
}
