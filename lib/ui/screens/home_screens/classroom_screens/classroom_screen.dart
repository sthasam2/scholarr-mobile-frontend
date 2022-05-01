// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import 'package:scholarr_mobile_frontend/models/models.dart';
// import 'package:scholarr_mobile_frontend/ui/screens/screens.dart';
// import 'package:scholarr_mobile_frontend/ui/components/components.dart';

// class ClassgroupScreen extends StatefulWidget {
//   const ClassgroupScreen({Key? key}) : super(key: key);

//   static MaterialPage page() {
//     return MaterialPage(
//         name: AppPages.classgroupPath,
//         key: ValueKey(AppPages.classgroupPath),
//         child: const ClassgroupScreen());
//   }

//   @override
//   State<ClassgroupScreen> createState() => _ClassgroupScreenState();
// }

// class _ClassgroupScreenState extends State<ClassgroupScreen> {
//   late Future<Map> _classgroupList;

//   @override
//   void initState() {
//     _classgroupList = Provider.of<ClassgroupManager>(context, listen: false)
//         .getClassgroupItems();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'CLASSGROUP',
//           style: Theme.of(context).textTheme.headlineMedium,
//         ),
//         // automaticallyImplyLeading: false,
//         leading: IconButton(
//             icon: const Icon(
//               Icons.arrow_back_rounded,
//               size: 30,
//             ),
//             onPressed: () {
//               Provider.of<AppStateManager>(context, listen: false)
//                   .goToTab(AppTab.home);
//               Navigator.pop(context, true);
//             }),
//       ),
//       floatingActionButton: buildMenuFloatingActionButton(
//           context, const Icon(Icons.menu_rounded), true),
//       floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
//       bottomNavigationBar: Padding(
//           padding: const EdgeInsets.fromLTRB(40, 10, 40, 20),
//           child: buildButton(context, "CREATE CLASSGROUP")),
//       body: FutureBuilder(
//         future: _classgroupList,
//         builder: (BuildContext context, AsyncSnapshot snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           }

//           if (snapshot.hasData) {
//             return buildClassgroupScreen(context);
//           }

//           if (snapshot.hasError) {
//             return Center(
//               child: SizedBox(
//                 width: 250,
//                 height: 75,
//                 child: errorInfoBox(context, "Oops!", "Something went wrong"),
//               ),
//             );
//           }

//           return SizedBox();
//         },
//       ),
//     );
//   }

//   Widget buildButton(context, action) {
//     return SizedBox(
//       height: 55,
//       child: MaterialButton(
//         color: Colors.red[700],
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//         child: Text(
//           action,
//           style: Theme.of(context).textTheme.bodyLarge,
//         ),
//         onPressed: () {
//           final manager =
//               Provider.of<ClassgroupManager>(context, listen: false);
//           manager.createNewItem();
//           // manager.setClassgroupItems();
//         },
//       ),
//     );
//   }

//   Widget buildClassgroupScreen(context) {
//     return StatefulWrapper(
//       onInit: () {
//         Provider.of<ClassgroupManager>(context, listen: false)
//             .setClassgroupItems();
//       },
//       child: Consumer<ClassgroupManager>(
//         builder: (context, manager, child) {
//           if (manager.createdClassgroupItems.isNotEmpty &&
//               manager.studentClassgroupItems.isNotEmpty) {
//             return ClassgroupListScreen(manager: manager);
//           } else {
//             return EmptyClassgroupScreen(manager: manager);
//           }
//         },
//       ),
//     );
//   }
// }

// // class ClassgroupScreen extends StatelessWidget {
// //   const ClassgroupScreen({Key? key}) : super(key: key);

// //   static MaterialPage page() {
// //     return MaterialPage(
// //         name: AppPages.classgroupPath,
// //         key: ValueKey(AppPages.classgroupPath),
// //         child: const ClassgroupScreen());
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text(
// //           'Classgroups',
// //           style: Theme.of(context).textTheme.headlineMedium,
// //         ),
// //         // automaticallyImplyLeading: false,
// //         leading: IconButton(
// //             icon: const Icon(
// //               Icons.arrow_back_rounded,
// //               size: 30,
// //             ),
// //             onPressed: () {
// //               Provider.of<AppStateManager>(context, listen: false)
// //                   .goToTab(AppTab.home);
// //               Navigator.pop(context, true);
// //             }),
// //       ),
// //       floatingActionButton: buildMenuFloatingActionButton(
// //           context, const Icon(Icons.menu_rounded), true),
// //       floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
// //       body: buildClassgroupScreen(context),
// //       bottomNavigationBar: Padding(
// //           padding: const EdgeInsets.fromLTRB(40, 10, 40, 20),
// //           child: buildButton(context, "CREATE CLASSROOM")),
// //     );
// //   }

// //   Widget buildButton(context, action) {
// //     return SizedBox(
// //       height: 55,
// //       child: MaterialButton(
// //         color: Colors.red[700],
// //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
// //         child: Text(
// //           action,
// //           style: Theme.of(context).textTheme.bodyLarge,
// //         ),
// //         onPressed: () {
// //           final manager =
// //               Provider.of<ClassgroupManager>(context, listen: false);
// //           manager.createNewItem();
// //           // manager.setClassgroupItems();
// //         },
// //       ),
// //     );
// //   }

// //   Widget buildClassgroupScreen(context) {
// //     return StatefulWrapper(
// //       onInit: () {
// //         Provider.of<ClassgroupManager>(context, listen: false)
// //             .setClassgroupItems();
// //       },
// //       child: Consumer<ClassgroupManager>(
// //         builder: (context, manager, child) {
// //           if (manager.createdClassgroupItems.isNotEmpty &&
// //               manager.studentClassgroupItems.isNotEmpty) {
// //             return ClassgroupListScreen(manager: manager);
// //           } else {
// //             return EmptyClassgroupScreen(manager: manager);
// //           }
// //         },
// //       ),
// //     );
// //   }
// // }
