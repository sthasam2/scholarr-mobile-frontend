import 'package:flutter/material.dart';

import '../models/models.dart';
import '../screens/screens.dart';

class AppRouter extends RouterDelegate
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  @override
  final GlobalKey<NavigatorState> navigatorKey;

  final AppStateManager appStateManager;

  AppRouter({
    required this.appStateManager,
  }) : navigatorKey = GlobalKey<NavigatorState>() {
    appStateManager.addListener(notifyListeners);
  }

  @override
  void dispose() {
    appStateManager.removeListener(notifyListeners);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      onPopPage: _handlePopPage,
      pages: [
        if (!appStateManager.isInitialized) SplashScreen.page(),
        if (appStateManager.isInitialized) OnboardingScreen.page(),
        if (appStateManager.isOnboardingComplete) LoginScreen.page(),
        if (!appStateManager.isLoggedIn && appStateManager.getSelectedAuth == 1)
          SignUpScreen.page(),
        // MenuScreen.page(),
        if (!appStateManager.isLoggedIn && appStateManager.getSelectedAuth == 2)
          ForgotPasswordScreen.page(),
        if (!appStateManager.isLoggedIn && appStateManager.getSelectedAuth == 3)
          ResetPasswordScreen.page(),
      ],
    );
  }

  bool _handlePopPage(Route<dynamic> route, result) {
    if (!route.didPop(result)) {
      return false;
    }

    if (appStateManager.getSelectedAuth == 1 ||
        appStateManager.getSelectedAuth == 2) {
      appStateManager.goToAuthPage(0);
    }
    if (appStateManager.getSelectedAuth == 3) {
      appStateManager.goToAuthPage(2);
    }

    return true;
  }

  @override
  Future<void> setNewRoutePath(configuration) async => null;
}
