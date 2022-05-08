import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:scholarr_mobile_frontend/models/models.dart';
import 'package:scholarr_mobile_frontend/ui/components/components.dart';
import 'package:scholarr_mobile_frontend/ui/screens/screens.dart';

class SubmissionDetailScreen extends StatefulWidget {
  final ClasscontentManager classcontentManager;

  const SubmissionDetailScreen({Key? key, required this.classcontentManager})
      : super(key: key);

  static MaterialPage page({
    required ClasscontentManager classcontentManager,
  }) {
    return MaterialPage(
      name: AppPages.submissionItemDetailPath,
      key: ValueKey(AppPages.submissionItemDetailPath),
      child: SubmissionDetailScreen(
        classcontentManager: classcontentManager,
      ),
    );
  }

  @override
  State<SubmissionDetailScreen> createState() => _SubmissionDetailScreenState();
}

class _SubmissionDetailScreenState extends State<SubmissionDetailScreen> {
  late Future<Map> _submissionDetail;
  late Future<Map> _plagiarismList;
  // late bool? isTeacher;

  @override
  void initState() {
    _submissionDetail =
        widget.classcontentManager.getSelectedSubmissionDetail();

    // _plagiarismList = Provider.of<ClasscontentManager>(context, listen: false)
    //     .getSubmissionList(widget.classcontentManager.selectedClassworkIndex);

    // final id = Provider.of<AppStateManager>(context, listen: false).getId;
    // final classroomContentTeacher =
    //     widget.classcontentManager.selectedClasscontentCreatorIndex;
    // isTeacher = id == classroomContentTeacher;

    super.initState();
    debugPrint("initialization for detail done");
  }

  @override
  Widget build(BuildContext context) {
    // if (!isTeacher!) {
    //   final id = Provider.of<AppStateManager>(context, listen: false).getId;
    //   final classroomContentTeacher =
    //       widget.classcontentManager.selectedClasscontentCreatorIndex;
    //   isTeacher = id == classroomContentTeacher;
    // }

    setState(() {});

    final _kTabs = <Tab>[
      const Tab(text: "Info"),
      const Tab(text: "Plagiarism"),
    ];

    final _kTabPages = <Widget>[
      _tabPageInfo(),
      _tabPagePlagiarism(),
    ];

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Submission Detail',
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
                widget.classcontentManager.resetClassworkSubmissionDetail();
                Navigator.pop(context, true);
              }),
        ),
        floatingActionButton: buildMenuFloatingActionButton(
            context, const Icon(Icons.menu_rounded), true),
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
        body: TabBarView(children: _kTabPages),
      ),
    );
  }

  Widget _tabPageInfo() {
    return FutureBuilder(
      future: _submissionDetail,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        //
        // LOADING
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: Container(
              child: CircularProgressIndicator(),
            ),
          );
        }

        //
        // LOADING COMPLETE
        if (snapshot.hasData) {
          // // return Container();

          final submission = snapshot.data["submission"];
          final attachments = snapshot.data["attachments"];
          final plagiarism_list = snapshot.data["plagiarism_list"];

          return ListView(
            padding: const EdgeInsets.fromLTRB(40, 30, 40, 10),
            children: [
              buildClassroomContentTitle(
                  context, submission.created_by["username"]),
              const SizedBox(height: 20),
              Text(
                submission.answer,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 20),
              buildSubtitleRow(
                  context, Icons.grading, submission.grade.toString()),
              const SizedBox(height: 20),
              buildDateRow(context, submission),
              const SizedBox(height: 40),
              buildTitleRow(context, "Remarks"),
              buildSubtitleRow(context, null, submission.remarks),
              const SizedBox(height: 40),
              buildTitleRow(context, "Attachments"),
              buildAttachmentListView(
                  context, attachments, Icons.picture_as_pdf_rounded)
            ],
          );
        }

        // LOADING FAILED
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

  Widget _tabPagePlagiarism() {
    return FutureBuilder(
      future: _submissionDetail,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        //
        // LOADING
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: Container(
              child: CircularProgressIndicator(),
            ),
          );
        }

        //
        // LOADING COMPLETE
        if (snapshot.hasData) {
          // // return Container();

          final plagiarism_list = snapshot.data["plagiarism_list"];

          return ListView(
            padding: const EdgeInsets.fromLTRB(40, 30, 40, 10),
            children: [
              buildClassroomContentTitle(context, "Plagiarism Information"),
              buildPlagiarismListView(
                  context, plagiarism_list, Icons.content_cut_rounded)
            ],
          );
        }

        // LOADING FAILED
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

  Widget buildTitleRow(BuildContext context, username) {
    return Text(
      username,
      style: Theme.of(context).textTheme.headlineMedium,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.left,
    );
  }

  Widget buildClassroomContentTitle(BuildContext context, title) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ],
    );
  }

  Widget buildSubtitleRow(BuildContext context, IconData? icon, String text) {
    return Row(
      children: [
        icon == null
            ? Container()
            : Icon(
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

  Widget buildDateRow(BuildContext context, classroomContent) {
    DateFormat formatter = DateFormat("H:m d MMM, y");
    final mod_date = classroomContent.modified_date;
    final cre_date = classroomContent.created_date;

    DateTime modified = DateTime.parse(mod_date);
    DateTime created = DateTime.parse(cre_date);

    final form_mod = formatter.format(modified);
    final form_cre = formatter.format(created);

    return Row(
      children: [
        Flexible(
          child: Text(
            "Created:\t" + form_cre + "\nModified:\t" + form_mod,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ),
      ],
    );
  }

  Widget buildAttachmentListView(
      BuildContext context, contentItems, IconData icon) {
    contentItems = contentItems.reversed.toList();

    return ListView.separated(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
      itemCount: contentItems.length,
      itemBuilder: (context, index) {
        final item = contentItems[index];

        final name = item.attachment.split("/")[3];
        return Card(
          // color: Color.fromARGB(100, 255, 255, 255),
          elevation: 2.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: SizedBox(
            height: 90,
            width: 320,
            child: InkWell(
              borderRadius: BorderRadius.circular(20),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
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
                          Text(
                            name,
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          Text(
                            item.mime_type,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              onTap: () {
                debugPrint("ASSIGNMENT tapped");
                // Provider.of<ClasscontentManager>(context, listen: false)
                //     .classworkSubmissionItemTapped(item.id, type);
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

  Widget buildPlagiarismListView(
      BuildContext context, contentItems, IconData icon) {
    return ListView.separated(
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
            height: 90,
            width: 320,
            child: InkWell(
              borderRadius: BorderRadius.circular(20),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
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
                          Text(
                            item.percentage_plagiarized.toStringAsFixed(3) +
                                "% Similar",
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          Text(
                            "with submission by " +
                                item.submission_target["_created_by"]
                                    ["username"],
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              onTap: () {
                debugPrint("ASSIGNMENT tapped");
                // Provider.of<ClasscontentManager>(context, listen: false)
                //     .classworkSubmissionItemTapped(item.id, type);
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
}
