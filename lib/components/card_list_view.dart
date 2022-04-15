import 'package:flutter/material.dart';

import 'components.dart';

Widget buildLimitedScheduleListView(context, schedules) {
  return ListView(
    children: schedules.map((schedule) => buildScheduleCard(
        context,
        schedule.title,
        schedule.icon,
        schedule.day,
        schedule.person,
        schedule.startTime,
        schedule.endTime,
        schedule.link)),
  );
}

Widget buildScheduleListView(context, schedules) {
  return ListView(
    children: <Widget>[
      for (var schedule in schedules)
        buildScheduleCard(
          context,
          schedule["title"],
          schedule["icon"],
          schedule["day"],
          schedule["person"],
          schedule["startTime"],
          schedule["endTime"],
          schedule["link"],
        ),
    ],
  );
}
