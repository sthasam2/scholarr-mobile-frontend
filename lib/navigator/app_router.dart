import 'package:flutter/material.dart';
import 'package:scholarr_mobile_frontend/models/classgroup_manager.dart';

import 'package:scholarr_mobile_frontend/models/models.dart';
import 'package:scholarr_mobile_frontend/ui/screens/home_screens/classgroup_screens/classgroup_detail_screen.dart';
import 'package:scholarr_mobile_frontend/ui/screens/screens.dart';
import 'package:scholarr_mobile_frontend/models/app_state_manager.dart'
    show AppTab;

class AppRouter extends RouterDelegate
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  @override
  final GlobalKey<NavigatorState> navigatorKey;

  final AppStateManager appStateManager;
  final ClassgroupManager classgroupManager;

  AppRouter({
    required this.appStateManager,
    required this.classgroupManager,
  }) : navigatorKey = GlobalKey<NavigatorState>() {
    appStateManager.addListener(notifyListeners);
    classgroupManager.addListener(notifyListeners);
  }

  @override
  void dispose() {
    appStateManager.removeListener(notifyListeners);
    classgroupManager.removeListener(notifyListeners);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      onPopPage: _handlePopPage,
      pages: [
        //
        // START SCREENS
        if (!appStateManager.isInitialized) SplashScreen.page(),
        if (appStateManager.isInitialized) OnboardingScreen.page(),
        //
        // AUTH SCREENS
        if (appStateManager.isOnboardingComplete) LoginScreen.page(),
        if (!appStateManager.isLoggedIn && appStateManager.getSelectedAuth == 1)
          SignUpScreen.page(),
        if (!appStateManager.isLoggedIn && appStateManager.getSelectedAuth == 2)
          ForgotPasswordScreen.page(),
        if (!appStateManager.isLoggedIn && appStateManager.getSelectedAuth == 3)
          ResetPasswordScreen.page(),
        //
        // HOME SCREENS
        if (appStateManager.isLoggedIn)
          HomeScreen.page(appStateManager.getSelectedTab),

        // CLASSGROUP
        if (appStateManager.isLoggedIn &&
            appStateManager.getSelectedTab == AppTab.classgroups)
          ClassgroupScreen.page(),
        if (classgroupManager.isCreatingNewItem) ClassgroupItemScreen.page(),
        if (classgroupManager.isGettingDetail)
          ClassgroupDetailScreen.page(classgroupManager),

        // SETTINGS
        if (appStateManager.isLoggedIn &&
            appStateManager.getSelectedTab == AppTab.settings)
          SettingsScreen.page(),

        // MENU
        if (appStateManager.isMenuTapped) MenuScreen.page(),
      ],
    );
  }

  bool _handlePopPage(Route<dynamic> route, result) {
    if (!route.didPop(result)) {
      return false;
    }
    /////////////////////////
    // HOME
    /////////////////////////
    if (route.settings.name == AppPages.homePath) {
      appStateManager.goToTab(AppTab.home);
    }

    // CLASSGROUP
    if (route.settings.name == AppPages.classgroupPath) {
      // appStateManager.showMenu(true);
      appStateManager.goToTab(AppTab.home);
    }
    if (route.settings.name == AppPages.classgroupItemPath) {
      classgroupManager.cancelCreateNewItem();
    }
    if (route.settings.name == AppPages.classgroupItemDetailPath) {
      classgroupManager.resetClassgroupDetail();
    }

    if (route.settings.name == AppPages.classgroupItemPath) {
      appStateManager.goToTab(AppTab.classgroups);
    }
    if (route.settings.name == AppPages.classgroupItemDetailPath) {
      classgroupManager.resetClassgroupDetail();
    }

    // MENU
    if (appStateManager.isMenuTapped == true) {
      appStateManager.showMenu(false);
    }

    // SETTINGS
    if (route.settings.name == AppPages.settingsPath) {
      appStateManager.goToTab(AppTab.home);
    }
    /////////////////////////
    // AUTH
    /////////////////////////
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
