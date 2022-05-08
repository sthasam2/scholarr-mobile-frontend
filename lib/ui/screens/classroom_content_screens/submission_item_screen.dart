import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'package:scholarr_mobile_frontend/data/api_client/classroom_content/classcontent_api_client.dart';

import 'package:scholarr_mobile_frontend/models/models.dart';
import 'package:scholarr_mobile_frontend/ui/components/components.dart';

class ClassworkSubmissionItemScreen extends StatefulWidget {
  final ClasscontentManager classcontentManager;

  const ClassworkSubmissionItemScreen({
    Key? key,
    required this.classcontentManager,
  }) : super(key: key);

  static MaterialPage page({
    required ClasscontentManager classcontentManager,
  }) {
    return MaterialPage(
      name: AppPages.classroomContentSubmissionItemPath,
      key: ValueKey(AppPages.classroomContentSubmissionItemPath),
      child: ClassworkSubmissionItemScreen(
        classcontentManager: classcontentManager,
      ),
    );
  }

  @override
  State<ClassworkSubmissionItemScreen> createState() =>
      _ClassworkSubmissionItemScreen();
}

class _ClassworkSubmissionItemScreen
    extends State<ClassworkSubmissionItemScreen> {
  final _answerController = TextEditingController();

  String _answer = "";

  bool _isSubmitButtonTapped = false;
  bool _isSubmitSuccess = false;
  bool _isSubmitFailure = false;

  var _response = null;

  // final classwork_content_options = <String>[
  //   "ASSIGNMENT",
  //   "QUESTION",
  //   "TEST",
  //   "POLL",
  //   "DEFAULT"
  // ];
  // var _dropdownValue = "ASSIGNMENT";
  final ClasscontentClient _classcontentClient = ClasscontentClient();

  late List<PlatformFile> _files;
  String? _pickedFilePath;
  String? pickedFile = "None";

  // DateTime selectedDate = DateTime.now();
  // late String _selectedDateString =
  //     selectedDate.toLocal().toString().split(" ")[0];

  // Future<void> _selectDate(BuildContext context) async {
  //   final DateTime? picked = await showDatePicker(
  //       context: context,
  //       initialDate: selectedDate,
  //       firstDate: DateTime(2015, 8),
  //       lastDate: DateTime(2101));
  //   if (picked != null && picked != selectedDate) {
  //     setState(() {
  //       selectedDate = picked;
  //       _selectedDateString = selectedDate.toLocal().toString().split(" ")[0];
  //     });
  //   }
  // }

  void _openFileExplorer() async {
    _files = (await FilePicker.platform.pickFiles(
      type: FileType.any,
      allowMultiple: false,
      allowedExtensions: null,
    ))!
        .files;

    _pickedFilePath = _files.first.path;
    pickedFile = _files.first.path?.split("/").last;

    setState(() {});
    debugPrint('Loaded file path is: ${pickedFile!.split("/").last}');
  }

  @override
  void initState() {
    super.initState();

    _answerController.addListener(() {
      setState(() {
        _answer = _answerController.text;
      });
    });

    // _descriptionController.addListener(() {
    //   setState(() {
    //     _description = _descriptionController.text;
    //   });
    // });
    // _weightageController.addListener(() {
    //   setState(() {
    //     _weightage = _weightageController.text;
    //   });
    // });
  }

  @override
  void dispose() {
    _answerController.dispose();
    // _descriptionController.dispose();
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
              widget.classcontentManager.cancelCreateSubmissionItem();
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
                  "SUBMISSION\nCREATE",
                  style: Theme.of(context).textTheme.headlineLarge,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
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
            'Answer',
            false,
            _answerController,
            TextInputType.multiline,
          ),
          // const SizedBox(height: 20),
          // textField(
          //   context,
          //   Icons.description_rounded,
          //   'Description',
          //   false,
          //   _descriptionController,
          //   TextInputType.multiline,
          // ),
          // const SizedBox(height: 20),
          // Row(
          //   children: [
          //     Flexible(
          //       flex: 5,
          //       child: buildDropDown(
          //         context,
          //         widget.classcontentManager.getCreateClasscontentType,
          //       ),
          //     ),
          //     SizedBox(
          //       width: 10,
          //     ),
          //     Flexible(
          //       flex: 4,
          //       child: textField(
          //         context,
          //         null,
          //         "Weighage",
          //         false,
          //         _weightageController,
          //         TextInputType.number,
          //       ),
          //     ),
          //   ],
          // ),
          // const SizedBox(height: 20),
          // buildDatePicker(context),
          const SizedBox(height: 20),
          buildFilePickerButton(context),
          const SizedBox(height: 40),
          buildSubmitButton(context, "SUBMIT"),
        ],
      ),
    );
  }

  // Widget buildDropDown(BuildContext context, String? classcontentType) {
  //   final items;

  //   if (classcontentType == "CLASSWORK") {
  //     items = classwork_content_options
  //         .map<DropdownMenuItem<String>>((String value) {
  //       return DropdownMenuItem<String>(
  //         value: value,
  //         child: Text(value),
  //       );
  //     }).toList();
  //   }
  //   //
  //   else if (classcontentType == "RESOURCE") {
  //     items = <String>['One', 'Two', 'Free', 'Four']
  //         .map<DropdownMenuItem<String>>((String value) {
  //       return DropdownMenuItem<String>(
  //         value: value,
  //         child: Text(value),
  //       );
  //     }).toList();
  //   } else {
  //     items = <String>['One', 'Two', 'Free', 'Four']
  //         .map<DropdownMenuItem<String>>((String value) {
  //       return DropdownMenuItem<String>(
  //         value: value,
  //         child: Text(value),
  //       );
  //     }).toList();
  //   }

  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Padding(
  //         padding: const EdgeInsets.fromLTRB(5, 0, 0, 10),
  //         child: Text(
  //           "Content Type".toUpperCase(),
  //           style: Theme.of(context).textTheme.labelMedium,
  //         ),
  //       ),
  //       SizedBox(
  //         height: 55,
  //         child: DecoratedBox(
  //           decoration: BoxDecoration(
  //             color: const Color.fromARGB(100, 113, 113, 113),
  //             borderRadius: BorderRadius.circular(15),
  //           ),
  //           child: Padding(
  //             padding: const EdgeInsets.all(20.0),
  //             child: DropdownButton<String>(
  //                 value: _dropdownValue,
  //                 icon: const Icon(Icons.arrow_drop_down_rounded),
  //                 elevation: 16,
  //                 style: Theme.of(context).textTheme.bodyMedium,
  //                 isExpanded: true,
  //                 underline: Container(),
  //                 onChanged: (String? newValue) {
  //                   setState(() {
  //                     _dropdownValue = newValue!;
  //                     _contentType = newValue;
  //                   });
  //                 },
  //                 items: items),
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  Widget buildFilePickerButton(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 10),
          child: Text(
            "Attachments".toUpperCase(),
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ),
        SizedBox(
          width: 320,
          height: 70,
          child: MaterialButton(
            color: const Color.fromARGB(100, 113, 113, 113),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  text: "Pick Attachment",
                  style: Theme.of(context).textTheme.bodyMedium,
                  children: [
                    TextSpan(
                      text: "\nPicked: " + pickedFile!,
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ]),
            ),
            onPressed: _openFileExplorer,
          ),
        ),
      ],
    );
  }

  // Widget buildDatePicker(BuildContext context) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Padding(
  //         padding: const EdgeInsets.fromLTRB(5, 0, 0, 10),
  //         child: Text(
  //           "deadline".toUpperCase(),
  //           style: Theme.of(context).textTheme.labelMedium,
  //         ),
  //       ),
  //       SizedBox(
  //         width: 320,
  //         height: 55,
  //         child: MaterialButton(
  //           color: const Color.fromARGB(100, 113, 113, 113),
  //           shape:
  //               RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
  //           child: RichText(
  //               textAlign: TextAlign.center,
  //               text: TextSpan(
  //                   text: "Pick Deadline",
  //                   style: Theme.of(context).textTheme.bodyMedium,
  //                   children: [
  //                     TextSpan(
  //                       text: "\nPicked: " + _selectedDateString,
  //                       style: Theme.of(context).textTheme.labelSmall,
  //                     ),
  //                   ])),
  //           onPressed: () => _selectDate(context),
  //         ),
  //       ),
  //     ],
  //   );
  // }

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

            debugPrint("hello");

            _response = await _classcontentClient.createClassworkSubmission(
              widget.classcontentManager.selectedClassworkIndex,
              _answer,
              _pickedFilePath!,
              widget.classcontentManager.getCreateClasscontentType!,
            );

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
