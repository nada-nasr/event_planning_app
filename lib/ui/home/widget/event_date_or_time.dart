import 'package:event_planning_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/theme_provider.dart';

class EventDateOrTime extends StatelessWidget {
  String iconDateOrTime;
  String eventDateOrTime;
  String choosetDateOrTime;
  Function onChooseDateOrTime;

  EventDateOrTime({
    required this.iconDateOrTime,
    required this.eventDateOrTime,
    required this.choosetDateOrTime,
    required this.onChooseDateOrTime,
  });

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var themeProvider = Provider.of<ThemeProvider>(context);
    return Row(
      children: [
        Image.asset(iconDateOrTime),
        SizedBox(width: width * 0.04),
        Expanded(
          child: Text(
            eventDateOrTime,
            style:
                themeProvider.currentTheme == ThemeMode.light
                    ? AppStyles.medium16black
                    : AppStyles.medium16white,
          ),
        ),
        TextButton(
          child: Text(choosetDateOrTime, style: AppStyles.medium16Primary),
          onPressed: () {
            onChooseDateOrTime();
          },
        ),
      ],
    );
  }
}
