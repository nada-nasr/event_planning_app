/*import 'package:event_planning_app/model/event.dart';
import 'package:event_planning_app/ui/home/tabs/home_tab/update_event.dart';
import 'package:event_planning_app/utils/app_assets.dart';
import 'package:event_planning_app/utils/app_colors.dart';
import 'package:event_planning_app/utils/app_styles.dart';
import 'package:event_planning_app/utils/toast_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../providers/event_list_provider.dart';
import '../../../../providers/event_provider.dart';
import '../../../../providers/theme_provider.dart';
import '../../../../providers/user_provider.dart';

class EventDetails extends StatefulWidget {
  static const String routeName = 'EventDetails';

  EventDetails({super.key});

  @override
  State<EventDetails> createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  Event? event;
  late EventListProvider eventListProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    eventListProvider = Provider.of<EventListProvider>(context, listen: false);
    fetchEventDetails();
  }

  Future<void> fetchEventDetails() async {
    final eventId =
        Provider.of<EventProvider>(context, listen: false).selectedEvent!.id;
    final fetchedEvent = await eventListProvider.getEventFromList(eventId);
    if (fetchedEvent != null) {
      setState(() {
        event = fetchedEvent;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var themeProvider = Provider.of<ThemeProvider>(context);
    var eventProvider = Provider.of<EventProvider>(context);
    var userProvider = Provider.of<UserProvider>(context);
    eventListProvider = Provider.of<EventListProvider>(context);
    final eventToDisplay = event ?? eventProvider.selectedEvent!;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.event_details,
          style: AppStyles.medium20Primary,
        ),
        centerTitle: true,
        actions: [
          InkWell(
            child: Image.asset(AppAssets.editIcon2),
            onTap: () {
              //todo: navigate to edit screen
              Navigator.of(context).pushNamed(UpdateEvent.routeName);
              setState(() {});
            },
          ),
          SizedBox(width: width * 0.01),
          InkWell(
            child: Image.asset(AppAssets.deleteIcon),
            onTap: () async {
              try {
                await eventListProvider.deleteEvent(
                  userProvider.currentUser!.id,
                  eventProvider.selectedEvent!.id,
                );
                ToastUtils.toastMsg(
                  bgColor: AppColors.redColor,
                  msg: 'Event deleted successfully!',
                  textColor: AppColors.whiteColor,
                );
                Navigator.of(context).pop();
              } catch (error) {
                ToastUtils.toastMsg(
                  bgColor: AppColors.whiteColor,
                  msg: 'Failed to delete event: $error',
                  textColor: AppColors.primaryLight,
                );
                print('Error deleting event: $error');
              }
            },
          ),
          SizedBox(width: width * 0.04),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.04,
          vertical: height * 0.03,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(eventToDisplay.image),

                ///Image.asset(eventProvider.selectedEvent!.image),
              ),
              SizedBox(height: height * 0.02),
              Text(
                eventToDisplay.title,

                ///eventProvider.selectedEvent!.title,
                style: AppStyles.medium24Primary,
              ),
              SizedBox(height: height * 0.02),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: width * 0.02,
                  vertical: height * 0.008,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.primaryLight, width: 1),
                ),
                child: Row(
                  children: [
                    themeProvider.currentTheme == ThemeMode.light
                        ? Image.asset(AppAssets.calenderDetailsLight)
                        : Image.asset(AppAssets.calenderDetailsDark),
                    SizedBox(width: width * 0.02),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          DateFormat('d MMM y').format(eventToDisplay.dateTime),
                          style: AppStyles.medium16Primary,
                        ),
                        Text(
                          eventProvider.selectedEvent!.time.toString(),
                          style: AppStyles.medium16black,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: height * 0.02),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: width * 0.02,
                  vertical: height * 0.008,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.primaryLight, width: 1),
                ),
                child: Row(
                  children: [
                    themeProvider.currentTheme == ThemeMode.light
                        ? Image.asset(AppAssets.locationIcon)
                        : Image.asset(AppAssets.locationIconDark),
                    SizedBox(width: width * 0.02),
                    Expanded(
                      child: Text(
                        AppLocalizations.of(context)!.cairo_egypt,
                        style: AppStyles.medium16Primary,
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.arrow_forward_ios_outlined,
                        color: AppColors.primaryLight,
                        size: 20,
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              SizedBox(height: height * 0.02),
              Image.asset(AppAssets.mapDetails),
              SizedBox(height: height * 0.02),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.description,
                    style: AppStyles.medium16black,
                  ),
                  Text(
                    eventToDisplay.description,
                    style: AppStyles.medium16black,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}*/

import 'package:event_planning_app/model/event.dart';
import 'package:event_planning_app/ui/home/tabs/home_tab/update_event.dart';
import 'package:event_planning_app/utils/app_assets.dart';
import 'package:event_planning_app/utils/app_colors.dart';
import 'package:event_planning_app/utils/app_styles.dart';
import 'package:event_planning_app/utils/toast_utils.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart'; // Import geocoding
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../../providers/event_list_provider.dart';
import '../../../../providers/event_provider.dart';
import '../../../../providers/theme_provider.dart';
import '../../../../providers/user_provider.dart';

class EventDetails extends StatefulWidget {
  static const String routeName = 'EventDetails';

  EventDetails({super.key});

  @override
  State<EventDetails> createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  Event? event;
  late EventListProvider eventListProvider;
  String? locationName;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    eventListProvider = Provider.of<EventListProvider>(context, listen: false);
    fetchEventDetails();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var themeProvider = Provider.of<ThemeProvider>(context);
    var eventProvider = Provider.of<EventProvider>(context);
    var userProvider = Provider.of<UserProvider>(context);
    eventListProvider = Provider.of<EventListProvider>(context);
    final eventToDisplay = event ?? eventProvider.selectedEvent!;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.event_details,
          style: AppStyles.medium20Primary,
        ),
        centerTitle: true,
        actions: [
          InkWell(
            child: Image.asset(AppAssets.editIcon2),
            onTap: () {
              Navigator.of(context).pushNamed(UpdateEvent.routeName);
              setState(() {});
            },
          ),
          SizedBox(width: width * 0.01),
          InkWell(
            child: Image.asset(AppAssets.deleteIcon),
            onTap: () async {
              try {
                await eventListProvider.deleteEvent(
                  userProvider.currentUser!.id,
                  eventProvider.selectedEvent!.id,
                );
                ToastUtils.toastMsg(
                  bgColor: AppColors.redColor,
                  msg: 'Event deleted successfully!',
                  textColor: AppColors.whiteColor,
                );
                Navigator.of(context).pop();
              } catch (error) {
                ToastUtils.toastMsg(
                  bgColor: AppColors.whiteColor,
                  msg: 'Failed to delete event: $error',
                  textColor: AppColors.primaryLight,
                );
                print('Error deleting event: $error');
              }
            },
          ),
          SizedBox(width: width * 0.04),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.04,
          vertical: height * 0.03,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(eventToDisplay.image),
              ),
              SizedBox(height: height * 0.02),
              Text(eventToDisplay.title, style: AppStyles.medium24Primary),
              SizedBox(height: height * 0.02),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: width * 0.02,
                  vertical: height * 0.008,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.primaryLight, width: 1),
                ),
                child: Row(
                  children: [
                    themeProvider.currentTheme == ThemeMode.light
                        ? Image.asset(AppAssets.calenderDetailsLight)
                        : Image.asset(AppAssets.calenderDetailsDark),
                    SizedBox(width: width * 0.02),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          DateFormat('d MMM y').format(eventToDisplay.dateTime),
                          style: AppStyles.medium16Primary,
                        ),
                        Text(
                          eventProvider.selectedEvent!.time.toString(),
                          style: AppStyles.medium16black,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: height * 0.02),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: width * 0.02,
                  vertical: height * 0.008,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.primaryLight, width: 1),
                ),
                child: Row(
                  children: [
                    themeProvider.currentTheme == ThemeMode.light
                        ? Image.asset(AppAssets.locationIcon)
                        : Image.asset(AppAssets.locationIconDark),
                    SizedBox(width: width * 0.02),
                    Expanded(
                      child: Text(
                        locationName ?? "Location loading",
                        style: AppStyles.medium16Primary,
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.arrow_forward_ios_outlined,
                        color: AppColors.primaryLight,
                        size: 20,
                      ),
                      onPressed: () {
                        // todo: Implement navigation to map with the event location
                        if (eventToDisplay.latitude != null &&
                            eventToDisplay.longitude != null) {
                          print(
                            'Navigate to map: Lat=${eventToDisplay.latitude}, Lng=${eventToDisplay.longitude}',
                          );
                        } else {
                          ToastUtils.toastMsg(
                            msg: "Location unavailable",
                            textColor: AppColors.whiteColor,
                            bgColor: AppColors.redColor,
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: height * 0.02),
              Image.asset(AppAssets.mapDetails),
              SizedBox(height: height * 0.02),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.description,
                    style: AppStyles.medium16black,
                  ),
                  Text(
                    eventToDisplay.description,
                    style: AppStyles.medium16black,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> fetchEventDetails() async {
    final eventId =
        Provider.of<EventProvider>(context, listen: false).selectedEvent!.id;
    final fetchedEvent = await eventListProvider.getEventFromList(eventId);
    if (fetchedEvent != null) {
      setState(() {
        event = fetchedEvent;
        getLocationName(fetchedEvent.latitude, fetchedEvent.longitude);
      });
    }
  }

  Future<void> getLocationName(double? latitude, double? longitude) async {
    if (latitude != null && longitude != null) {
      try {
        List<Placemark> placemarks = await placemarkFromCoordinates(
          latitude,
          longitude,
        );
        if (placemarks.isNotEmpty) {
          Placemark place = placemarks[0];
          setState(() {
            locationName =
                '${place.locality}, ${place.administrativeArea}, ${place.country}';
          });
        } else {
          setState(() {
            locationName = "Location not found";
          });
        }
      } catch (e) {
        print('Error getting location name: $e');
        setState(() {
          locationName = "Error getting location";
        });
      }
    } else {
      setState(() {
        locationName = "Location unavailable";
      });
    }
  }
}

/*
import 'package:easy_localization/easy_localization.dart';
import 'package:event_planning_app/Modal/Event.dart';
import 'package:event_planning_app/Providers/EventListProvider.dart';
import 'package:event_planning_app/Providers/UserProvider.dart';
import 'package:event_planning_app/UI/HomeScreen/EventDetails/EditEvent.dart';
import 'package:event_planning_app/Utils/AppAssets.dart';
import 'package:event_planning_app/Utils/AppColors.dart';
import 'package:event_planning_app/Utils/AppStyle.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EventDetails extends StatefulWidget {
  static const routeName = 'EventDetails';

  EventDetails({super.key});

  @override
  State<EventDetails> createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    Event eventArgs = ModalRoute.of(context)?.settings.arguments as Event;
    var eventListProvider = Provider.of<EventListProvider>(context);
    var userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {
            Navigator.of(context).pushNamed(
                EditEvent.routeName,
                arguments: eventArgs);
          }, icon: Icon(Icons.edit_note_outlined)),
          IconButton(onPressed: () {eventListProvider.deleteEvent(eventArgs, userProvider.currentUser!.id);
          Navigator.pop(context);}, icon: Icon(Icons.delete,color: Colors.red,))
        ],
        elevation: 0,
        backgroundColor: AppColors.backgroundlight,
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColors.primarylight),
        title: Text(
          'Event Details'.tr(),
          style: AppStyle.light20PrimaryLight,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: width * .04, vertical: height * .02),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: height * .26,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage(eventArgs.image),
                  ),
                ),
              ),
              SizedBox(height: height * .03),
              Text(
                eventArgs.title,
                style: AppStyle.bold24primarylight,
              ),
              SizedBox(height: height * .03),
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
                          Icons.date_range_outlined,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                    SizedBox(width: height * .02),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          eventArgs.time,
                          style: AppStyle.bold16PrimaryLight,
                        ),
                        Text(
                          DateFormat('ddd/mmm/yyy').format(eventArgs.date),
                          style: AppStyle.bold16Black,
                        )
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: height * .03),
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
                    Text(overflow: TextOverflow.ellipsis,
                      "${eventArgs.country},${eventArgs.city}",
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
              Container(
                height: height * .4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage(AppAssets.gps),
                  ),
                ),
              ),
              SizedBox(height: height * .03),
              Text(
                "Description",
                style: AppStyle.bold16Black,
              ),
              SizedBox(height: height * .01),
              Text(
                eventArgs.description,
                style: AppStyle.bold16Black,
              )
            ],
          ),
        ),
      ),
    );
  }
}*/
