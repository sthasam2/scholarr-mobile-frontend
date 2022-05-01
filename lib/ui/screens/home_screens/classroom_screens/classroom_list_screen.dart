// import 'package:flutter/material.dart';

// import 'package:scholarr_mobile_frontend/models/models.dart';
// import 'package:scholarr_mobile_frontend/ui/components/classgroup_card.dart';
// import 'package:scholarr_mobile_frontend/ui/components/components.dart';

// class ClassgroupListScreen extends StatefulWidget {
//   final ClassgroupManager manager;

//   const ClassgroupListScreen({
//     Key? key,
//     required this.manager,
//   }) : super(key: key);

//   @override
//   State<ClassgroupListScreen> createState() => _ClassgroupListScreenState();
// }

// class _ClassgroupListScreenState extends State<ClassgroupListScreen> {
//   late List<ClassGroupItem> createdClassgroupItems;
//   late List<ClassGroupItem> studentClassgroupItems;

//   @override
//   void initState() {
//     createdClassgroupItems = widget.manager.createdClassgroupItems;
//     studentClassgroupItems = widget.manager.studentClassgroupItems;
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return RefreshIndicator(
//       onRefresh: () async {
//         widget.manager.setClassgroupItems();
//       },
//       child: ListView(children: [
//         Padding(
//           padding: const EdgeInsets.fromLTRB(40, 10, 0, 0),
//           child: Text("ENROLLED CLASSGROUPS",
//               style: Theme.of(context).textTheme.headlineMedium),
//         ),
//         SizedBox(
//           height: 300,
//           child: buildListView(context, studentClassgroupItems),
//         ),
//         // SizedBox(height: 20),
//         Spacer(),
//         Padding(
//           padding: const EdgeInsets.fromLTRB(40, 10, 0, 0),
//           child: Text("CREATED CLASSGROUPS",
//               style: Theme.of(context).textTheme.headlineMedium),
//         ),
//         SizedBox(
//           height: 300,
//           child: buildListView(context, createdClassgroupItems),
//         ),
//       ]),
//     );
//   }

//   Widget buildListView(BuildContext context, classgroupItems) {
//     return ListView.separated(
//       scrollDirection: Axis.horizontal,
//       padding: const EdgeInsets.fromLTRB(35, 20, 20, 10),
//       itemCount: classgroupItems.length,
//       itemBuilder: (context, index) {
//         final item = classgroupItems[index];
//         return Card(
//           elevation: 2.0,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(15),
//           ),
//           child: SizedBox(
//             height: 120,
//             width: 200,
//             child: InkWell(
//               borderRadius: BorderRadius.circular(20),
//               child: Padding(
//                 padding: const EdgeInsets.fromLTRB(25.0, 15, 25, 15),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     buildTitleRow(context, item),
//                     buildSubtitleRow(
//                         context, Icons.calendar_today_rounded, item.batch),
//                     buildSubtitleRow(
//                         context, Icons.school_rounded, item.faculty),
//                     buildSubtitleRow(
//                         context, Icons.business_rounded, item.organisation),
//                   ],
//                 ),
//               ),
//               onTap: () {
//                 debugPrint("card tapped");
//                 widget.manager.classgroupItemTapped(item.id);
//               },
//             ),
//           ),
//         );
//       },
//       separatorBuilder: (context, index) {
//         return const SizedBox(height: 5.0);
//       },
//     );
//   }

//   Widget buildTitleRow(BuildContext context, item) {
//     return Expanded(
//       child: Text(
//         item.name,
//         style: Theme.of(context).textTheme.headlineMedium,
//         overflow: TextOverflow.ellipsis,
//         textAlign: TextAlign.center,
//       ),
//     );
//   }

//   Widget buildSubtitleRow(BuildContext context, IconData icon, String text) {
//     return Row(
//       children: [
//         Icon(
//           icon,
//           size: 16,
//         ),
//         const SizedBox(width: 5),
//         Expanded(
//           child: Text(
//             text,
//             overflow: TextOverflow.ellipsis,
//             style: Theme.of(context).textTheme.labelMedium,
//           ),
//         ),
//       ],
//     );
//   }
// }

// // class ClassgroupListScreen extends StatelessWidget {
// //   final ClassgroupManager manager;

// //   const ClassgroupListScreen({
// //     Key? key,
// //     required this.manager,
// //   }) : super(key: key);

// //   @override
// //   Widget build(BuildContext context) {
// //     final createdClassgroupItems = manager.createdClassgroupItems;
// //     final studentClassgroupItems = manager.studentClassgroupItems;

// //     return RefreshIndicator(
// //       onRefresh: () async {
// //         manager.setClassgroupItems();
// //       },
// //       child: buildListView(context, createdClassgroupItems),
// //       // child: Column(
// //       //   mainAxisAlignment: MainAxisAlignment.center,
// //       //   mainAxisSize: MainAxisSize.max,
// //       //   children: [
// //       //     Text("CREATED"),
// //       //     buildListView(context, createdClassgroupItems),
// //       //     SizedBox(height: 20),
// //       //     Text("ENROLLED"),
// //       //     buildListView(context, studentClassgroupItems),
// //       //   ],
// //       // ),
// //     );
// //   }

// //   Widget buildListView(BuildContext context, classgroupItems) {
// //     return ListView.separated(
// //       padding: const EdgeInsets.fromLTRB(35, 40, 35, 10),
// //       itemCount: classgroupItems.length,
// //       itemBuilder: (context, index) {
// //         final item = classgroupItems[index];
// //         return Card(
// //           elevation: 2.0,
// //           shape: RoundedRectangleBorder(
// //             borderRadius: BorderRadius.circular(15),
// //           ),
// //           child: SizedBox(
// //             height: 120,
// //             child: InkWell(
// //               borderRadius: BorderRadius.circular(20),
// //               child: Padding(
// //                 padding: const EdgeInsets.fromLTRB(25.0, 15, 25, 15),
// //                 child: Column(
// //                   mainAxisAlignment: MainAxisAlignment.center,
// //                   crossAxisAlignment: CrossAxisAlignment.start,
// //                   children: [
// //                     Text(
// //                       item.name,
// //                       style: Theme.of(context).textTheme.headlineMedium,
// //                       textAlign: TextAlign.center,
// //                     ),
// //                     const Spacer(),
// //                     Row(
// //                       children: [
// //                         const Icon(
// //                           Icons.calendar_today_rounded,
// //                           size: 16,
// //                         ),
// //                         const SizedBox(width: 5),
// //                         Text(
// //                           item.batch,
// //                           style: Theme.of(context).textTheme.labelMedium,
// //                         ),
// //                       ],
// //                     ),
// //                     const SizedBox(width: 50),
// //                     Row(
// //                       children: [
// //                         const Icon(
// //                           Icons.school_rounded,
// //                           size: 16,
// //                         ),
// //                         const SizedBox(width: 5),
// //                         Text(
// //                           item.faculty,
// //                           style: Theme.of(context).textTheme.labelMedium,
// //                         ),
// //                       ],
// //                     ),
// //                     Row(
// //                       children: [
// //                         const Icon(
// //                           Icons.business_rounded,
// //                           size: 16,
// //                         ),
// //                         const SizedBox(width: 5),
// //                         Text(
// //                           item.organisation,
// //                           style: Theme.of(context).textTheme.labelMedium,
// //                         ),
// //                       ],
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //               onTap: () {
// //                 debugPrint("card tapped");
// //                 manager.classgroupItemTapped(item.id);
// //               },
// //             ),
// //           ),
// //         );
// //       },
// //       separatorBuilder: (context, index) {
// //         return const SizedBox(height: 5.0);
// //       },
// //     );
// //   }
// // }
