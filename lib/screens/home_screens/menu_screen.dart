// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../../../components/components.dart';
import '../../../models/models.dart';

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
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: Text(
                        "SCHOLARR MOBILE",
                        style: Theme.of(context).textTheme.headline2,
                      ),
                    ),
                    const Spacer(),
                    // SizedBox(
                    //   width: 70,
                    //   height: 70,
                    //   child: Padding(
                    //     padding: const EdgeInsets.all(8.0),
                    //     child: MaterialButton(
                    //       color: Colors.grey[800]?.withAlpha(100),
                    //       shape: RoundedRectangleBorder(
                    //           borderRadius: BorderRadius.circular(15)),
                    //       child: const Icon(Icons.close_rounded),
                    //       onPressed: () async {
                    //         Provider.of<AppStateManager>(context, listen: false)
                    //             .showMenu(false);
                    //         Navigator.pop(context, true);
                    //       },
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    menuCard(
                        context,
                        const AssetImage(
                            'assets/menu_assets/calendar-outline.png'),
                        "PLANNER"),
                    const SizedBox(width: 20),
                    menuCard(
                        context,
                        const AssetImage('assets/menu_assets/moon-outline.png'),
                        "RESOURCES"),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    menuCard(
                        context,
                        const AssetImage(
                            'assets/menu_assets/calendar-outline.png'),
                        "ROUTINE"),
                    const SizedBox(width: 20),
                    menuCard(
                        context,
                        const AssetImage(
                            'assets/menu_assets/settings-outline.png'),
                        "SETTINGS"),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
