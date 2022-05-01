import '../../urls.dart' show URL;

class AuthUrls {
  String authURL() => URL + "/api/auth";

  String registerURL() => authURL() + "/register";

  String loginURL() => authURL() + "/login";
  String loginRefreshURL() => loginURL() + "/refresh";
  String logoutURL() => authURL() + "/logout";

  String emailVerificationSendURL() => authURL() + "/email_verification/send";
  String emailVerificationConfirmURL(uidb64, token) =>
      authURL() + "/email_verification/confirm/$uidb64/$token";

  String resetPasswordSendURL() => authURL() + "/reset_password/send";
  String resetPasswordConfirmURL() => authURL() + "/reset_password/confirm";

  String userURL() => authURL() + "/user";
  String userActivateURL() => userURL() + "/activate";
  String userDeactivateURL(username) =>
      userURL() + "/username=$username/deactivate";
  String userChangePasswordURL(username) =>
      userURL() + "/username=$username/change_password";
  String userDetailURL(username) => userURL() + "/username=$username/detail";
  String userDeleteURL(username) => userURL() + "//username=$username/delete";
  String userUpdateURL(username) => userURL() + "/username=$username/update";
}
