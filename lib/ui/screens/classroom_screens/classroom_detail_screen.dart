import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:scholarr_mobile_frontend/models/models.dart';
import 'package:scholarr_mobile_frontend/ui/components/components.dart';
import 'package:scholarr_mobile_frontend/ui/screens/screens.dart';

class ClassroomDetailScreen extends StatefulWidget {
  final ClassroomManager manager;

  const ClassroomDetailScreen({Key? key, required this.manager})
      : super(key: key);

  static MaterialPage page(ClassroomManager manager) {
    return MaterialPage(
      name: AppPages.classroomItemDetailPath,
      key: ValueKey(AppPages.classroomItemDetailPath),
      child: ClassroomDetailScreen(manager: manager),
    );
  }

  @override
  State<ClassroomDetailScreen> createState() => _ClassroomDetailScreenState();
}

class _ClassroomDetailScreenState extends State<ClassroomDetailScreen> {
  late Future<Map> _classroomDetail;

  @override
  void initState() {
    _classroomDetail = widget.manager.getSelectedClassroomItemDetail();

    if (widget.manager.selectedIndex == -1) {
      widget.manager.setSelectedClassroomItemDetail();
    }
    Provider.of<ClasscontentManager>(context, listen: false)
        .setClassroomContentList(widget.manager.selectedIndex);

    final username =
        Provider.of<AppStateManager>(context, listen: false).getUsername;
    final classroomTeacher = widget
        .manager.selectedClassroomDetail["classroom"]?.teacher["username"];
    bool isTeacher = username == classroomTeacher;

    super.initState();
    debugPrint("initialization for detail done");
  }

  @override
  Widget build(BuildContext context) {
    final username =
        Provider.of<AppStateManager>(context, listen: false).getUsername;
    final classroomTeacher = widget
        .manager.selectedClassroomDetail["classroom"]?.teacher["username"];
    bool isTeacher = username == classroomTeacher;
    setState(() {});

    final _kTabs = <Tab>[
      const Tab(text: "Info"),
      const Tab(text: "Content"),
      const Tab(text: "Members"),
    ];

    final _kTabPages = <Widget>[
      _tabPageInfo(),
      _tabPageContent(),
      _tabPageMembers(),
    ];

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Classroom Detail',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          bottom: TabBar(
            padding: const EdgeInsets.fromLTRB(0, 0, 70, 0),
            labelColor: Colors.white,
            labelStyle: Theme.of(context).textTheme.headlineSmall,
            indicatorSize: TabBarIndicatorSize.label,
            tabs: _kTabs,
          ),
          leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_rounded,
                size: 30,
              ),
              onPressed: () {
                Provider.of<ClassroomManager>(context, listen: false)
                    .resetClassroomDetail();
                Navigator.pop(context, true);
              }),
        ),
        floatingActionButton: buildMenuFloatingActionButton(
            context, const Icon(Icons.menu_rounded), true),
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.fromLTRB(40, 10, 40, 20),
          child: buildButton(context, "CREATE CONTENT", isTeacher),
        ),
        body: TabBarView(children: _kTabPages),
      ),
    );
  }

  Widget _tabPageInfo() {
    return FutureBuilder(
      future: _classroomDetail,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: Container(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (snapshot.hasData) {
          debugPrint("Hello");

          final classroom = snapshot.data["classroom"];
          final members = snapshot.data["members"];

          return ListView(
            padding: const EdgeInsets.fromLTRB(40, 30, 10, 10),
            children: [
              buildClassroomInformation(context, classroom),
              const SizedBox(
                height: 10,
              ),
              buildSubtitleRow(
                  context, Icons.menu_book_rounded, classroom.subject),
              buildSubtitleRow(
                  context, Icons.code_rounded, classroom.classroom_code),
              const SizedBox(
                height: 20,
              ),
              buildDateRow(context, classroom),
              const SizedBox(
                height: 30,
              ),
              Text(
                "Schedule",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ],
          );
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

  Widget _tabPageContent() {
    return Consumer<ClassroomManager>(
      builder: (context, manager, child) {
        return ClassroomContentListScreen(manager: manager);
      },
    );
    // return Container();
  }

  Widget _tabPageMembers() {
    return FutureBuilder(
      future: _classroomDetail,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: Container(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (snapshot.hasData) {
          debugPrint("Hello");

          final classroom = snapshot.data["classroom"];
          final members = snapshot.data["members"];

          return ListView(
            padding: const EdgeInsets.fromLTRB(40, 30, 40, 10),
            children: [
              Text(
                "Teacher",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(
                height: 10,
              ),
              buildMemberList(members.teacher),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Text(
                    "Members",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  Spacer(),
                  buildInviteButton(context, classroom)
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              buildMemberList(members.student),
            ],
          );
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

  Widget buildInviteButton(BuildContext context, classroom) {
    final username =
        Provider.of<AppStateManager>(context, listen: false).getUsername;
    final selectedClassroomCreatorUsername = classroom?.teacher["username"];

    if (username == selectedClassroomCreatorUsername) {
      return SizedBox(
        height: 30,
        child: MaterialButton(
          color: Colors.red[700],
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          child: Text(
            "Invite",
            style: Theme.of(context).textTheme.labelLarge,
          ),
          onPressed: () async {},
        ),
      );
    }

    return const SizedBox(
      height: 10,
    );
  }

  Widget buildCaptionRow(BuildContext context, String text) {
    return Row(
      children: [
        Flexible(
          child: Text(
            text,
            overflow: TextOverflow.visible,
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ),
      ],
    );
  }

  Widget buildTitleRow(BuildContext context, title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.headlineMedium,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.center,
    );
  }

  Widget buildClassroomInformation(BuildContext context, classroom) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          classroom.name,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ],
    );
  }

  Widget buildSubtitleRow(BuildContext context, IconData icon, String text) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
        ),
        const SizedBox(width: 5),
        Flexible(
          child: Text(
            text,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ),
      ],
    );
  }

  Widget buildDateRow(BuildContext context, classroom) {
    DateFormat formatter = DateFormat("H:m d MMM, y");
    DateTime modified = DateTime.parse(classroom.modified_date);
    DateTime created = DateTime.parse(classroom.created_date);
    return Row(
      children: [
        Flexible(
          child: Text(
            "Created:\t" +
                formatter.format(created) +
                "\nModified:\t" +
                formatter.format(modified),
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ),
      ],
    );
  }

  Widget buildMemberList(members) {
    List memberList = members;
    if (memberList.isEmpty) return Container();

    return ListView.separated(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: memberList.length,
      itemBuilder: (context, index) {
        final member = memberList[index];
        return Row(
          children: [
            const Icon(
              Icons.account_circle_rounded,
              size: 30,
            ),
            const SizedBox(width: 10),
            RichText(
              text: TextSpan(
                  text: member["username"],
                  style: Theme.of(context).textTheme.headlineSmall,
                  children: [
                    TextSpan(
                      text: "\n" + member['email'],
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ]),
            ),
          ],
        );
      },
      separatorBuilder: (context, index) {
        return const SizedBox(height: 5.0);
      },
    );
  }

  Widget buildButton(context, action, isUserTeacher) {
    if (isUserTeacher) {
      return SizedBox(
        height: 55,
        child: MaterialButton(
          color: Colors.red[700],
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Text(
            action,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          onPressed: () {
            // TODO
            // final manager =
            //     Provider.of<ClassgroupManager>(context, listen: false);
            // manager.createNewItem();
            // manager.setClassgroupItems();
          },
        ),
      );
    } else {
      return const SizedBox(
        height: 0,
      );
    }
  }
}
