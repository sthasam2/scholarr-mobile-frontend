// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:scholarr_mobile_frontend/ui/components/components.dart';
import 'package:scholarr_mobile_frontend/models/models.dart';

import 'package:scholarr_mobile_frontend/models/app_state_manager.dart'
    show AppTab;

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);

  static MaterialPage page() {
    return MaterialPage(
        name: AppPages.menuPath,
        key: ValueKey(AppPages.menuPath),
        child: const MenuScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
          child: Text(
            'SCHOLARR MOBILE',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      backgroundColor: Colors.transparent,
      floatingActionButton: buildMenuFloatingActionButton(
          context, Icon(Icons.close_rounded), false),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Row(
                //   mainAxisSize: MainAxisSize.max,
                //   mainAxisAlignment: MainAxisAlignment.start,
                //   children: [
                //     Padding(
                //       padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                //       child: Text(
                //         "SCHOLARR MOBILE",
                //         style: Theme.of(context).textTheme.headlineMedium,
                //       ),
                //     ),
                //     const Spacer(),
                //   ],
                // ),
                // const SizedBox(
                //   height: 40,
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    menuCard(
                      context,
                      const AssetImage(
                          'assets/menu_assets/calendar-outline.png'),
                      "PLANNER",
                      AppTab.planner,
                    ),
                    const SizedBox(width: 20),
                    menuCard(
                      context,
                      const AssetImage('assets/menu_assets/moon-outline.png'),
                      "RESOURCES",
                      AppTab.resources,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    menuCard(
                      context,
                      const AssetImage(
                          'assets/menu_assets/classgroup-outline.png'),
                      "CLASSGROUP",
                      AppTab.classgroups,
                    ),
                    const SizedBox(width: 20),
                    menuCard(
                      context,
                      const AssetImage(
                          'assets/menu_assets/classroom-outline.png'),
                      "CLASSROOM",
                      AppTab.classrooms,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    menuCard(
                      context,
                      const AssetImage(
                          'assets/menu_assets/calendar-outline.png'),
                      "SCHEDULE",
                      AppTab.schedule,
                    ),
                    const SizedBox(width: 20),
                    menuCard(
                      context,
                      const AssetImage(
                          'assets/menu_assets/settings-outline.png'),
                      "SETTINGS",
                      AppTab.settings,
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
