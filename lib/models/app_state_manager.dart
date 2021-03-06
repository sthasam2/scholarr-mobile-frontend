import 'dart:async';

import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:scholarr_mobile_frontend/cache/cache.dart';
import 'package:scholarr_mobile_frontend/models/app_pages.dart';

class AppTab {
  static const int menu = -1;
  static const int home = 0;
  static const int planner = 1;
  static const int resources = 2;
  static const int classgroups = 3;
  static const int classrooms = 4;
  static const int schedule = 5;
  static const int settings = 6;
}

class AuthPages {
  static const int login = 0;
  static const int signUp = 1;
  static const int forgotPw = 2;
  static const int resetPw = 3;
}

class AppStateManager extends ChangeNotifier {
  ///////////////////////////////
  /// ATTRIBUTES
  ///////////////////////////////
  // bool _initialized = true;
  // bool _onboardingComplete = true;
  bool _initialized = false;
  bool _onboardingComplete = false;

  final bool _isForgotPassword = false;
  bool _isSigningUp = false;
  bool _loggedIn = false;

  String? _username;
  String? _email;
  int? _id;

  int _selectedTab = AppTab.home;
  int _selectedAuth = AuthPages.login;

  bool _isMenuTapped = false;

  ///////////////////////////////
  /// METHODS
  ///////////////////////////////
  bool get isInitialized => _initialized;
  bool get isOnboardingComplete => _onboardingComplete;
  bool get isLoggedIn => _loggedIn;
  bool get isSigningUp => _isSigningUp;
  bool get isForgotPassword => _isForgotPassword;
  int get getSelectedTab => _selectedTab;
  int get getSelectedAuth => _selectedAuth;
  bool get isMenuTapped => _isMenuTapped;
  String? get getUsername => _username;
  String? get getEmail => _email;
  int? get getId => _id;

  void initializeApp() async {
    Timer(
      const Duration(milliseconds: 2000),
      () {
        _initialized = true;
        notifyListeners();
      },
    );

    final sharedPreferences = await SharedPreferences.getInstance();
    final bool? loggedIn = sharedPreferences.getBool(prefLoggedIn);
    final bool? onboardingComplete =
        sharedPreferences.getBool(prefOnboardingComplete);

    if (onboardingComplete != null) {
      completeOnboarding(onboardingComplete);
    }
    if (loggedIn != null) {
      login(loggedIn);
    }

    initializeSharedPreferences();
  }

  void initializeSharedPreferences() async {
    final sharedPreferences = await SharedPreferences.getInstance();

    _username = sharedPreferences.getString(prefLoginUsername);
    _email = sharedPreferences.getString(prefLoginEmail);
    _id = sharedPreferences.getInt(prefLoginId);
  }

  void completeOnboarding(bool completed) async {
    _onboardingComplete = completed;

    final sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool(prefOnboardingComplete, completed);

    notifyListeners();
  }

  void login(bool loggedin) {
    _loggedIn = loggedin;

    notifyListeners();
  }

  void logout() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool(prefLoggedIn, false);
    await sharedPreferences.remove(prefLoginAccess);
    await sharedPreferences.remove(prefLoginRefresh);
    await sharedPreferences.remove(prefLoginUsername);
    await sharedPreferences.remove(prefLoginId);
    await sharedPreferences.remove(prefLoginEmail);
    _loggedIn = false;
    goToTab(0);
    notifyListeners();
  }

  void signUpCall() {
    _selectedAuth = 1;
    notifyListeners();
  }

  void signUp(
    String username,
    String email,
    String password,
  ) {
    _isSigningUp = true;

    notifyListeners();
  }

  void forgotPassword() {
    _selectedAuth = 2;
    notifyListeners();
  }

  void showMenu(bool isTapped) {
    _isMenuTapped = isTapped;
    notifyListeners();
  }

  void goToTab(index) {
    _selectedTab = index;
    notifyListeners();
  }

  void goToAuthPage(index) {
    _selectedAuth = index;
    notifyListeners();
  }
}
