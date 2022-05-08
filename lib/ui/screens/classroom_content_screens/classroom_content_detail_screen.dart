import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:scholarr_mobile_frontend/models/models.dart';
import 'package:scholarr_mobile_frontend/ui/components/components.dart';
import 'package:scholarr_mobile_frontend/ui/screens/screens.dart';

class ClassroomContentDetailScreen extends StatefulWidget {
  final ClasscontentManager classcontentManager;

  const ClassroomContentDetailScreen(
      {Key? key, required this.classcontentManager})
      : super(key: key);

  static MaterialPage page({
    required ClasscontentManager classcontentManager,
  }) {
    return MaterialPage(
      name: AppPages.classroomContentItemDetailPath,
      key: ValueKey(AppPages.classroomContentItemDetailPath),
      child: ClassroomContentDetailScreen(
        classcontentManager: classcontentManager,
      ),
    );
  }

  @override
  State<ClassroomContentDetailScreen> createState() =>
      _ClassroomContentDetailScreenState();
}

class _ClassroomContentDetailScreenState
    extends State<ClassroomContentDetailScreen> {
  late Future<Map> _classroomContentDetail;
  late Future<Map> _submissionList;
  late bool? isTeacher;

  @override
  void initState() {
    _classroomContentDetail =
        widget.classcontentManager.getSelectedClasscontentItemDetail();

    _submissionList = Provider.of<ClasscontentManager>(context, listen: false)
        .getSubmissionList(widget.classcontentManager.selectedClassworkIndex);

    final id = Provider.of<AppStateManager>(context, listen: false).getId;
    final classroomContentTeacher =
        widget.classcontentManager.selectedClasscontentCreatorIndex;
    isTeacher = id == classroomContentTeacher;

    super.initState();
    debugPrint("initialization for detail done");
  }

  @override
  Widget build(BuildContext context) {
    if (!isTeacher!) {
      final id = Provider.of<AppStateManager>(context, listen: false).getId;
      final classroomContentTeacher =
          widget.classcontentManager.selectedClasscontentCreatorIndex;
      isTeacher = id == classroomContentTeacher;
    }

    setState(() {});

    final _kTabs = <Tab>[
      const Tab(text: "Info"),
      const Tab(text: "Submission"),
    ];

    final _kTabPages = <Widget>[
      _tabPageInfo(),
      _tabPageSubmission(),
    ];

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'ClassroomContent Detail',
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
                widget.classcontentManager.resetClasscontentDetail();
                Navigator.pop(context, true);
              }),
        ),
        floatingActionButton: buildMenuFloatingActionButton(
            context, const Icon(Icons.menu_rounded), true),
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.fromLTRB(40, 10, 40, 20),
          child: buildSubmissionButton(context),
        ),
        body: TabBarView(children: _kTabPages),
      ),
    );
  }

  Widget _tabPageInfo() {
    return FutureBuilder(
      future: _classroomContentDetail,
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
          final contentType = widget
              .classcontentManager.getDetailClasscontentType!
              .toUpperCase();

          debugPrint(contentType);

          // return Container();

          final classroomContent = contentType == "CLASSWORK"
              ? snapshot.data["classwork"]
              : snapshot.data["resource"];

          final attachments = snapshot.data["attachments"];

          return ListView(
            padding: const EdgeInsets.fromLTRB(40, 30, 10, 10),
            children: [
              buildClassroomContentTitle(context, classroomContent.title),
              const SizedBox(height: 20),
              Text(
                classroomContent.description,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 20),
              contentType == "CLASSWORK"
                  ? buildSubtitleRow(context, Icons.onetwothree_rounded,
                      classroomContent.weightage.toString())
                  : Container(),
              const SizedBox(height: 20),
              buildDateRow(context, classroomContent),
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

  Widget _tabPageSubmission() {
    return Consumer<ClasscontentManager>(
      builder: (context, manager, child) {
        return SubmissionListScreen(manager: manager);
      },
    );
    //
    return Container();
  }

  Widget buildInviteButton(BuildContext context) {
    if (isTeacher!) {
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
    final ded_date = classroomContent.deadline;

    DateTime modified = DateTime.parse(mod_date);
    DateTime created = DateTime.parse(cre_date);
    DateTime deadline =
        ded_date == null ? DateTime.now() : DateTime.parse(ded_date!);

    final form_mod = formatter.format(modified);
    final form_cre = formatter.format(created);
    final form_ded =
        ded_date != null ? formatter.format(deadline) : "No due Date";

    return Row(
      children: [
        Flexible(
          child: Text(
            "Due Deadline:\t" +
                form_ded +
                "\nCreated:\t" +
                form_cre +
                "\nModified:\t" +
                form_mod,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ),
      ],
    );
  }

  Widget buildSubmissionButton(context) {
    return SizedBox(
      height: 55,
      child: MaterialButton(
        color: Colors.red[700],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Text(
          "CREATE SUBMISSION",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        onPressed: () {
          // TODO
          debugPrint("hello there");
          widget.classcontentManager.createNewSubmissionItem(
              widget.classcontentManager.selectedClassworkIndex, "SUBMISSION");
        },
      ),
    );
  }
}
