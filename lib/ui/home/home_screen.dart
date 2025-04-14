import 'package:event_planning_app/ui/home/tabs/favourite_tab/favourite_tab.dart';
import 'package:event_planning_app/ui/home/tabs/home_tab/home_tab.dart';
import 'package:event_planning_app/ui/home/tabs/map_tab/map_tab.dart';
import 'package:event_planning_app/ui/home/tabs/profile_tab/profile_tab.dart';
import 'package:event_planning_app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../utils/app_assets.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'home_screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  List<Widget> tabs = [
    HomeTab(),
    MapTab(),
    FavouriteTab(),
    ProfileTab()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
            canvasColor: AppColors.transparentColor
        ),
        child: BottomAppBar(
          color: Theme
              .of(context)
              .primaryColor,
          padding: EdgeInsets.zero,
          shape: CircularNotchedRectangle(),
          notchMargin: 2,
          child: BottomNavigationBar(
              currentIndex: selectedIndex,
              onTap: (index) {
                selectedIndex = index;
                setState(() {});
              },
              items: [
                buildBottomNavBarItems(
                    index: 0,
                    unSelectedIconName: AppAssets.iconHome,
                    selectedIconName: AppAssets.iconHomeSelected,
                    label: AppLocalizations.of(context)!.home),
                buildBottomNavBarItems(
                    index: 1,
                    unSelectedIconName: AppAssets.iconMap,
                    selectedIconName: AppAssets.iconMapSelected,
                    label: AppLocalizations.of(context)!.map),
                buildBottomNavBarItems(
                    index: 2,
                    unSelectedIconName: AppAssets.iconFavourite,
                    selectedIconName: AppAssets.iconFavouriteSelected,
                    label: AppLocalizations.of(context)!.favourite),
                buildBottomNavBarItems(
                    index: 3,
                    unSelectedIconName: AppAssets.iconProfile,
                    selectedIconName: AppAssets.iconProfileSelected,
                    label: AppLocalizations.of(context)!.profile),
              ]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
            Icons.add,
            color: AppColors.whiteColor,
            size: 30),
        onPressed: () {
          //todo: navigate to create event
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: tabs[selectedIndex],
    );
  }

  BottomNavigationBarItem buildBottomNavBarItems({
    required String unSelectedIconName,
    required String selectedIconName,
    required int index,
    required String label}) {
    return BottomNavigationBarItem(
        icon: ImageIcon(AssetImage(
            selectedIndex == index ? selectedIconName
                : unSelectedIconName)),
        label: label
    );
  }
}
