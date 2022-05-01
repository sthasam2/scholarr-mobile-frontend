import 'package:flutter/material.dart';

import 'classgroups/classgroup.dart';
import 'package:scholarr_mobile_frontend/data/data.dart';
import 'package:scholarr_mobile_frontend/models/models.dart';

class ClassgroupManager extends ChangeNotifier {
  // ATTRIBUTES
  int _selectedIndex = -1;
  bool _createNewItem = false;
  bool _gettingDetail = false;

  Map _selectedClassgroupItemDetail = {};
  List _createdClassgroupItems = <ClassGroupItem>[];
  List _studentClassgroupItems = <ClassGroupItem>[];

  final ClassGroupClient _classGroupClient = ClassGroupClient();

  // GETTERS
  int get selectedIndex => _selectedIndex;
  bool get isCreatingNewItem => _createNewItem;
  bool get isGettingDetail => _gettingDetail;

  List<ClassGroupItem> get createdClassgroupItems =>
      List.unmodifiable(_createdClassgroupItems);
  List<ClassGroupItem> get studentClassgroupItems =>
      List.unmodifiable(_studentClassgroupItems);
  Map get selectedClassgroupDetail =>
      Map.unmodifiable(_selectedClassgroupItemDetail);

  // SETTERS
  void setClassgroupItems() async {
    final classgroups = await _classGroupClient.getClassgroupList();

    _createdClassgroupItems = classgroups["created"];
    _studentClassgroupItems = classgroups["student"];

    debugPrint("Classgroup Done");
  }

  Future<Map> getClassgroupItems() async {
    final classgroups = await _classGroupClient.getClassgroupList();

    _createdClassgroupItems = classgroups["created"];
    _studentClassgroupItems = classgroups["student"];

    debugPrint("Classgroup Done");
    return classgroups;
  }

  void setSelectedClassGroupItemDetail() async {
    if (_selectedIndex != -1) {
      final classgroupDetail =
          await _classGroupClient.getClassgroupDetail(_selectedIndex);

      _selectedClassgroupItemDetail = classgroupDetail;
    }
    debugPrint("Classgroup Done");
  }

  Future<Map> getSelectedClassGroupItemDetail() async {
    if (_selectedIndex != -1) {
      final classgroupDetail =
          await _classGroupClient.getClassgroupDetail(_selectedIndex);

      _selectedClassgroupItemDetail = classgroupDetail;
      return classgroupDetail;
    }
    debugPrint("Classgroup Detail Done");
    return _selectedClassgroupItemDetail;
  }

  void createNewItem() {
    _createNewItem = true;
    notifyListeners();
  }

  void cancelCreateNewItem() {
    _createNewItem = false;
    notifyListeners();
  }

  void classgroupItemTapped(int index) {
    _gettingDetail = true;
    _createNewItem = false;
    _selectedIndex = index;
    notifyListeners();
  }

  void resetClassgroupDetail() {
    _gettingDetail = false;
    _selectedIndex = -1;
    _selectedClassgroupItemDetail = {};
  }

  void createItem(
    String name,
    String faculty,
    String batch,
    String organisation,
  ) {
    _createNewItem = false;
    notifyListeners();
  }

  void updateItem(ClassGroupItem item, int index) {
    _selectedIndex = -1;
    _createNewItem = false;
    notifyListeners();
  }

  void deleteItem(int index) {
    notifyListeners();
  }

  // MEMBER METHODS
}
