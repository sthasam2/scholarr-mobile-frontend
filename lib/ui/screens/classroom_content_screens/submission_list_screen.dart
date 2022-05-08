import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:scholarr_mobile_frontend/models/models.dart';

class SubmissionListScreen extends StatefulWidget {
  final ClasscontentManager manager;

  const SubmissionListScreen({
    Key? key,
    required this.manager,
  }) : super(key: key);

  @override
  State<SubmissionListScreen> createState() => _SubmissionListScreenState();
}

class _SubmissionListScreenState extends State<SubmissionListScreen> {
  Map ClasscontentTypes = {
    "classwork": "CLASSWORK",
    "resource": "RESOURCE",
    "submission": "SUBMISSION"
  };

  late bool isTeacher;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final classcontent_manager =
        Provider.of<ClasscontentManager>(context, listen: false);

    final submissionList = classcontent_manager.submissionList;
    final List selfSubmission = submissionList["self"];
    final List allSubmission = submissionList["all"];

    final id = Provider.of<AppStateManager>(context, listen: false).getId;
    final classroomContentTeacher =
        widget.manager.selectedClasscontentCreatorIndex;
    isTeacher = id == classroomContentTeacher;

    return RefreshIndicator(
      onRefresh: () async {
        setState(() {});
      },
      child: ListView(children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(40, 30, 30, 0),
          child: Row(
            children: [
              Text("Self Submissions",
                  style: Theme.of(context).textTheme.headlineMedium),
            ],
          ),
        ),
        Flexible(
          child: selfSubmission.isEmpty
              ? Center(child: Text("Nothing Submitted"))
              : buildListView(context, selfSubmission, Icons.assignment_rounded,
                  ClasscontentTypes["submission"]),
        ),
        SizedBox(height: 20),
        Spacer(),
        Flexible(
          child: isTeacher
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(40, 10, 30, 0),
                      child: Row(
                        children: [
                          Text("All Submissions",
                              style:
                                  Theme.of(context).textTheme.headlineMedium),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 250,
                      child: allSubmission.isEmpty
                          ? Center(child: Text("No Submisison"))
                          : buildListView(
                              context,
                              allSubmission,
                              Icons.sticky_note_2_rounded,
                              ClasscontentTypes["resource"]),
                    ),
                  ],
                )
              : Container(),
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
                            buildTitleRow(context, item.created_by["username"]),
                            buildDateRow(context, item.created_date),
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
                  debugPrint("submission tapped");
                  Provider.of<ClasscontentManager>(context, listen: false)
                      .classworkSubmissionItemTapped(item.id, type);
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

  Widget buildDateRow(BuildContext context, String? submitted_date) {
    if (submitted_date == null) {
      return Text(
        "Submission: No Due Date",
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.labelMedium,
      );
    }

    DateFormat formatter = DateFormat("H:m d MMM, y");
    DateTime submitted = DateTime.parse(submitted_date);
    return Text(
      "Submitted:\t" + formatter.format(submitted),
      overflow: TextOverflow.ellipsis,
      style: Theme.of(context).textTheme.labelMedium,
    );
  }

  // // Widget buildCreateButton(
  // //     BuildContext context, bool isUserTeacher, String classcontentType) {
  // //   if (isUserTeacher) {
  // //     return Padding(
  // //       padding: const EdgeInsets.all(8.0),
  // //       child: MaterialButton(
  // //         color: Colors.red[700],
  // //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
  // //         onPressed: () async {
  // //           Provider.of<ClasscontentManager>(context, listen: false)
  // //               .createNewItem(widget.manager.selectedIndex, classcontentType);
  // //         },
  // //         child: SizedBox(
  // //           height: 30,
  // //           child: Text(
  // //             "Create",
  // //             style: Theme.of(context).textTheme.labelLarge,
  // //           ),
  // //         ),
  // //       ),
  // //     );
  // //   }
  // //   return const SizedBox(
  // //     height: 0,
  // //   );
  // }
}
