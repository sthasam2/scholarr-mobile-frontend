import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:scholarr_mobile_frontend/data/data.dart';
import 'package:scholarr_mobile_frontend/models/app_state_manager.dart';
import 'package:scholarr_mobile_frontend/models/models.dart';
import 'package:scholarr_mobile_frontend/ui/components/components.dart';
import 'package:scholarr_mobile_frontend/ui/screens/screens.dart';

class ClassroomItemScreen extends StatefulWidget {
  final ClassroomItem? originalClassroom;
  final bool isUpdating;
  final int index;

  const ClassroomItemScreen({
    Key? key,
    this.originalClassroom,
    this.index = -1,
  })  : isUpdating = (originalClassroom != null),
        super(key: key);

  static MaterialPage page({
    ClassroomItem? item,
    int index = -1,
  }) {
    return MaterialPage(
      name: AppPages.classroomItemPath,
      key: ValueKey(AppPages.classroomItemPath),
      child: ClassroomItemScreen(
        originalClassroom: item,
        index: index,
      ),
    );
  }

  @override
  State<ClassroomItemScreen> createState() => _ClassroomItemScreen();
}

class _ClassroomItemScreen extends State<ClassroomItemScreen> {
  final _nameController = TextEditingController();
  final _subjectController = TextEditingController();
  // final _facultyController = TextEditingController();
  // final _organisationController = TextEditingController();

  String _name = "";
  String _subject = "";
  // String _faculty = "";
  // String _organisation = "";

  bool _isSubmitButtonTapped = false;
  bool _isSubmitSuccess = false;
  bool _isSubmitFailure = false;
  var _response = null;

  final ClassroomClient _classRoomClient = ClassroomClient();

  @override
  void initState() {
    super.initState();
    final originalClassroom = widget.originalClassroom;

    if (originalClassroom != null) {
      _nameController.text = originalClassroom.name;
      _subjectController.text = originalClassroom.subject;

      _name = originalClassroom.name;
      _subject = originalClassroom.subject;
    }

    _nameController.addListener(() {
      setState(() {
        _name = _nameController.text;
      });
    });

    _subjectController.addListener(() {
      setState(() {
        _subject = _subjectController.text;
      });
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _subjectController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: const Text(''),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_rounded,
              size: 30,
            ),
            onPressed: () {
              Provider.of<ClassroomManager>(context, listen: false)
                  .cancelCreateNewItem();
              Navigator.pop(context, true);
            },
          )
          // leading: GestureDetector(
          //   child: const Icon(
          //     Icons.arrow_back_rounded,
          //     size: 30,
          //   ),
          //   onTap: () {
          //     Provider.of<ClassroomManager>(context, listen: false)
          //         .cancelCreateNewItem();
          //     Navigator.pop(context, true);
          //   },
          ),
      body: ListView(
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.all(40),
        children: [
          Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 100,
                  child: Text(
                    widget.isUpdating
                        ? "CLASSROOM\nUPDATE"
                        : "CLASSROOM\nCREATE",
                    style: Theme.of(context).textTheme.headlineLarge,
                    textAlign: TextAlign.center,
                  ),
                ),
              ]),
          _response != null && _isSubmitSuccess
              ? successInfoBox(
                  context,
                  _response.success["message"],
                  _response.success["verbose"],
                )
              : Container(),
          _response != null && _isSubmitFailure
              ? errorInfoBox(
                  context,
                  _response.error["message"],
                  _response.error["verbose"],
                )
              : Container(),
          const SizedBox(height: 20),
          textField(
            context,
            Icons.title_rounded,
            'Name',
            false,
            _nameController,
            TextInputType.text,
          ),
          const SizedBox(height: 20),
          textField(
            context,
            Icons.calendar_today_rounded,
            'Subject',
            false,
            _subjectController,
            TextInputType.text,
          ),
          const SizedBox(height: 40),
          buildSubmitButton(context, "SUBMIT"),
        ],
      ),
    );
  }

  Widget buildSubmitButton(BuildContext context, String action) {
    if (_isSubmitButtonTapped) {
      return SizedBox(
        height: 55,
        child: MaterialButton(
          color: Colors.red.withOpacity(0.3),
          onPressed: null,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    } else {
      return SizedBox(
        height: 55,
        child: MaterialButton(
          color: Colors.red[700],
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Text(
            action,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          onPressed: () async {
            _isSubmitButtonTapped = true;

            setState(() {
              _isSubmitButtonTapped = true;
            });

            if (widget.isUpdating && widget.originalClassroom != null) {
              _response = await _classRoomClient.updateClassroom(
                widget.originalClassroom!.id,
                _name,
                _subject,
              );
            } else {
              _response = await _classRoomClient.createClassroom(
                _name,
                _subject,
              );
            }

            if (_response.status! < 400) {
              setState(() {
                _isSubmitButtonTapped = false;
                _isSubmitSuccess = true;
                _isSubmitFailure = false;
              });
            } else if (_response.status! >= 400) {
              setState(() {
                _isSubmitButtonTapped = false;
                _isSubmitSuccess = false;
                _isSubmitFailure = true;
              });
            }
          },
        ),
      );
    }
  }
}
