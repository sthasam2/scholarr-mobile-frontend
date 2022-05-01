// import 'package:flutter/material.dart';

// import 'classrooms/classroom.dart';
// import 'package:scholarr_mobile_frontend/data/data.dart';
// import 'package:scholarr_mobile_frontend/models/models.dart';

// class ClassroomManager extends ChangeNotifier {
//   // ATTRIBUTES
//   int _selectedIndex = -1;
//   bool _createNewItem = false;
//   bool _gettingDetail = false;

//   Map _selectedClassroomItemDetail = {};
//   List _createdClassroomItems = <ClassroomItem>[];
//   List _studentClassroomItems = <ClassroomItem>[];

//   final ClassroomClient _classroomClient = ClassroomClient();

//   // GETTERS
//   int get selectedIndex => _selectedIndex;
//   bool get isCreatingNewItem => _createNewItem;
//   bool get isGettingDetail => _gettingDetail;

//   List<ClassroomItem> get createdClassroomItems =>
//       List.unmodifiable(_createdClassroomItems);
//   List<ClassroomItem> get studentClassroomItems =>
//       List.unmodifiable(_studentClassroomItems);
//   Map get selectedClassroomDetail =>
//       Map.unmodifiable(_selectedClassroomItemDetail);

//   // SETTERS
//   void setClassroomItems() async {
//     final classrooms = await _classroomClient.getClassroomList();

//     _createdClassroomItems = classrooms["created"];
//     _studentClassroomItems = classrooms["student"];

//     debugPrint("Classroom Done");
//   }

//   Future<Map> getClassroomItems() async {
//     final classrooms = await _classroomClient.getClassroomList();

//     _createdClassroomItems = classrooms["created"];
//     _studentClassroomItems = classrooms["student"];

//     debugPrint("Classroom Done");
//     return classrooms;
//   }

//   void setSelectedClassroomItemDetail() async {
//     if (_selectedIndex != -1) {
//       final classroomDetail =
//           await _classroomClient.getClassroomDetail(_selectedIndex);

//       _selectedClassroomItemDetail = classroomDetail;
//     }
//     debugPrint("Classroom Done");
//   }

//   Future<Map> getSelectedClassroomItemDetail() async {
//     if (_selectedIndex != -1) {
//       final classroomDetail =
//           await _classroomClient.getClassroomDetail(_selectedIndex);

//       _selectedClassroomItemDetail = classroomDetail;
//       return classroomDetail;
//     }
//     debugPrint("Classroom Detail Done");
//     return _selectedClassroomItemDetail;
//   }

//   void createNewItem() {
//     _createNewItem = true;
//     notifyListeners();
//   }

//   void cancelCreateNewItem() {
//     _createNewItem = false;
//     notifyListeners();
//   }

//   void classroomItemTapped(int index) {
//     _gettingDetail = true;
//     _createNewItem = false;
//     _selectedIndex = index;
//     notifyListeners();
//   }

//   void resetClassroomDetail() {
//     _gettingDetail = false;
//     _selectedIndex = -1;
//     _selectedClassroomItemDetail = {};
//   }

//   void createItem(
//     String name,
//     String faculty,
//     String batch,
//     String organisation,
//   ) {
//     _createNewItem = false;
//     notifyListeners();
//   }

//   void updateItem(ClassroomItem item, int index) {
//     _selectedIndex = -1;
//     _createNewItem = false;
//     notifyListeners();
//   }

//   void deleteItem(int index) {
//     notifyListeners();
//   }

//   // MEMBER METHODS
// }
