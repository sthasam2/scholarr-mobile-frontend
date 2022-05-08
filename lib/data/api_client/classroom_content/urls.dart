import '../../urls.dart' show URL;

class ClasscontentUrls {
  //
  // CLASSCONTENT

  String classcontentURL() => URL + '/api/classcontent_content';

  //
  // READ
  String listClasscontentURL(int classroom_id) =>
      URL + '/api/classroom_content/classroom_id=$classroom_id/list';
  String listClassworkURL(int classroom_id) =>
      URL + '/api/classroom_content/classroom_id=$classroom_id/classwork/list';
  String listResourceURL(int classroom_id) =>
      URL + '/api/classroom_content/classroom_id=$classroom_id/resource/list';

  String listSubmissionURL(int classwork_id) =>
      URL + '/api/classroom_content/classwork_id=$classwork_id/submission/list';
  String listSelfSubmissionURL(int classwork_id) =>
      URL +
      '/api/classroom_content/classwork_id=$classwork_id/submission/self/list';

  String detailClassworkURL(int classwork_id) =>
      URL + '/api/classroom_content/classwork/id=$classwork_id/detail';
  String detailResourceURL(int resource_id) =>
      URL + '/api/classroom_content/resource/id=$resource_id/detail';
  String detailSubmissionURL(int submission_id) =>
      URL + '/api/classroom_content/submission/id=$submission_id/detail';

  String submissionPlagiarismURL(int submission_id) =>
      URL + 'api/plagiarism/submission_id=$submission_id/list';

  //
  // CREATE
  String createClassworkURL(int classroom_id) =>
      URL +
      '/api/classroom_content/classroom_id=$classroom_id/classwork/create';
  String createResourceURL(int classroom_id) =>
      URL + '/api/classroom_content/classroom_id=$classroom_id/resource/create';
  String createSubmissionURL(int classwork_id) =>
      URL +
      '/api/classroom_content/classwork_id=$classwork_id/submission/create';

  //
  // UPDATE

  String updateClassworkURL(int classwork_id) =>
      URL + '/api/classroom_content/classwork/id=$classwork_id/update';
  String updateResourceURL(int resource_id) =>
      URL + '/api/classroom_content/resource/id=$resource_id/update';
  String updateSubmissionURL(int submission_id) =>
      URL + '/api/classroom_content/submission/id=$submission_id/update';
  String gradeSubmissionURL(int submission_id) =>
      URL + '/api/classroom_content/submission/id=$submission_id/grade';

  //
  // DELETE

  String deleteClassworkURL(int classwork_id) =>
      URL + '/api/classroom_content/classwork/id=$classwork_id/delete';
  String deleteResourceURL(int resource_id) =>
      URL + '/api/classroom_content/resource/id=$resource_id/delete';
  String deleteSubmissionURL(int submission_id) =>
      URL + '/api/classroom_content/submission/id=$submission_id/delete';
}
