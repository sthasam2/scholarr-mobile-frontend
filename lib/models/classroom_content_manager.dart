import 'package:flutter/material.dart';
import 'package:scholarr_mobile_frontend/data/api_client/classroom_content/classcontent_api_client.dart';

import 'package:scholarr_mobile_frontend/data/data.dart';
import 'package:scholarr_mobile_frontend/models/models.dart';

class ClasscontentManager extends ChangeNotifier {
  // ATTRIBUTES

  Map ClasscontentTypes = {
    "classwork": "CLASSWORK",
    "resource": "RESOURCE",
    "submission": "SUBMISSION"
  };

  late int _selectedClassroomIndex = -1;
  late int _selectedClassworkIndex = -1;
  late int _selectedResourceIndex = -1;
  late int _selectedSubmissionIndex = -1;
  late int _selectedClasscontentCreatorIndex = -1;

  late bool _createNewItem = false;
  late bool _gettingDetail = false;

  late bool _gettingSubmissionDetail = false;
  late bool _gettingClassworkDetail = false;
  late bool _gettingResourceDetail = false;

  late bool _createSubmissionItem = false;

  String? _createClasscontentType;
  String? _detailClasscontentType;

  Map _selectedClassroomContentList = {};
  Map _selectedSubmissionList = {};
  Map _selectedResourceItemDetail = {};
  Map _selectedClassworkItemDetail = {};
  Map _selectedSubmissionItemDetail = {};

  List _ClassworkItems = <ClassworkItemDetail>[];
  List _ResourceItems = <ResourceItemDetail>[];
  List _SubmissionItems = <ResourceItemDetail>[];

  final _classcontentClient = ClasscontentClient();

  //
  // GETTERS
  int get selectedClassroomIndex => _selectedClassroomIndex;
  int get selectedClassworkIndex => _selectedClassworkIndex;
  int get selectedResourceIndex => _selectedResourceIndex;
  int get selectedSubmissionIndex => _selectedSubmissionIndex;
  int get selectedClasscontentCreatorIndex => _selectedClasscontentCreatorIndex;

  bool get isCreatingNewItem => _createNewItem;
  bool get isGettingDetail => _gettingDetail;

  bool get isCreatingSubmissionItem => _createSubmissionItem;
  bool get isGettingSubmissionDetail => _gettingSubmissionDetail;

  String? get getCreateClasscontentType => _createClasscontentType;
  String? get getDetailClasscontentType => _detailClasscontentType;

  Map get classroomContentList =>
      Map.unmodifiable(_selectedClassroomContentList);
  Map get submissionList => Map.unmodifiable(_selectedSubmissionList);
  // List<ClasscontentItem> get studyingClasscontentItems =>
  //     List.unmodifiable(_studyingClasscontentItems);
  // Map get selectedClasscontentDetail =>
  //     Map.unmodifiable(_selectedClasscontentItemDetail);

  //
  // SETTERS
  void setClassroomContentList(int classroom_id) async {
    if (classroom_id != -1) {
      final classcontents =
          await _classcontentClient.getClasscontentList(classroom_id);
      _selectedClassroomContentList = classcontents;
    }
    debugPrint("Classcontent Done");
  }

  void setSubmissionList(int classwork_id) async {
    if (classwork_id != -1) {
      final submissions =
          await _classcontentClient.getClassworkSubmissionList(classwork_id);
      _selectedSubmissionList = submissions;
    }
    debugPrint("Classcontent Done");
  }

  Future<Map> getClassroomContentList(int classroom_id) async {
    if (classroom_id != -1) {
      final classcontents =
          await _classcontentClient.getClasscontentList(classroom_id);
      _selectedClassroomContentList = classcontents;
      return classcontents;
    }
    return _selectedClassroomContentList;
  }

  Future<Map> getSubmissionList(int classwork_id) async {
    if (classwork_id != -1) {
      final submissions =
          await _classcontentClient.getClassworkSubmissionList(classwork_id);
      _selectedSubmissionList = submissions;
      return submissions;
    }
    debugPrint("Classcontent Done");

    return _selectedSubmissionList;
  }

  void setSelectedClasscontentItemDetail() async {
    if (_detailClasscontentType! == "CLASSWORK" &&
        _selectedClassworkIndex != -1) {
      final classworkDetail = await _classcontentClient.getClasscontentDetail(
          _selectedClassworkIndex, _detailClasscontentType!);

      _selectedClassworkItemDetail = classworkDetail;
    }

    if (_detailClasscontentType! == "RESOURCE" &&
        _selectedResourceIndex != -1) {
      final resourceDetail = await _classcontentClient.getClasscontentDetail(
          _selectedResourceIndex, _detailClasscontentType!);

      _selectedResourceItemDetail = resourceDetail;
    }
    debugPrint("Classcontent Done");
  }

  Future<Map> getSelectedClasscontentItemDetail() async {
    if (_detailClasscontentType! == "CLASSWORK" &&
        _selectedClassworkIndex != -1) {
      final classworkDetail = await _classcontentClient.getClasscontentDetail(
          _selectedClassworkIndex, _detailClasscontentType!);

      _selectedClassworkItemDetail = classworkDetail;
      _selectedClasscontentCreatorIndex =
          classworkDetail["classwork"]!.created_by;
      return classworkDetail;
    }

    if (_detailClasscontentType! == "RESOURCE" &&
        _selectedResourceIndex != -1) {
      final resourceDetail = await _classcontentClient.getClasscontentDetail(
          _selectedResourceIndex, _detailClasscontentType!);

      _selectedResourceItemDetail = resourceDetail;
      _selectedClasscontentCreatorIndex =
          resourceDetail["resource"]!.created_by;
      return resourceDetail;
    }

    debugPrint("Classcontent Done");
    return {};
  }

  void createNewItem(classroom_id, classcontentType) {
    _createNewItem = true;
    _selectedClassroomIndex = classroom_id;
    _createClasscontentType = classcontentType;

    notifyListeners();
  }

  void createNewSubmissionItem(classwork_id, classcontentType) {
    _createSubmissionItem = true;
    _selectedClassworkIndex = classwork_id;
    _createClasscontentType = classcontentType;

    notifyListeners();
  }

  void cancelCreateNewItem() {
    _createNewItem = false;
    _selectedClassroomIndex = -1;
    _createClasscontentType = null;
    notifyListeners();
  }

  void cancelCreateSubmissionItem() {
    _createSubmissionItem = false;
    _selectedClassworkIndex = -1;
    _createClasscontentType = null;
    notifyListeners();
  }

  void resetClassroomContentDetailItem() {
    _createNewItem = false;
    _gettingDetail = false;
    _selectedClassroomIndex = -1;
    _createClasscontentType = null;
    notifyListeners();
  }

  void classcontentItemTapped(int index, String type) {
    _gettingDetail = true;
    _createNewItem = false;

    if (type == "CLASSWORK") {
      _selectedClassworkIndex = index;
    } else if (type == "RESOURCE") {
      _selectedResourceIndex = index;
    }

    _detailClasscontentType = type;

    notifyListeners();
  }

  void classworkSubmissionItemTapped(int index, String type) {
    _gettingSubmissionDetail = true;
    _createSubmissionItem = false;
    _selectedSubmissionIndex = index;
    _detailClasscontentType = type;

    notifyListeners();
  }

  void resetClasscontentDetail() {
    _gettingDetail = false;
    _selectedClassroomIndex = -1;
    _selectedResourceIndex = -1;
    _detailClasscontentType = null;
  }

  void resetClassworkSubmissionDetail() {
    _gettingSubmissionDetail = false;
    _createSubmissionItem = false;
    _selectedSubmissionIndex = -1;
    _detailClasscontentType = null;
  }

  // void updateItem(ClasscontentItem item, int index) {
  //   _selectedIndex = -1;
  //   _createNewItem = false;
  //   notifyListeners();
  // }

  // void deleteItem(int index) {
  //   notifyListeners();
  // }

  // MEMBER METHODS
}
