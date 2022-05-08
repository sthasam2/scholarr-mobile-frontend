import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:scholarr_mobile_frontend/models/models.dart';
import 'package:scholarr_mobile_frontend/ui/components/components.dart';
import 'package:scholarr_mobile_frontend/ui/screens/screens.dart';

class ClassroomScreen extends StatefulWidget {
  const ClassroomScreen({Key? key}) : super(key: key);

  static MaterialPage page() {
    return MaterialPage(
        name: AppPages.classroomPath,
        key: ValueKey(AppPages.classroomPath),
        child: const ClassroomScreen());
  }

  @override
  State<ClassroomScreen> createState() => _ClassroomScreenState();
}

class _ClassroomScreenState extends State<ClassroomScreen> {
  late Future<Map> _classroomList;

  @override
  void initState() {
    _classroomList = Provider.of<ClassroomManager>(context, listen: false)
        .getClassroomItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              padding: EdgeInsets.fromLTRB(0, 0, 70, 0),
              labelColor: Colors.white,
              labelStyle: Theme.of(context).textTheme.headlineSmall,
              indicatorSize: TabBarIndicatorSize.label,
              tabs: const [
                Tab(text: "Classrooms"),
                Tab(text: "Invites/Requests"),
              ],
            ),
            title: Text(
              'CLASSROOM',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            // automaticallyImplyLeading: false,
            leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back_rounded,
                  size: 30,
                ),
                onPressed: () {
                  Provider.of<AppStateManager>(context, listen: false)
                      .goToTab(AppTab.home);
                  Navigator.pop(context, true);
                }),
          ),
          floatingActionButton: buildMenuFloatingActionButton(
              context, const Icon(Icons.menu_rounded), true),
          floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.fromLTRB(40, 10, 40, 20),
            child: buildButton(context, "CREATE CLASSROOM"),
          ),
          body: TabBarView(
            children: [
              _tabPageClassroom(),
              _tabPageInvitesRequests(),
            ],
          )),
    );
  }

  Widget _tabPageClassroom() {
    return FutureBuilder(
      future: _classroomList,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasData) {
          return buildClassroomScreen(context);
        }

        if (snapshot.hasError) {
          return Center(
            child: SizedBox(
              width: 250,
              height: 75,
              child: errorInfoBox(context, "Oops!", "Something went wrong"),
            ),
          );
        }

        return SizedBox();
      },
    );
  }

  Widget _tabPageInvitesRequests() {
    return Container();
  }

  Widget buildButton(context, action) {
    return SizedBox(
      height: 55,
      child: MaterialButton(
        color: Colors.red[700],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Text(
          action,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        onPressed: () {
          Provider.of<ClassroomManager>(context, listen: false).createNewItem();
          // manager.setClassroomItems();
        },
      ),
    );
  }

  Widget buildClassroomScreen(context) {
    return Consumer<ClassroomManager>(
      builder: (context, manager, child) {
        if (manager.teachingClassroomItems.isNotEmpty ||
            manager.studyingClassroomItems.isNotEmpty) {
          return ClassroomListScreen(manager: manager);
        } else {
          return EmptyClassroomScreen(manager: manager);
        }
      },
    );
  }
}
