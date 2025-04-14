import 'package:event_planning_app/utils/app_assets.dart';
import 'package:event_planning_app/utils/app_colors.dart';
import 'package:event_planning_app/utils/app_styles.dart';
import 'package:flutter/material.dart';

class EventItem extends StatelessWidget {
  const EventItem({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Container(
      height: height * 0.31,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.primaryLight, width: 1),
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage(AppAssets.birthdayImg),
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
                Text('20', style: AppStyles.bold20Primary),
                Text('Apr', style: AppStyles.bold20Primary),
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
              color: Theme.of(context).indicatorColor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'This is a Birthday Party',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                IconButton(
                  icon: Image.asset(
                    AppAssets.iconFavourite,
                    color: AppColors.primaryLight,
                  ),
                  onPressed: () {
                    //todo: making favourite
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
