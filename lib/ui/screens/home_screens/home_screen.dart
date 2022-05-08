import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:scholarr_mobile_frontend/models/models.dart';
import 'package:scholarr_mobile_frontend/ui/components/components.dart';
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
  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'GOOD MORNING';
    } else if (hour < 17) {
      return 'GOOD AFTERNOON';
    } else {
      return 'GOOD EVENING';
    }
  }

  @override
  void initState() {
    Provider.of<AppStateManager>(context, listen: false)
        .initializeSharedPreferences();

    final classroom_manager =
        Provider.of<ClassroomManager>(context, listen: false);

    final classroomItems = classroom_manager.getClassroomItems();

    // createdClassroomItems = widget.manager.teachingClassroomItems;
    // studentClassroomItems = widget.manager.studyingClassroomItems;
    super.initState();
  }

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
          onRefresh: () async {
            setState(() {});
          },
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
