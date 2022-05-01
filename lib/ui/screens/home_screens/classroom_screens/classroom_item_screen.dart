// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:scholarr_mobile_frontend/models/app_state_manager.dart';

// import 'package:scholarr_mobile_frontend/ui/components/components.dart';
// import 'package:scholarr_mobile_frontend/models/models.dart';
// import 'package:scholarr_mobile_frontend/data/data.dart';
// import 'package:scholarr_mobile_frontend/ui/screens/screens.dart';

// class ClassgroupItemScreen extends StatefulWidget {
//   final ClassGroupItem? originalClassgroup;
//   final bool isUpdating;
//   final int index;

//   const ClassgroupItemScreen({
//     Key? key,
//     this.originalClassgroup,
//     this.index = -1,
//   })  : isUpdating = (originalClassgroup != null),
//         super(key: key);

//   static MaterialPage page({
//     ClassGroupItem? item,
//     int index = -1,
//   }) {
//     return MaterialPage(
//       name: AppPages.classgroupItemPath,
//       key: ValueKey(AppPages.classgroupItemPath),
//       child: ClassgroupItemScreen(
//         originalClassgroup: item,
//         index: index,
//       ),
//     );
//   }

//   @override
//   State<ClassgroupItemScreen> createState() => _ClassgroupItemScreen();
// }

// class _ClassgroupItemScreen extends State<ClassgroupItemScreen> {
//   final _nameController = TextEditingController();
//   final _batchController = TextEditingController();
//   final _facultyController = TextEditingController();
//   final _organisationController = TextEditingController();

//   String _name = "";
//   String _batch = "";
//   String _faculty = "";
//   String _organisation = "";

//   bool _isSubmitButtonTapped = false;
//   bool _isSubmitSuccess = false;
//   bool _isSubmitFailure = false;
//   var _response = null;

//   final ClassGroupClient _classGroupClient = ClassGroupClient();

//   @override
//   void initState() {
//     super.initState();
//     final originalClassroom = widget.originalClassgroup;

//     if (originalClassroom != null) {
//       _nameController.text = originalClassroom.name;
//       _batchController.text = originalClassroom.batch;
//       _facultyController.text = originalClassroom.faculty;
//       _organisationController.text = originalClassroom.organisation;
//       _name = originalClassroom.name;
//       _batch = originalClassroom.batch;
//       _faculty = originalClassroom.faculty;
//       _organisation = originalClassroom.organisation;
//     }

//     _nameController.addListener(() {
//       setState(() {
//         _name = _nameController.text;
//       });
//     });

//     _batchController.addListener(() {
//       setState(() {
//         _batch = _batchController.text;
//       });
//     });

//     _facultyController.addListener(() {
//       setState(() {
//         _faculty = _facultyController.text;
//       });
//     });

//     _organisationController.addListener(() {
//       setState(() {
//         _organisation = _organisationController.text;
//       });
//     });
//   }

//   @override
//   void dispose() {
//     _nameController.dispose();
//     _batchController.dispose();
//     _facultyController.dispose();
//     _organisationController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//           backgroundColor: Colors.transparent,
//           elevation: 0.0,
//           title: const Text(''),
//           leading: IconButton(
//             icon: const Icon(
//               Icons.arrow_back_rounded,
//               size: 30,
//             ),
//             onPressed: () {
//               Provider.of<ClassgroupManager>(context, listen: false)
//                   .cancelCreateNewItem();
//               Navigator.pop(context, true);
//             },
//           )
//           // leading: GestureDetector(
//           //   child: const Icon(
//           //     Icons.arrow_back_rounded,
//           //     size: 30,
//           //   ),
//           //   onTap: () {
//           //     Provider.of<ClassgroupManager>(context, listen: false)
//           //         .cancelCreateNewItem();
//           //     Navigator.pop(context, true);
//           //   },
//           ),
//       body: ListView(
//         scrollDirection: Axis.vertical,
//         padding: const EdgeInsets.all(40),
//         children: [
//           Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 SizedBox(
//                   height: 100,
//                   child: Text(
//                     widget.isUpdating
//                         ? "CLASSGROUP\nUPDATE"
//                         : "CLASSGROUP\nCREATE",
//                     style: Theme.of(context).textTheme.headlineLarge,
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//               ]),
//           // _response != null && _isSubmitSuccess
//           //     ? successInfoBox(
//           //         context,
//           //         _response.success["message"],
//           //         _response.success["verbose"],
//           //       )
//           //     : Container(),
//           _response != null && _isSubmitFailure
//               ? errorInfoBox(
//                   context,
//                   _response.error["message"],
//                   _response.error["verbose"],
//                 )
//               : Container(),
//           const SizedBox(height: 20),
//           textField(
//             context,
//             const Icon(Icons.title_rounded),
//             'Name',
//             false,
//             _nameController,
//           ),
//           const SizedBox(height: 20),
//           textField(
//             context,
//             const Icon(Icons.calendar_today_rounded),
//             'Batch',
//             false,
//             _batchController,
//           ),
//           const SizedBox(height: 20),
//           textField(
//             context,
//             const Icon(Icons.school_rounded),
//             'Faculty',
//             false,
//             _facultyController,
//           ),
//           const SizedBox(height: 20),
//           textField(
//             context,
//             const Icon(Icons.business_rounded),
//             'Organisation',
//             false,
//             _organisationController,
//           ),
//           const SizedBox(height: 40),
//           buildSubmitButton(context, "SUBMIT"),
//         ],
//       ),
//     );
//   }

//   Widget buildSubmitButton(BuildContext context, String action) {
//     if (_isSubmitButtonTapped) {
//       return SizedBox(
//         height: 55,
//         child: MaterialButton(
//           color: Colors.red.withOpacity(0.3),
//           onPressed: null,
//           shape:
//               RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//           child: const Center(
//             child: CircularProgressIndicator(),
//           ),
//         ),
//       );
//     } else {
//       return SizedBox(
//         height: 55,
//         child: MaterialButton(
//           color: Colors.red[700],
//           shape:
//               RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//           child: Text(
//             action,
//             style: Theme.of(context).textTheme.bodyLarge,
//           ),
//           onPressed: () async {
//             // Provider.of<AppStateManager>(context, listen: false).signUp(
//             //     _usernameController.text,
//             //     _emailController.text,
//             //     _passwordController.text);
//             _isSubmitButtonTapped = true;

//             setState(() {
//               _isSubmitButtonTapped = true;
//             });

//             if (widget.isUpdating && widget.originalClassgroup != null) {
//               _response = await _classGroupClient.updateClassgroup(
//                   widget.originalClassgroup!.id,
//                   _name,
//                   _batch,
//                   _faculty,
//                   _organisation);
//             } else {
//               _response = await _classGroupClient.createClassgroup(
//                   _name, _batch, _faculty, _organisation);
//             }

//             if (_response.status! < 400) {
//               setState(() {
//                 _isSubmitButtonTapped = false;
//                 _isSubmitSuccess = true;
//                 _isSubmitFailure = false;
//               });
//             } else if (_response.status! >= 400) {
//               setState(() {
//                 _isSubmitButtonTapped = false;
//                 _isSubmitSuccess = false;
//                 _isSubmitFailure = true;
//               });
//             }
//           },
//         ),
//       );
//     }
//   }
// }
