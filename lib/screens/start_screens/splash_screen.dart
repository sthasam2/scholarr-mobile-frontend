import "package:flutter/material.dart";
import "package:provider/provider.dart";

import '../../models/models.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  static MaterialPage page() {
    return MaterialPage(
        name: AppPages.splashPath,
        key: ValueKey(AppPages.splashPath),
        child: const SplashScreen());
  }

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Provider.of<AppStateManager>(context, listen: false).initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(
              height: 200,
              image: AssetImage('assets/1024px-Scholarr_logo.png'),
            ),
            Text(
              "Scholarr Mobile",
              style: Theme.of(context).textTheme.headline1,
            )
          ],
        ),
      ),
    );
  }
}
