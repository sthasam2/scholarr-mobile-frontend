import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:scholarr_mobile_frontend/ui/components/components.dart';
import 'package:scholarr_mobile_frontend/models/models.dart';
import 'package:scholarr_mobile_frontend/ui/screens/screens.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
    required this.currentTab,
  }) : super(key: key);

  final int currentTab;

  static MaterialPage page(int currentTab) {
    return MaterialPage(
      name: AppPages.homePath,
      key: ValueKey(AppPages.homePath),
      child: HomeScreen(
        currentTab: currentTab,
      ),
    );
  }

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static List<Widget> pages = <Widget>[
    // static const int home = 0;
    // static const int menu = 1;
    // static const int planner = 2;
    // static const int resources = 3;
    // static const int classgroups = 4;
    // static const int classrooms = 5;
    // static const int settings = 6;
    const MenuScreen(),
    const ClassgroupScreen(),
  ];

  bool _pinned = true;
  bool _floating = false;
  bool _snap = false;

  // @override
  // void initState() {
  //   Provider.of<AppStateManager>(context, listen: false)
  //       .initializeSharedPreferences();
  //   super.initState();
  // }

  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'GOOD MORNING';
    }
    if (hour < 17) {
      return 'GOOD AFTERNOON';
    }
    return 'GOOD EVENING';
  }

  // List schedules = [
  //   {
  //     "title": "COMP 311",
  //     "icon": const Icon(
  //       Icons.computer,
  //       size: 40,
  //     ),
  //     "day": 3,
  //     "person": "Ms. X AB",
  //     "startTime": "12:00",
  //     "endTime": "14:00",
  //     "link": "https:google.com",
  //   },
  //   {
  //     "title": "COMP 311",
  //     "icon": const Icon(
  //       Icons.computer,
  //       size: 40,
  //     ),
  //     "day": 3,
  //     "person": "Ms. X AB",
  //     "startTime": "12:00",
  //     "endTime": "14:00",
  //     "link": "https:google.com",
  //   },
  //   {
  //     "title": "COMP 311",
  //     "icon": const Icon(
  //       Icons.computer,
  //       size: 40,
  //     ),
  //     "day": 3,
  //     "person": "Ms. X AB",
  //     "startTime": "12:00",
  //     "endTime": "14:00",
  //     "link": "https:google.com",
  //   },
  //   {
  //     "title": "COMP 311",
  //     "icon": const Icon(
  //       Icons.computer,
  //       size: 40,
  //     ),
  //     "day": 3,
  //     "person": "Ms. X AB",
  //     "startTime": "12:00",
  //     "endTime": "14:00",
  //     "link": "https:google.com",
  //   },
  // ];

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateManager>(builder: (
      context,
      appStateManager,
      child,
    ) {
      final String? username = appStateManager.getUsername;
      final String? email = appStateManager.getEmail;
      final int? id = appStateManager.getId;

      return Scaffold(
        appBar: AppBar(
          title: Text(
            '',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          automaticallyImplyLeading: false,
        ),
        floatingActionButton: buildMenuFloatingActionButton(
            context, const Icon(Icons.menu_rounded), true),
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
        body: RefreshIndicator(
          onRefresh: () async {},
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            scrollDirection: Axis.vertical,
            children: [
              RichText(
                text: TextSpan(
                    text: greeting() + "\n",
                    style: Theme.of(context).textTheme.bodyMedium,
                    children: [
                      TextSpan(
                        text: username ?? "User",
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ]),
              ),
              const SizedBox(
                height: 40,
              )
            ],
          ),
        ),
      );
    });
  }
}
