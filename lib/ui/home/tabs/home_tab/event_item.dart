import 'package:event_planning_app/model/event.dart';
import 'package:event_planning_app/providers/event_list_provider.dart';
import 'package:event_planning_app/ui/home/tabs/home_tab/event_details.dart';
import 'package:event_planning_app/utils/app_assets.dart';
import 'package:event_planning_app/utils/app_colors.dart';
import 'package:event_planning_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../providers/event_provider.dart';
import '../../../../providers/user_provider.dart';

class EventItem extends StatelessWidget {
  Event event;

  EventItem({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var eventListProvider = Provider.of<EventListProvider>(context);
    var userProvider = Provider.of<UserProvider>(context);
    return InkWell(
      child: Container(
        height: height * 0.31,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.primaryLight, width: 1),
          image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage(event.image)
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.02,
                vertical: height * 0.001,
              ),
              margin: EdgeInsets.symmetric(
                horizontal: width * 0.02,
                vertical: height * 0.01,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: AppColors.whiteColor,
              ),
              child: Column(
                children: [
                  Text(event.dateTime.day.toString(),
                      style: AppStyles.bold20Primary),
                  Text(
                      DateFormat('MMM').format(event.dateTime),
                      style: AppStyles.bold20Primary),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.02,
                vertical: height * 0.001,
              ),
              margin: EdgeInsets.symmetric(
                horizontal: width * 0.02,
                vertical: height * 0.01,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Theme
                    .of(context)
                    .indicatorColor,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      event.title,
                      style: Theme
                          .of(context)
                          .textTheme
                          .bodyLarge,
                    ),
                  ),
                  IconButton(
                    icon: event.isFavourite == true
                        ? Image.asset(
                        AppAssets.iconFavouriteSelected,
                        color: AppColors.primaryLight)
                        : Image.asset(
                      AppAssets.iconFavourite,
                      color: AppColors.primaryLight,
                    ),
                    onPressed: () {
                      //todo: making favourite
                      eventListProvider.updateIsFavouriteEvents(
                          event, userProvider.currentUser!.id);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        var eventProvider = Provider.of<EventProvider>(context, listen: false);
        eventProvider.setSelectedEvent(event);
        Navigator.of(context).pushNamed(EventDetails.routeName);
      },
    );
  }
}
