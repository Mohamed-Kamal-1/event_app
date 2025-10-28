import 'package:evently_app/ui/onboarding/display_screen.dart';
import 'package:evently_app/ui/onboarding/onboarding_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../core/colors/app_color.dart';
import '../../core/routes/app_routes.dart';

class CompleteOnboardingScreen extends StatefulWidget {
  @override
  State<CompleteOnboardingScreen> createState() =>
      _CompleteOnboardingScreenState();
}

class _CompleteOnboardingScreenState extends State<CompleteOnboardingScreen> {
  bool? isLight;

  final PageController _controller = PageController();
  List<OnboardingData> onboardingData = OnboardingData.getOnboardingData();

  int selectIndex = 0;
  String netPage = 'Next';

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        PageView.builder(
          controller: _controller,
          physics: const BouncingScrollPhysics(),
          itemCount: onboardingData.length,
          onPageChanged: (newIndex) {
            selectIndex = newIndex;
            netPage = (newIndex == onboardingData.length - 1)
                ? 'Finish'
                : 'Next';
            setState(() {
              final isLight =
              ModalRoute
                  .of(context)!
                  .settings
                  .arguments as bool;
              onboardingData = OnboardingData.getOnboardingData(
                isThemeLight: isLight,
              );
            });
          },
          itemBuilder: (context, index) {
            return DisplayScreen(onboardingData: onboardingData[index]);
          },
        ),
        Container(
          margin: EdgeInsets.symmetric(
            horizontal: 20,
            vertical: MediaQuery
                .of(context)
                .size
                .height * 0.045,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Visibility(
                visible: (selectIndex != 0),
                child: FloatingActionButton(
                  onPressed: () {
                    clickOnPreviousPage();
                  },
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  foregroundColor: AppColor.bluePrimaryColor,
                  mini: true,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: AppColor.bluePrimaryColor,
                      width: 1.5,
                    ),
                    borderRadius: BorderRadiusGeometry.circular(360),
                  ),
                  child: Icon(Icons.arrow_back),
                ),
              ),

              SmoothPageIndicator(
                controller: _controller,
                count: onboardingData.length,
                effect: WormEffect(
                  activeDotColor: AppColor.whitePrimaryColor,
                  dotColor: AppColor.bluePrimaryColor,
                ),
              ),
              FloatingActionButton(
                onPressed: () {
                  clickOnNextPage();
                },
                backgroundColor: Colors.transparent,
                elevation: 0,
                foregroundColor: AppColor.bluePrimaryColor,
                mini: true,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: AppColor.bluePrimaryColor,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadiusGeometry.circular(360),
                ),
                child: Icon(Icons.arrow_back),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void clickOnPreviousPage() {
    _controller.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInSine,
    );
  }

  Future<void> clickOnNextPage() async {
    if (selectIndex == onboardingData.length - 1) {
      Navigator.pushReplacementNamed(context, AppRoutes.LoginScreen.name);
      return;
    }
    _controller.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOutSine,
    );
  }
}
