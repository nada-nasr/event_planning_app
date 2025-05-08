import 'package:event_planning_app/model/event.dart';
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
}
