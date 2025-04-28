import 'package:event_planning_app/ui/home/widget/custom_text_field.dart';
import 'package:event_planning_app/utils/app_colors.dart';
import 'package:event_planning_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../home_tab/event_item.dart';

class FavouriteTab extends StatelessWidget {
  const FavouriteTab({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery
        .of(context)
        .size
        .width;
    var height = MediaQuery
        .of(context)
        .size
        .height;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.04),
        child: Column(
          children: [
            SizedBox(height: height * 0.08),
            CustomTextField(
              borderColor: AppColors.primaryLight,
              hintText: AppLocalizations.of(context)!.search_event,
              hintStyle: AppStyles.bold14Primary,
              prefixIcon: Icon(Icons.search, color: AppColors.primaryLight,),

              ///labelText: 'Search',
              ///suffixIcon: Icon(Icons.search, color: AppColors.primaryLight,),
            ),
            SizedBox(height: height * 0.02),
            Expanded(
              child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: width * 0.01,
                          vertical: height * 0.01
                      ),
                        child: Container()

                      ///EventItem(),
                    );
                  },
                  itemCount: 20),
            )
          ],
        ),
      ),

    );
  }
}
