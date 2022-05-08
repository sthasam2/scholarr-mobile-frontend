import 'package:flutter/material.dart';

import 'package:scholarr_mobile_frontend/models/models.dart';
import 'package:scholarr_mobile_frontend/ui/screens/screens.dart';

class AppRouter extends RouterDelegate
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  @override
  final GlobalKey<NavigatorState> navigatorKey;

  final AppStateManager appStateManager;
  final ClassgroupManager classgroupManager;
  final ClassroomManager classroomManager;
  final ClasscontentManager classroomContentManager;

  AppRouter({
    required this.appStateManager,
    required this.classgroupManager,
    required this.classroomManager,
    required this.classroomContentManager,
  }) : navigatorKey = GlobalKey<NavigatorState>() {
    appStateManager.addListener(notifyListeners);
    classgroupManager.addListener(notifyListeners);
    classroomManager.addListener(notifyListeners);
    classroomContentManager.addListener(notifyListeners);
  }

  @override
  void dispose() {
    appStateManager.removeListener(notifyListeners);
    classgroupManager.removeListener(notifyListeners);
    classroomManager.removeListener(notifyListeners);
    classroomContentManager.removeListener(notifyListeners);
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

        // CLASSROOM
        if (appStateManager.isLoggedIn &&
            appStateManager.getSelectedTab == AppTab.classrooms)
          ClassroomScreen.page(),
        if (classroomManager.isCreatingNewItem) ClassroomItemScreen.page(),
        if (classroomManager.isGettingDetail)
          ClassroomDetailScreen.page(classroomManager),

        // CLASSCONTENT
        if (classroomContentManager.isCreatingNewItem)
          ClassContentItemScreen.page(
            classcontentManager: classroomContentManager,
          ),
        if (classroomContentManager.isGettingDetail)
          ClassroomContentDetailScreen.page(
            classcontentManager: classroomContentManager,
          ),
        if (classroomContentManager.isCreatingSubmissionItem)
          ClassworkSubmissionItemScreen.page(
            classcontentManager: classroomContentManager,
          ),
        if (classroomContentManager.isGettingSubmissionDetail)
          SubmissionDetailScreen.page(
            classcontentManager: classroomContentManager,
          ),

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

    // CLASSROOM
    if (route.settings.name == AppPages.classroomPath) {
      // appStateManager.showMenu(true);
      appStateManager.goToTab(AppTab.home);
    }
    if (route.settings.name == AppPages.classroomItemPath) {
      classroomManager.cancelCreateNewItem();
    }
    if (route.settings.name == AppPages.classroomItemDetailPath) {
      classroomManager.resetClassroomDetail();
    }

    // CLASSCONTENT
    if (route.settings.name == AppPages.classroomContentPath) {
      appStateManager.goToTab(AppTab.home);
    }
    if (route.settings.name == AppPages.classroomContentItemPath) {
      classroomContentManager.cancelCreateNewItem();
    }
    if (route.settings.name == AppPages.classroomContentItemDetailPath) {
      classroomContentManager.resetClasscontentDetail();
    }
    if (route.settings.name == AppPages.classroomContentSubmissionItemPath) {
      classroomContentManager.cancelCreateSubmissionItem();
    }
    if (route.settings.name == AppPages.submissionItemDetailPath) {
      classroomContentManager.resetClassworkSubmissionDetail();
      classroomContentManager.setDetailClasscontentTypeAsClasswork();
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
