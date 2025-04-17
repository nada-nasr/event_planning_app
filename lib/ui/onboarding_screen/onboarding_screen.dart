import 'package:event_planning_app/utils/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../providers/theme_provider.dart';
import '../../utils/app_colors.dart';
import '../home/home_screen.dart';
import 'onboarding_widget.dart';

class OnboardingScreen extends StatefulWidget {
  static const String routeName = 'onboarding_screen';

  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController pageController = PageController();
  int currentIndex = 0;
  List<Widget> pages = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final themeProvider = Provider.of<ThemeProvider>(context);

    pages = [
      OnboardingWidget(
        imagePath: AppAssets.onboardingImg,
        title: AppLocalizations.of(context)!.find_events_inspire,
        description: AppLocalizations.of(context)!.dive_into_a_world_of_events,
      ),
      OnboardingWidget(
        imagePath:
            themeProvider.currentTheme == ThemeMode.light
                ? AppAssets.onboardingImgLight2
                : AppAssets.onboardingImgDark1,
        title: AppLocalizations.of(context)!.effortless_event_planning,
        description: AppLocalizations.of(context)!.take_the_hassle,
      ),
      OnboardingWidget(
        imagePath:
            themeProvider.currentTheme == ThemeMode.light
                ? AppAssets.onboardingImgLight3
                : AppAssets.onboardingImgDark2,
        title: AppLocalizations.of(context)!.connect_with_friends,
        description:
            AppLocalizations.of(context)!.make_event_memorable_by_sharing,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Image.asset(AppAssets.logoTop), centerTitle: true),
      body: Container(
        margin: EdgeInsets.symmetric(
          horizontal: width * 0.04,
          vertical: height * 0.02,
        ),
        child: Stack(
          children: [
            PageView.builder(
              controller: pageController,
              itemCount: pages.length,
              onPageChanged: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
              itemBuilder: (context, index) => pages[index],
            ),
            currentIndex == 0
                ? SizedBox.shrink()
                : Positioned(
                  bottom: height * 0.001,
                  left: width * 0.02,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                        color: AppColors.primaryLight,
                        width: 1,
                      ),
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: AppColors.primaryLight,
                        size: 28,
                      ),
                      onPressed: () {
                        onClickBack();
                      },
                    ),
                  ),
                ),

            Positioned(
              bottom: height * 0.001,
              right: width * 0.02,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: AppColors.primaryLight, width: 1),
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_forward,
                    color: AppColors.primaryLight,
                    size: 28,
                  ),
                  onPressed: () {
                    onClickNext();
                  },
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: height * 0.03),
              alignment: Alignment.bottomCenter,
              child: SmoothPageIndicator(
                controller: pageController,
                count: pages.length,
                effect: ExpandingDotsEffect(
                  dotHeight: height * 0.009,
                  dotWidth: width * 0.02,
                  dotColor:
                      themeProvider.currentTheme == ThemeMode.dark
                          ? AppColors.whiteColor
                          : AppColors.blackColor,
                  activeDotColor: AppColors.primaryLight,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onClickNext() {
    if (currentIndex < pages.length - 1) {
      pageController.nextPage(
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    } else {
      onClickFinish();
    }
  }

  void onClickFinish() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
  }

  void onClickBack() {
    if (currentIndex > 0) {
      pageController.previousPage(
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOutBack,
      );
    }
  }
}
