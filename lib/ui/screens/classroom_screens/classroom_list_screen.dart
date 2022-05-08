import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'package:scholarr_mobile_frontend/models/models.dart';
import 'package:scholarr_mobile_frontend/ui/components/components.dart';

// import 'package:scholarr_mobile_frontend/ui/components/classroom_card.dart';

class ClassroomListScreen extends StatefulWidget {
  final ClassroomManager manager;

  const ClassroomListScreen({
    Key? key,
    required this.manager,
  }) : super(key: key);

  @override
  State<ClassroomListScreen> createState() => _ClassroomListScreenState();
}

class _ClassroomListScreenState extends State<ClassroomListScreen> {
  late List<ClassroomItem> createdClassroomItems;
  late List<ClassroomItem> studentClassroomItems;

  @override
  void initState() {
    widget.manager.setClassroomItems();

    createdClassroomItems = widget.manager.teachingClassroomItems;
    studentClassroomItems = widget.manager.studyingClassroomItems;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        widget.manager.setClassroomItems();
      },
      //   child: Container(),
      // );
      child: ListView(children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(40, 20, 0, 0),
          child: Text("STUDYING CLASSROOMS",
              style: Theme.of(context).textTheme.headlineMedium),
        ),
        SizedBox(
          height: 200,
          child: buildListView(context, studentClassroomItems),
        ),
        // SizedBox(height: 20),
        Spacer(),
        Padding(
          padding: const EdgeInsets.fromLTRB(40, 10, 0, 0),
          child: Text("TEACHING CLASSROOMS",
              style: Theme.of(context).textTheme.headlineMedium),
        ),
        SizedBox(
          height: 200,
          child: buildListView(context, createdClassroomItems),
        ),
      ]),
    );
  }

  Widget buildListView(BuildContext context, classroomItems) {
    classroomItems = classroomItems.reversed.toList();
    return ListView.separated(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.fromLTRB(35, 20, 20, 10),
      itemCount: classroomItems.length,
      itemBuilder: (context, index) {
        final item = classroomItems[index];
        return Card(
          elevation: 2.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: SizedBox(
            width: 250,
            child: InkWell(
              borderRadius: BorderRadius.circular(20),
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildTitleRow(context, item),
                    buildCaptionRow(context, item.subject),
                    Spacer(),
                    buildSubtitleRow(
                        context, Icons.person, item.teacher["username"]),
                    // buildDateRow(context, item.created_date)
                    // buildSubtitleRow(
                    //     context, Icons.business_rounded, item.organisation),
                  ],
                ),
              ),
              onTap: () {
                debugPrint("card tapped");
                widget.manager.classroomItemTapped(item.id);
              },
            ),
          ),
        );
      },
      separatorBuilder: (context, index) {
        return const SizedBox(height: 5.0);
      },
    );
  }

  Widget buildTitleRow(BuildContext context, item) {
    return Text(
      item.name,
      style: Theme.of(context).textTheme.headlineMedium,
      overflow: TextOverflow.visible,
      textAlign: TextAlign.start,
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

  Widget buildDateRow(BuildContext context, String created_date) {
    DateFormat formatter = DateFormat("H:m d MMM, y");
    DateTime created = DateTime.parse(created_date);
    return Row(
      children: [
        Flexible(
          child: Text(
            "Created:\t" + formatter.format(created),
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ),
      ],
    );
  }
}
