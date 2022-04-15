import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../models/models.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  static MaterialPage page() {
    return MaterialPage(
      name: AppPages.onboardingPath,
      key: ValueKey(AppPages.onboardingPath),
      child: const OnboardingScreen(),
    );
  }

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final controller = PageController();
  final Color rwColor = const Color.fromARGB(255, 23, 197, 224);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: const Text('Getting Started'),
        // leading: GestureDetector(
        //   child: const Icon(
        //     Icons.arrow_back_rounded,
        //     size: 35,
        //   ),
        //   onTap: () {
        //     Navigator.pop(context, true);
        //   },
        // ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(child: buildPages(context)),
            buildIndicator(),
            buildActionButtons(context, "Skip to Login"),
          ],
        ),
      ),
    );
  }

  // Onboard screen component builders

  // Skip like button
  Widget buildActionButtons(BuildContext context, String message) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        MaterialButton(
          padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
          child: Text(
            message,
            style: Theme.of(context).textTheme.headline3,
          ),
          onPressed: () {
            Provider.of<AppStateManager>(context, listen: false)
                .completeOnboarding(true);
          },
        ),
      ],
    );
  }

  // Horizontal Scrolling Pages
  Widget buildPages(BuildContext context) {
    return PageView(
      controller: controller,
      children: [
        onboardPageView(
            const AssetImage('assets/onboarding_assets/planner.png'),
            'Plan your educational journey with Planner',
            context),
        onboardPageView(
            const AssetImage('assets/onboarding_assets/resources.png'),
            'Keep track of your class resources!',
            context),
        onboardPageView(
            const AssetImage('assets/onboarding_assets/routine.png'),
            'See your schedules with routine!',
            context),
      ],
    );
  }

  // onboarding page view (single page)
  Widget onboardPageView(
      ImageProvider imageProvider, String text, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Image(
              fit: BoxFit.fitWidth,
              image: imageProvider,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            text,
            style: Theme.of(context).textTheme.bodyText2,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  // Indicator
  Widget buildIndicator() {
    return SmoothPageIndicator(
      controller: controller,
      count: 3,
      effect: WormEffect(activeDotColor: rwColor),
    );
  }
}
