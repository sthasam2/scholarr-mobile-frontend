import 'package:flutter/material.dart';

import 'package:scholarr_mobile_frontend/models/models.dart';

class ClassgroupListScreen extends StatefulWidget {
  final ClassgroupManager manager;

  const ClassgroupListScreen({
    Key? key,
    required this.manager,
  }) : super(key: key);

  @override
  State<ClassgroupListScreen> createState() => _ClassgroupListScreenState();
}

class _ClassgroupListScreenState extends State<ClassgroupListScreen> {
  late List<ClassGroupItem> createdClassgroupItems;
  late List<ClassGroupItem> studentClassgroupItems;

  @override
  void initState() {
    createdClassgroupItems = widget.manager.createdClassgroupItems;
    studentClassgroupItems = widget.manager.studentClassgroupItems;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        widget.manager.setClassgroupItems();
        setState(() {
          createdClassgroupItems = widget.manager.createdClassgroupItems;
          studentClassgroupItems = widget.manager.studentClassgroupItems;
        });
      },
      child: ListView(children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(40, 30, 0, 0),
          child: Text("ENROLLED CLASSGROUPS",
              style: Theme.of(context).textTheme.headlineMedium),
        ),
        studentClassgroupItems.isEmpty
            ? SizedBox(
                height: 260,
                child: Center(
                    child: Text(
                  "Join a class",
                  style: Theme.of(context).textTheme.headlineMedium,
                )),
              )
            : SizedBox(
                height: 260,
                child: buildListView(context, studentClassgroupItems),
              ),
        // SizedBox(height: 20),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.fromLTRB(40, 10, 0, 0),
          child: Text("CREATED CLASSGROUPS",
              style: Theme.of(context).textTheme.headlineMedium),
        ),
        createdClassgroupItems.isEmpty
            ? SizedBox(
                height: 260,
                child: Center(
                    child: Text(
                  "Create a class",
                  style: Theme.of(context).textTheme.headlineMedium,
                )),
              )
            : SizedBox(
                height: 260,
                child: buildListView(context, createdClassgroupItems),
              ),
      ]),
    );
  }

  Widget buildListView(
      BuildContext context, List<ClassGroupItem> classgroupItems) {
    classgroupItems = classgroupItems.reversed.toList();
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.fromLTRB(35, 20, 20, 10),
      itemCount: classgroupItems.length,
      itemBuilder: (context, index) {
        final item = classgroupItems[index];
        return Card(
          elevation: 2.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: SizedBox(
            height: 120,
            width: 200,
            child: InkWell(
              borderRadius: BorderRadius.circular(20),
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildTitleRow(context, item),
                    buildSubtitleRow(
                        context, Icons.calendar_today_rounded, item.batch),
                    buildSubtitleRow(
                        context, Icons.school_rounded, item.faculty),
                    buildSubtitleRow(
                        context, Icons.business_rounded, item.organisation),
                  ],
                ),
              ),
              onTap: () {
                debugPrint("card tapped");
                widget.manager.classgroupItemTapped(item.id);
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
      textAlign: TextAlign.center,
    );
  }

  Widget buildSubtitleRow(BuildContext context, IconData icon, String text) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
        ),
        const SizedBox(width: 5),
        Flexible(
          child: Text(
            text,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ),
      ],
    );
  }
}
