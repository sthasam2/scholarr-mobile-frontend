import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

// class ScheduleCard extends StatefulWidget {
//   final Schedule schedule;

//   const ScheduleCard({
//     Key? key,
//     required this.schedule,
//     // required this.classroom,
//   }) : super(key: key);

//   @override
//   State<ScheduleCard> createState() => _ScheduleCardState();
// }

// class _ScheduleCardState extends State<ScheduleCard> {
//   @override
//   Widget build(BuildContext context) {
//     final Widget linkButton;
//     Color color = Theme.of(context).primaryColor;

//     if (widget.schedule.link != null) {
//       linkButton = MaterialButton(
//           height: 40,
//           minWidth: 40,
//           color: color,
//           elevation: 0,
//           shape:
//               RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//           child: const Icon(
//             Icons.video_call_outlined,
//             size: 30,
//           ),
//           onPressed: () {
//             debugPrint('card button tapped');
//           });
//     } else {
//       linkButton = const Spacer();
//     }

//     String contextualDay() {
//       var now = DateTime.now();
//       var start = DateFormat("HH:mm").parse(widget.schedule.time_start);
//       var end = DateFormat("HH:mm").parse(widget.schedule.time_end);
//       if ((start.hour <= now.hour) && (end.hour <= now.hour)) {
//         color = Color.fromRGBO(23, 198, 224, 0.1);
//         return "NOW";
//       } else {
//         switch (widget.schedule.day) {
//           case 1:
//             return "MON";
//           case 2:
//             return "TUE";
//           case 3:
//             return "WED";
//           case 4:
//             return "THU";
//           case 5:
//             return "FRI";
//           case 6:
//             return "SAT";
//           default:
//             return "SUN";
//         }
//       }
//     }

//     return Container(child: Card(
//     elevation: 2.0,
//     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.circular(15),
//     ),
//     child: SizedBox(
//       height: 125,
//       width: 344,
//       child: InkWell(
//         borderRadius: BorderRadius.circular(20),
//         onTap: () {
//           debugPrint("card tapped");
//         },
//         child: Padding(
//           padding: const EdgeInsets.fromLTRB(25.0, 20, 25, 20),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(children: [
//                 const Icon(Icons.calendar_today_rounded),
//                 const SizedBox(width: 10),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       title,
//                       style: Theme.of(context).textTheme.headline2,
//                     ),
//                     Text(startTime + " • " + endTime,
//                         style: Theme.of(context).textTheme.bodyText2),
//                   ],
//                 ),
//                 const Spacer(flex: 2),
//                 linkButton,
//               ]),
//               const SizedBox(height: 10),
//               Row(
//                 children: [
//                   const Icon(Icons.person, size: 12),
//                   Text(
//                     person,
//                     style: Theme.of(context).textTheme.bodyText2,
//                   ),
//                   const Spacer(),
//                   Text(
//                     contextualDay(),
//                     style: Theme.of(context).textTheme.bodyText2,
//                   ),
//                   const SizedBox(width: 10),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     ),
//   );,);
//   }
// }

Widget buildScheduleCard(
    context, title, icon, day, person, startTime, endTime, link) {
  final Widget linkButton;
  Color color = Theme.of(context).primaryColor;

  String contextualDay() {
    var now = DateTime.now();
    var start = DateFormat("HH:mm").parse(startTime);
    var end = DateFormat("HH:mm").parse(endTime);
    if ((start.hour <= now.hour) && (end.hour <= now.hour)) {
      color = Color.fromRGBO(23, 198, 224, 0.1);
      return "NOW";
    } else {
      switch (day) {
        case 1:
          return "MON";
        case 2:
          return "TUE";
        case 3:
          return "WED";
        case 4:
          return "THU";
        case 5:
          return "FRI";
        case 6:
          return "SAT";
        default:
          return "SUN";
      }
    }
  }

  if (link != null) {
    linkButton = MaterialButton(
        height: 40,
        minWidth: 40,
        color: color,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: const Icon(
          Icons.video_call_outlined,
          size: 30,
        ),
        onPressed: () {
          debugPrint('card button tapped');
        });
  } else {
    linkButton = const Spacer();
  }
  return Card(
    elevation: 2.0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
    child: SizedBox(
      height: 125,
      width: 344,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () {
          debugPrint("card tapped");
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(25.0, 20, 25, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                icon,
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    Text(startTime + " • " + endTime,
                        style: Theme.of(context).textTheme.bodyText2),
                  ],
                ),
                const Spacer(flex: 2),
                linkButton,
              ]),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Icon(Icons.person, size: 12),
                  Text(
                    person,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  const Spacer(),
                  Text(
                    contextualDay(),
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  const SizedBox(width: 10),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
