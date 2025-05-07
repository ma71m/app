import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:sahla/app_styles.dart';
import 'package:sahla/screens/login_screen.dart';
import 'package:sahla/utils/slideRoute.dart';

class WelcomeScreen extends StatelessWidget {
  final List<String> pageTitles = [
    'SAHLA App',
    'Lower Prices\nwith Every Purchase!',
    'Share More,\nSave More!',
    'Earn Rewards\nWhile You Save!',
  ];

  final List<String> pageDescriptions = [
    'The more buyers, the lower the price!',
    'Every time someone buys a deal, the price drops for everyone. Join the group and save more!',
    'Share deals with friends to lower the price faster. Everyone wins when more people join in!',
    'Earn exclusive rewards for every purchase and share. Redeem your points for more great deals!',
  ];

  final List<Widget> pageBackgrounds = [
    // TODO we r not going to use backgrounds we put the images in the bodies
    Image.asset(
      'assets/onboarding_images/background1x1w.jpeg',
      fit: BoxFit.none,
    ),
    Image.asset(
      'assets/onboarding_images/background1x1w.jpeg',
      fit: BoxFit.none,
    ),
    Image.asset(
      'assets/onboarding_images/background1x1w.jpeg',
      fit: BoxFit.none,
    ),
    Image.asset(
      'assets/onboarding_images/background1x1w.jpeg',
      fit: BoxFit.none,
    ),
  ];

  final List<Widget> bodyImages = [
    Image.asset(
      'assets/onboarding_images/page1.png',
      fit: BoxFit.contain,
    ),
    Image.asset(
      'assets/onboarding_images/page2.png',
      fit: BoxFit.contain,
    ),
    Image.asset(
      'assets/onboarding_images/page3.png',
      fit: BoxFit.contain,
    ),
    Image.asset(
      'assets/onboarding_images/page4.png',
      fit: BoxFit.cover,
    ),
  ];

   WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return OnBoardingSlider(
      totalPage: pageTitles.length,
      headerBackgroundColor: Colors.white,
      pageBodies: _buildPageBodies(),
      onFinish: () {
        Navigator.pushReplacement(
            context, SlideRoute(page: const MainView(index: 1)));
      },
      finishButtonText: 'Get Started',
      finishButtonStyle: const FinishButtonStyle(
        backgroundColor: AppStyles.primaryColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
      ),
      speed: 1.8,
      background: pageBackgrounds,
    );
  }

  List<Widget> _buildPageBodies() {
    return List.generate(
      pageTitles.length,
      (index) => _buildPage(
        pageTitles[index],
        pageDescriptions[index],
        bodyImages[index],
      ),
    );
  }

  Widget _buildPage(String title, String description,Widget image) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 48),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          image,
          SizedBox(height: 30,),
          Text(
            title,textAlign: TextAlign.center,
            style: AppStyles.primaryFont.copyWith(
              fontSize: 29,
              color: AppStyles.primaryColor,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            description,
            style: AppStyles.secondaryFont.copyWith(
              fontSize: 16,
              color: AppStyles.black1,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
