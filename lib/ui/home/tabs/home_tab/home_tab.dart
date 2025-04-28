import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_planning_app/firebase_utils.dart';
import 'package:event_planning_app/ui/home/tabs/home_tab/event_item.dart';
import 'package:event_planning_app/ui/home/tabs/home_tab/event_tab_item.dart';
import 'package:event_planning_app/utils/app_assets.dart';
import 'package:event_planning_app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../../model/event.dart';
import '../../../../utils/app_styles.dart';

class HomeTab extends StatefulWidget {
  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  int selectedIndex = 0;
  List<Event> eventsList = [];

  @override
  Widget build(BuildContext context) {
    getAllEvents();
    var width = MediaQuery
        .of(context)
        .size
        .width;
    var height = MediaQuery
        .of(context)
        .size
        .height;
    List<String> eventsNameList = [
      AppLocalizations.of(context)!.all,
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme
            .of(context)
            .primaryColor,
        title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(AppLocalizations.of(context)!.welcome_back,
                        style: AppStyles.regular14white),
                    Text('Route Academy',
                        style: AppStyles.bold24white)
                  ]),
              Row(
                  children: [
                    Image.asset(AppAssets.iconTheme),
                    SizedBox(width: width * 0.02),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: width * 0.02,
                          vertical: height * 0.01
                      ),
                      decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(8)
                      ),
                      child: Text('EN',
                          style: AppStyles.bold14Primary),
                    )
                  ])
            ]),
      ),
      body: Column(
          children: [
            Container(
              height: height * 0.14,
              padding: EdgeInsets.symmetric(horizontal: width * 0.03),
              decoration: BoxDecoration(
                  color: Theme
                      .of(context)
                      .primaryColor,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20)
                  )
              ),
              child: Column(
                  children: [
                    SizedBox(height: height * 0.01),
                    Row(
                        children: [
                          Image.asset(AppAssets.iconMap),
                          SizedBox(width: width * 0.01),
                          Text('Cairo, Egypt',
                            style: AppStyles.medium14white,)
                        ]),
                    SizedBox(height: height * 0.02),
                    DefaultTabController(
                        length: eventsNameList.length,
                        child: TabBar(
                            onTap: (index) {
                              selectedIndex = index;
                              setState(() {});
                            },
                            isScrollable: true,
                            tabAlignment: TabAlignment.start,
                            indicatorColor: AppColors.transparentColor,
                            dividerColor: AppColors.transparentColor,
                            labelPadding: EdgeInsets.zero,
                            tabs: [
                              EventTabItem(
                                  eventName: eventsNameList[0],
                                  iconName: AntDesign.compass_outline,
                                  isSelected: selectedIndex ==
                                      eventsNameList.indexOf(eventsNameList[0]),
                                selectedBackgroundColor: Theme
                                    .of(context)
                                    .focusColor,
                                selectedTextStyle: Theme
                                    .of(context)
                                    .textTheme
                                    .headlineSmall!,
                                unSelectedTextStyle: AppStyles.medium16white,
                              ),
                              EventTabItem(
                                  eventName: eventsNameList[1],
                                  iconName: Icons.directions_bike_rounded,
                                  isSelected: selectedIndex ==
                                      eventsNameList.indexOf(eventsNameList[1]),
                                selectedBackgroundColor: Theme
                                    .of(context)
                                    .focusColor,
                                selectedTextStyle: Theme
                                    .of(context)
                                    .textTheme
                                    .headlineSmall!,
                                unSelectedTextStyle: AppStyles.medium16white,
                              ),
                              EventTabItem(
                                  eventName: eventsNameList[2],
                                  iconName: Icons.cake_outlined,
                                  isSelected: selectedIndex ==
                                      eventsNameList.indexOf(eventsNameList[2]),
                                selectedBackgroundColor: Theme
                                    .of(context)
                                    .focusColor,
                                selectedTextStyle: Theme
                                    .of(context)
                                    .textTheme
                                    .headlineSmall!,
                                unSelectedTextStyle: AppStyles.medium16white,
                              ),
                              EventTabItem(
                                  eventName: eventsNameList[3],
                                  iconName: Icons.laptop_mac_rounded,
                                  isSelected: selectedIndex ==
                                      eventsNameList.indexOf(eventsNameList[3]),
                                selectedBackgroundColor: Theme
                                    .of(context)
                                    .focusColor,
                                selectedTextStyle: Theme
                                    .of(context)
                                    .textTheme
                                    .headlineSmall!,
                                unSelectedTextStyle: AppStyles.medium16white,
                              ),
                              EventTabItem(
                                  eventName: eventsNameList[4],
                                  iconName: Iconsax.game_outline,
                                  isSelected: selectedIndex ==
                                      eventsNameList.indexOf(eventsNameList[4]),
                                selectedBackgroundColor: Theme
                                    .of(context)
                                    .focusColor,
                                selectedTextStyle: Theme
                                    .of(context)
                                    .textTheme
                                    .headlineSmall!,
                                unSelectedTextStyle: AppStyles.medium16white,
                              ),
                              EventTabItem(
                                  eventName: eventsNameList[5],
                                  iconName: Icons.work_rounded,
                                  isSelected: selectedIndex ==
                                      eventsNameList.indexOf(eventsNameList[5]),
                                selectedBackgroundColor: Theme
                                    .of(context)
                                    .focusColor,
                                selectedTextStyle: Theme
                                    .of(context)
                                    .textTheme
                                    .headlineSmall!,
                                unSelectedTextStyle: AppStyles.medium16white,
                              ),
                              EventTabItem(
                                  eventName: eventsNameList[6],
                                  iconName: EvaIcons.book,
                                  isSelected: selectedIndex ==
                                      eventsNameList.indexOf(eventsNameList[6]),
                                selectedBackgroundColor: Theme
                                    .of(context)
                                    .focusColor,
                                selectedTextStyle: Theme
                                    .of(context)
                                    .textTheme
                                    .headlineSmall!,
                                unSelectedTextStyle: AppStyles.medium16white,
                              ),
                              EventTabItem(
                                  eventName: eventsNameList[7],
                                  iconName: Icons.museum_rounded,
                                  isSelected: selectedIndex ==
                                      eventsNameList.indexOf(eventsNameList[7]),
                                selectedBackgroundColor: Theme
                                    .of(context)
                                    .focusColor,
                                selectedTextStyle: Theme
                                    .of(context)
                                    .textTheme
                                    .headlineSmall!,
                                unSelectedTextStyle: AppStyles.medium16white,
                              ),
                              EventTabItem(
                                  eventName: eventsNameList[8],
                                  iconName: Clarity.on_holiday_line,
                                  isSelected: selectedIndex ==
                                      eventsNameList.indexOf(eventsNameList[8]),
                                selectedBackgroundColor: Theme
                                    .of(context)
                                    .focusColor,
                                selectedTextStyle: Theme
                                    .of(context)
                                    .textTheme
                                    .headlineSmall!,
                                unSelectedTextStyle: AppStyles.medium16white,
                              ),
                              EventTabItem(
                                  eventName: eventsNameList[9],
                                  iconName: Icons.fastfood_outlined,
                                  isSelected: selectedIndex ==
                                      eventsNameList.indexOf(eventsNameList[9]),
                                selectedBackgroundColor: Theme
                                    .of(context)
                                    .focusColor,
                                selectedTextStyle: Theme
                                    .of(context)
                                    .textTheme
                                    .headlineSmall!,
                                unSelectedTextStyle: AppStyles.medium16white,
                              ),
                            ]
                          /*eventsNameList.map((eventsName){
                          return EventTabItem(
                              iconName: AntDesign.compass_outline,
                              eventName: eventsName,
                              isSelected: selectedIndex ==
                              eventsNameList.indexOf(eventsName)
                          );
                          }).toList()*/

                        )
                    )
                  ]),
            ),
            Expanded(
              child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: width * 0.04,
                          vertical: height * 0.02
                      ),
                      child: EventItem(
                          event: eventsList[index]
                      ),
                    );
                  },
                  itemCount: eventsList.length
              ),
            )
          ]),
    );
  }

  void getAllEvents() async {
    print('in first');
    QuerySnapshot<Event> querySnapshot = await FirebaseUtils
        .getEventsCollection().get();

    /// List<Event>    List<QueryDocumentSnapshot<Event>>
    eventsList = querySnapshot.docs.map((doc) {
      return doc.data();
    }).toList();
    print('in last');
  }
}
