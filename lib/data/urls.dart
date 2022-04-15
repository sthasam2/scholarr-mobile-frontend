// const URL = "localhost:8000";
// const URL = "http://10.0.2.2:8000";
// const URL = "http://127.0.0.1:8000";
const URL = "http://192.168.1.87:8000";

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
