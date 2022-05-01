import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import 'package:scholarr_mobile_frontend/models/models.dart';
import 'package:scholarr_mobile_frontend/ui/screens/screens.dart';
import 'package:scholarr_mobile_frontend/ui/components/components.dart';

class ClassgroupDetailScreen extends StatefulWidget {
  final ClassgroupManager manager;

  const ClassgroupDetailScreen({Key? key, required this.manager})
      : super(key: key);

  static MaterialPage page(ClassgroupManager manager) {
    return MaterialPage(
      name: AppPages.classgroupItemDetailPath,
      key: ValueKey(AppPages.classgroupItemDetailPath),
      child: ClassgroupDetailScreen(manager: manager),
    );
  }

  @override
  State<ClassgroupDetailScreen> createState() => _ClassgroupDetailScreenState();
}

class _ClassgroupDetailScreenState extends State<ClassgroupDetailScreen> {
  late Future<Map> _classgroupDetail;

  @override
  void initState() {
    _classgroupDetail = widget.manager.getSelectedClassGroupItemDetail();
    debugPrint("initialization for detail done");
    // debugPrint(jsonEncode(_classgroupDetail));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final _kTabPages = <Widget>[];
    // final _kTabs = <Tab>[
    //   const Tab(text: "Info"),
    //   const Tab(text: "Members"),
    // ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Classgroup Detail',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        // automaticallyImplyLeading: false,
        leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_rounded,
              size: 30,
            ),
            onPressed: () {
              Provider.of<ClassgroupManager>(context, listen: false)
                  .resetClassgroupDetail();
              Navigator.pop(context, true);
            }),
      ),
      floatingActionButton: buildMenuFloatingActionButton(
          context, const Icon(Icons.menu_rounded), true),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      body: FutureBuilder(
        future: _classgroupDetail,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasData) {
            debugPrint("Hello");

            final classgroup = snapshot.data["classgroup"];
            final members = snapshot.data["members"];

            return ListView(
              padding: EdgeInsets.fromLTRB(40, 10, 10, 10),
              children: [
                buildClassgroupInformation(context, classgroup),
                const SizedBox(
                  height: 10,
                ),
                buildSubtitleRow(
                    context, Icons.calendar_today_rounded, classgroup.batch),
                buildSubtitleRow(
                    context, Icons.school_rounded, classgroup.faculty),
                buildSubtitleRow(
                    context, Icons.business_rounded, classgroup.organisation),
                buildSubtitleRow(
                    context, Icons.code_rounded, classgroup.classgroup_code),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Creator",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(
                  height: 5,
                ),
                buildSubtitleRow(context, Icons.account_circle_rounded,
                    classgroup.created_by["username"]),
                buildSubtitleRow(context, Icons.email_rounded,
                    classgroup.created_by["email"]),
                const SizedBox(
                  height: 10,
                ),
                buildDateRow(context, classgroup),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Text(
                      "Members",
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    Spacer(),
                    buildInviteButton(context, classgroup)
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                buildMemberList(members),
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
      ),
    );
  }

  Widget buildInviteButton(BuildContext context, classgroup) {
    final username =
        Provider.of<AppStateManager>(context, listen: false).getUsername;
    final selectedClassgroupCreatorUsername =
        classgroup?.created_by["username"];

    if (username == selectedClassgroupCreatorUsername) {
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

  Widget buildTitleRow(BuildContext context, title) {
    return Expanded(
      child: Text(
        title,
        style: Theme.of(context).textTheme.headlineMedium,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget buildClassgroupInformation(BuildContext context, classgroup) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          classgroup.name,
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
        Expanded(
          child: Text(
            text,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ),
      ],
    );
  }

  Widget buildDateRow(BuildContext context, classgroup) {
    DateFormat formatter = DateFormat("H:m d MMM, y");
    DateTime modified = DateTime.parse(classgroup.modified_date);
    DateTime created = DateTime.parse(classgroup.created_date);
    return Row(
      children: [
        Expanded(
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
    List memberList = members.members;
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
                      style: Theme.of(context).textTheme.bodySmall,
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
}
