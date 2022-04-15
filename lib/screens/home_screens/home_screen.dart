import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:scholarr_mobile_frontend/components/components.dart';
import 'package:scholarr_mobile_frontend/models/models.dart';
import 'package:scholarr_mobile_frontend/screens/screens.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
    required this.currentTab,
  }) : super(key: key);

  final int currentTab;

  static MaterialPage page(int currentTab) {
    return MaterialPage(
      name: AppPages.home,
      key: ValueKey(AppPages.home),
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
    const MenuScreen(),
  ];

  bool _pinned = true;
  bool _floating = false;
  bool _snap = false;

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

  List schedules = [
    {
      "title": "COMP 311",
      "icon": const Icon(
        Icons.computer,
        size: 40,
      ),
      "day": 3,
      "person": "Ms. X AB",
      "startTime": "12:00",
      "endTime": "14:00",
      "link": "https:google.com",
    },
    {
      "title": "COMP 311",
      "icon": const Icon(
        Icons.computer,
        size: 40,
      ),
      "day": 3,
      "person": "Ms. X AB",
      "startTime": "12:00",
      "endTime": "14:00",
      "link": "https:google.com",
    },
    {
      "title": "COMP 311",
      "icon": const Icon(
        Icons.computer,
        size: 40,
      ),
      "day": 3,
      "person": "Ms. X AB",
      "startTime": "12:00",
      "endTime": "14:00",
      "link": "https:google.com",
    },
    {
      "title": "COMP 311",
      "icon": const Icon(
        Icons.computer,
        size: 40,
      ),
      "day": 3,
      "person": "Ms. X AB",
      "startTime": "12:00",
      "endTime": "14:00",
      "link": "https:google.com",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateManager>(builder: (
      context,
      appStateManager,
      child,
    ) {
      return Scaffold(
        // appBar: AppBar(
        //   title: Text(
        //     'Home',
        //     style: Theme.of(context).textTheme.headline6,
        //   ),
        //   automaticallyImplyLeading: false,
        // ),
        floatingActionButton: buildMenuFloatingActionButton(
            context, Icon(Icons.menu_rounded), true),
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
        body: ListView(
          padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
          scrollDirection: Axis.vertical,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 40, 0, 40),
                      child: RichText(
                        text: TextSpan(
                            text: greeting(),
                            style: Theme.of(context).textTheme.bodyText2,
                            children: [
                              TextSpan(
                                text: "\nYour name",
                                style: Theme.of(context).textTheme.headline2,
                              ),
                            ]),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   mainAxisSize: MainAxisSize.min,
                //   children: [
                //     buildScheduleListView(context, schedules),
                //   ],
                // )
              ],
            )
          ],
        ),
      );
    });
  }
}
