import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:scholarr_mobile_frontend/models/models.dart';

class ClassroomContentListScreen extends StatefulWidget {
  final ClassroomManager manager;

  const ClassroomContentListScreen({
    Key? key,
    required this.manager,
  }) : super(key: key);

  @override
  State<ClassroomContentListScreen> createState() =>
      _ClassroomContentListScreenState();
}

class _ClassroomContentListScreenState
    extends State<ClassroomContentListScreen> {
  Map ClasscontentTypes = {
    "classwork": "CLASSWORK",
    "resource": "RESOURCE",
    "submission": "SUBMISSION"
  };

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final classcontent_manager =
        Provider.of<ClasscontentManager>(context, listen: false);

    final classroomContentList = classcontent_manager.classroomContentList;
    final List classworkItems = classroomContentList["classworks"];
    final List resourceItems = classroomContentList["resources"];

    final username =
        Provider.of<AppStateManager>(context, listen: false).getUsername;
    final classroomTeacher = widget
        .manager.selectedClassroomDetail["classroom"]?.teacher["username"];

    bool isTeacher = username == classroomTeacher;

    return RefreshIndicator(
      onRefresh: () async {},
      child: ListView(children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(40, 30, 30, 0),
          child: Row(
            children: [
              Text("Classworks",
                  style: Theme.of(context).textTheme.headlineMedium),
              Spacer(),
              buildCreateButton(
                  context, isTeacher, ClasscontentTypes["classwork"]),
            ],
          ),
        ),
        SizedBox(
          height: 250,
          child: classworkItems.isEmpty
              ? Center(child: Text("No Classworks"))
              : buildListView(context, classworkItems, Icons.assignment_rounded,
                  ClasscontentTypes["classwork"]),
        ),
        SizedBox(height: 20),
        Spacer(),
        Padding(
          padding: const EdgeInsets.fromLTRB(40, 10, 30, 0),
          child: Row(
            children: [
              Text("Resources",
                  style: Theme.of(context).textTheme.headlineMedium),
              Spacer(),
              buildCreateButton(
                  context, isTeacher, ClasscontentTypes["resource"]),
            ],
          ),
        ),
        SizedBox(
          height: 250,
          child: classworkItems.isEmpty
              ? Center(child: Text("No Resources"))
              : buildListView(context, resourceItems,
                  Icons.sticky_note_2_rounded, ClasscontentTypes["resource"]),
        ),
      ]),
    );
  }

  Widget buildListView(
      BuildContext context, contentItems, IconData icon, String type) {
    contentItems = contentItems.reversed.toList();
    return Padding(
      padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
        itemCount: contentItems.length,
        itemBuilder: (context, index) {
          final item = contentItems[index];
          return Card(
            // color: Color.fromARGB(100, 255, 255, 255),
            elevation: 2.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: SizedBox(
              height: 70,
              width: 250,
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        flex: 1,
                        child: Icon(
                          icon,
                          size: 30,
                        ),
                      ),
                      const Spacer(
                        flex: 1,
                      ),
                      Expanded(
                        flex: 10,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            buildTitleRow(context, item.title),
                            buildDateRow(context, item.deadline),
                          ],
                        ),
                      ),
                      const Spacer(flex: 1),
                      Flexible(
                        flex: 1,
                        child: item.attachments
                            ? const Icon(Icons.attachment_rounded)
                            : Container(),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  debugPrint("classcontent tapped");
                  Provider.of<ClasscontentManager>(context, listen: false)
                      .classcontentItemTapped(item.id, type);
                },
              ),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(height: 5.0);
        },
      ),
    );
  }

  Widget buildTitleRow(BuildContext context, title) {
    return Expanded(
      child: Text(
        title,
        style: Theme.of(context).textTheme.bodyLarge,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.start,
      ),
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

  Widget buildDateRow(BuildContext context, String? deadline) {
    if (deadline == null) {
      return Text(
        "Deadline: No Due Date",
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.labelMedium,
      );
    }

    DateFormat formatter = DateFormat("H:m d MMM, y");
    DateTime deadline_date = DateTime.parse(deadline);
    return Text(
      "Deadline:\t" + formatter.format(deadline_date),
      overflow: TextOverflow.ellipsis,
      style: Theme.of(context).textTheme.labelMedium,
    );
  }

  Widget buildCreateButton(
      BuildContext context, bool isUserTeacher, String classcontentType) {
    if (isUserTeacher) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: MaterialButton(
          color: Colors.red[700],
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          onPressed: () async {
            Provider.of<ClasscontentManager>(context, listen: false)
                .createNewItem(widget.manager.selectedIndex, classcontentType);
          },
          child: SizedBox(
            height: 30,
            child: Text(
              "Create",
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ),
        ),
      );
    }
    return const SizedBox(
      height: 0,
    );
  }
}
