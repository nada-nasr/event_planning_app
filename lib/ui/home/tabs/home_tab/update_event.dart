/*import 'package:event_planning_app/model/event.dart';
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
          msg: AppLocalizations.of(context)!.please_select_date_and_time_and_location,
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
}*/

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
import 'package:geocoding/geocoding.dart'; // Import geocoding
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../../providers/event_list_provider.dart';
import '../../../../providers/event_provider.dart';
import '../../../../providers/theme_provider.dart';
import '../../../../providers/user_provider.dart';
import '../map_tab/map_selection_screen.dart';

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
  LatLng? selectedLocation;
  String? locationText;

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

    selectedDate = eventProvider.selectedEvent?.dateTime.toLocal();

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

    selectedLocation = LatLng(
      eventProvider.selectedEvent?.latitude ?? 0.0,
      eventProvider.selectedEvent?.longitude ?? 0.0,
    );
    _updateLocationText(selectedLocation);
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  Future<void> _selectLocation(BuildContext context) async {
    final LatLng? location = await Navigator.push<LatLng>(
      context,
      MaterialPageRoute(builder: (context) => const MapSelectionScreen()),
    );
    if (location != null) {
      setState(() {
        selectedLocation = location;
        _updateLocationText(location);
      });
    }
  }

  Future<void> _updateLocationText(LatLng? location) async {
    if (location != null) {
      try {
        List<Placemark> placemarks = await placemarkFromCoordinates(
          location.latitude,
          location.longitude,
        );
        if (placemarks.isNotEmpty) {
          Placemark place = placemarks[0];
          locationText =
              '${place.locality}, ${place.administrativeArea}, ${place.country}';
        } else {
          locationText = "Location not found";
        }
      } catch (e) {
        print('Error getting location name: $e');
        locationText = "Error getting location";
      }
    } else {
      locationText = "Location unavailable";
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var themeProvider = Provider.of<ThemeProvider>(context);
    selectedImage = imageSelectedEventList[selectedIndex];

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
                    InkWell(
                      onTap: () => _selectLocation(context),
                      child: Container(
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
                                locationText ??
                                    AppLocalizations.of(
                                      context,
                                    )!.choose_event_location,
                                style:
                                    locationText != null
                                        ? AppStyles.medium16Primary
                                        : AppStyles.medium16Gray,
                              ),
                            ),
                            const Icon(
                              Icons.arrow_forward_ios_outlined,
                              color: AppColors.primaryLight,
                            ),
                          ],
                        ),
                      ),
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
      if (selectedDate == null ||
          selectedTime == null ||
          selectedLocation == null) {
        ToastUtils.toastMsg(
          msg:
              AppLocalizations.of(
                context,
              )!.please_select_date_and_time_and_location,
          bgColor: AppColors.redColor,
          textColor: AppColors.whiteColor,
        );
        return;
      }

      var userProvider = Provider.of<UserProvider>(context, listen: false);

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
          latitude: selectedLocation!.latitude,
          longitude: selectedLocation!.longitude,
          locationName: locationText, // Save the location name
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

/// mohamed
/*
import 'package:easy_localization/easy_localization.dart';
import 'package:event_planning_app/Modal/Event.dart';
import 'package:event_planning_app/Providers/EventListProvider.dart';
import 'package:event_planning_app/Providers/UserProvider.dart';
import 'package:event_planning_app/UI/HomeScreen/HomeScreen.dart';
import 'package:event_planning_app/UI/HomeScreen/HomeTab/EventBarItem.dart';
import 'package:event_planning_app/UI/HomeScreen/HomeTab/TabBarData.dart';
import 'package:event_planning_app/UI/Widgets/CustomElevatedButton.dart';
import 'package:event_planning_app/UI/Widgets/CustomTextField.dart';
import 'package:event_planning_app/Utils/AppAssets.dart';
import 'package:event_planning_app/Utils/AppColors.dart';
import 'package:event_planning_app/Utils/AppStyle.dart';
import 'package:event_planning_app/Utils/FireBaseUtils.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class EditEvent extends StatefulWidget {
  static const routeName = 'EditEvent';

  @override
  State<EditEvent> createState() => _EditEventState();
}

class _EditEventState extends State<EditEvent> {
  var formKey = GlobalKey<FormState>();

  final List<TabBarData> EventList = [
    TabBarData(text: "Sport".tr(), iconTab: Icons.directions_bike_sharp),
    TabBarData(text: "Birthday".tr(), iconTab: Icons.cake),
    TabBarData(text: "Meeting".tr(), iconTab: Icons.business_center),
    TabBarData(text: "Gaming".tr(), iconTab: Icons.videogame_asset),
    TabBarData(text: "Workshop".tr(), iconTab: Icons.work),
    TabBarData(text: "Book Club".tr(), iconTab: Icons.book),
    TabBarData(text: "Exhibition".tr(), iconTab: Icons.photo),
    TabBarData(text: "Holiday".tr(), iconTab: Icons.beach_access),
    TabBarData(text: "Eating".tr(), iconTab: Icons.restaurant),
  ];

  final List<String> eventListName = [
    "Sport",
    "Birthday".tr(),
    "Meeting".tr(),
    "Gaming".tr(),
    "Workshop".tr(),
    "Book Club".tr(),
    "Exhibition".tr(),
    "Holiday".tr(),
    "Eating".tr(),
  ];

  final List<String> imageEventList = [
    AppAssets.sport,
    AppAssets.birthday,
    AppAssets.meeting,
    AppAssets.gaming,
    AppAssets.workshop,
    AppAssets.bookClub,
    AppAssets.exhibition,
    AppAssets.holiday,
    AppAssets.eating,
  ];

  DateTime? selectedDate;
  String? selectedTime;
  String? formatTime;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  String selectedImage = '';
  String selectedEventName = '';
  late Event eventArgs;
  late int selectedIndex;
  bool isInitialized = false;
  @override
  Widget build(BuildContext context) {
    if (!isInitialized) {
      eventArgs = ModalRoute.of(context)?.settings.arguments as Event;
      selectedIndex = eventListName
          .indexOf(eventArgs.eventName.tr());
      selectedImage = imageEventList[selectedIndex];
      titleController.text = eventArgs.title;
      selectedDate=eventArgs.date;
      selectedTime=eventArgs.time;
      descriptionController.text =
          eventArgs.description;
      isInitialized = true;
    }

    var userProvider = Provider.of<UserProvider>(context);
    var eventListProvider = Provider.of<EventListProvider>(context);
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    selectedImage = imageEventList[selectedIndex];
    selectedEventName = EventList[selectedIndex].text.isEmpty

        ? eventArgs.eventName
        : EventList[selectedIndex].text;

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.delete,
                color: Colors.red,
              ))
        ],
        elevation: 0,
        backgroundColor: AppColors.backgroundlight,
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColors.primarylight),
        title: Text(
          'EditEvent'.tr(),
          style: AppStyle.light20PrimaryLight,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * .04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: height * .02),
              Container(
                height: height * .25,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    image: DecorationImage(
                        fit: BoxFit.fill, image: AssetImage(selectedImage))),
              ),
              SizedBox(height: height * .02),
              Container(
                height: height * .06,
                child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return InkWell(
                          onTap: () {
                            setState(() {
                              selectedIndex = index;
                            });
                            selectedIndex = index;
                          },
                          child: EventBarItem(
                              textSelectedStyle: AppStyle.bold16White,
                              textUnSelectedStyle: AppStyle.bold16PrimaryLight,
                              selectedColor: AppColors.primarylight,
                              unSelectedColor: AppColors.white,
                              text: EventList[index].text,
                              tabIcon: EventList[index].iconTab!,
                              isSelected:
                              selectedIndex == index ? true : false));
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(height: height * .02);
                    },
                    itemCount: EventList.length),
              ),
              SizedBox(height: height * .02),
              Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'title'.tr(),
                        style: AppStyle.light20PrimaryLight,
                      ),
                      SizedBox(height: height * .02),
                      CustomTextField(
                        textInputType: TextInputType.text,
                        controller: titleController,
                        hintText: eventArgs.title,
                      ),
                      SizedBox(height: height * .03),
                      Text(
                        "description".tr(),
                        style: AppStyle.light20PrimaryLight,
                      ),
                      SizedBox(height: height * .03),
                      CustomTextField(
                        textInputType: TextInputType.text,
                        controller: descriptionController,
                        maxLine: 4,
                        hintText: eventArgs.description,
                      )
                    ],
                  )),
              SizedBox(height: height * .02),
              Row(
                children: [
                  Icon(
                    Icons.date_range_outlined,
                    color: AppColors.black,
                  ),
                  SizedBox(width: width * .02),
                  Text(
                    "eventData".tr(),
                    style: AppStyle.bold16Black,
                  ),
                  Spacer(),
                  TextButton(
                      onPressed: () {
                        chooseDate();
                      },
                      child: Text(
                        selectedDate == null
                            ? DateFormat('ddd/mmm/yyy').format(eventArgs.date)
                            : "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
                        style: AppStyle.bold16PrimaryLight.copyWith(
                            decoration: TextDecoration.underline,
                            decorationColor: AppColors.primarylight),
                      ))
                ],
              ),
              Row(
                children: [
                  Icon(
                    Icons.date_range_outlined,
                    color: AppColors.black,
                  ),
                  SizedBox(width: width * .02),
                  Text(
                    "eventTime".tr(),
                    style: AppStyle.bold16Black,
                  ),
                  Spacer(),
                  TextButton(
                      onPressed: () {
                        chooseTime();
                      },
                      child: Text(
                        formatTime == null ? eventArgs.time : formatTime!,
                        style: AppStyle.bold16PrimaryLight.copyWith(
                            decoration: TextDecoration.underline,
                            decorationColor: AppColors.primarylight),
                      ))
                ],
              ),
              SizedBox(height: height * .02),
              Text(
                'location'.tr(),
                style: AppStyle.light20PrimaryLight,
              ),
              SizedBox(height: height * .02),
              Container(
                padding: EdgeInsets.all(width * .01),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border:
                    Border.all(color: AppColors.primarylight, width: 1)),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.primarylight,
                        // Set the background color here
                        borderRadius: BorderRadius.circular(
                            16), // Optional: Add border radius for rounded corners
                      ),
                      child: IconButton(
                        padding: EdgeInsets.all(width * .02),
                        onPressed: () {},
                        icon: Icon(
                          Icons.location_searching_outlined,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                    SizedBox(width: height * .02),
                    Text(
                      "choose Event location".tr(),
                      style: AppStyle.bold16PrimaryLight,
                    ),
                    Spacer(),
                    Icon(
                      Icons.arrow_forward_ios_sharp,
                      color: AppColors.primarylight,
                    )
                  ],
                ),
              ),
              SizedBox(height: height * .03),
              CustomElevatedButton(
                onPressed: () {
                  // Validate the form

                  Event event = Event(
                    id: eventArgs.id,
                    eventName: selectedEventName,
                    title: titleController.text.isNotEmpty
                        ? titleController.text
                        : eventArgs.title,
                    description: descriptionController.text.isNotEmpty
                        ? descriptionController.text
                        : eventArgs.description,
                    image: selectedImage,
                    date: selectedDate ?? eventArgs.date,
                    time: selectedTime!.isNotEmpty
                        ? selectedTime!
                        : eventArgs.time,
                  );

                  // Update the event to Firestore
                  eventListProvider.updateEvent(
                      event, userProvider.currentUser!.id);
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    HomeScreen.routeName,
                        (Route<dynamic> route) => false,
                  );
                }
                ,
                textButton: "Edit Event".tr(),
              )
            ],
          ),
        ),
      ),
    );
  }

  chooseDate() async {
    var chooseDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));
    if (chooseDate != null) {
      selectedDate = chooseDate;

      setState(() {});
    }
    setState(() {});
  }

  chooseTime() async {
    var chooseTime =
    await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (chooseTime != null) {
      selectedTime = chooseTime.format(context);
      formatTime = selectedTime;
      setState(() {});
    }
  }
}*/
