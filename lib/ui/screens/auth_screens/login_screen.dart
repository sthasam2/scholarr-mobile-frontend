import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:scholarr_mobile_frontend/data/data.dart';
import 'package:scholarr_mobile_frontend/models/models.dart';
import 'package:scholarr_mobile_frontend/ui/components/components.dart';
import 'package:scholarr_mobile_frontend/ui/theme.dart';

class LoginScreen extends StatefulWidget {
  final String? username;
  final String? password;

  const LoginScreen({
    Key? key,
    this.username,
    this.password,
  }) : super(key: key);

  static MaterialPage page() {
    return MaterialPage(
        name: AppPages.loginPath,
        key: ValueKey(AppPages.loginPath),
        child: LoginScreen());
  }

  @override
  State<LoginScreen> createState() => LoginScreenState();
}

/// Login screen
class LoginScreenState extends State<LoginScreen> {
  static const String prefLoginAccess = 'previousLoginAccess';
  static const String prefLoginRefresh = 'previousLoginRefersh';
  static const String prefLoginUsername = 'previousLoginUsername';
  static const String prefLoginEmail = 'previousLoginEmail';
  static const String prefLoginId = 'previousLoginId';
  static const String prefLoggedIn = 'loggedIn';

  final AuthClient _authClient = AuthClient();
  final _client = http.Client();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoginButtonTapped = false;
  var _isLoginSuccess = false;
  var _isLoginFailure = false;
  var _response = null;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void saveLoginTokens(response) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(prefLoginAccess, response.access!);
    sharedPreferences.setString(prefLoginRefresh, response.refresh!);
    sharedPreferences.setString(
        prefLoginUsername, response.user_details["username"]!);
    sharedPreferences.setString(
        prefLoginEmail, response.user_details["email"]!);
    sharedPreferences.setInt(prefLoginId, response.user_details["id"]!);
    sharedPreferences.setBool(prefLoggedIn, true);
  }

  Future<Map<String?, String?>> getLoginTokens() async {
    final sharedPreferences = await SharedPreferences.getInstance();

    final String? accessToken = sharedPreferences.getString(prefLoginAccess);
    final String? refreshToken = sharedPreferences.getString(prefLoginRefresh);
    final String? username = sharedPreferences.getString(prefLoginUsername);
    final String? email = sharedPreferences.getString(prefLoginEmail);
    final int? id = sharedPreferences.getInt(prefLoginId);

    return {
      "access": accessToken,
      "refresh": refreshToken,
      "username": username,
      "email": email,
      "id": id.toString()
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: const Text(''),
        automaticallyImplyLeading: false,
        // leading: GestureDetector(
        //   child: const Icon(
        //     Icons.arrow_back_rounded,
        //     size: 30,
        //   ),
        //   onTap: () {
        //     Provider.of<AppStateManager>(context, listen: false)
        //         .goToAuthPage(0);
        //     Navigator.pop(context, true);
        //   },
        // ),
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
                    "LOGIN",
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                ),
              ]),
          _response != null && _isLoginFailure
              ? errorInfoBox(
                  context,
                  _response.error["message"],
                  _response.error["verbose"],
                )
              : Container(),
          const SizedBox(height: 20),
          textField(
            context,
            Icons.alternate_email_rounded,
            'Username',
            false,
            _usernameController,
            TextInputType.text,
          ),
          const SizedBox(height: 20),
          textField(
            context,
            Icons.lock_rounded,
            'Password',
            true,
            _passwordController,
            TextInputType.visiblePassword,
          ),
          buildForgotPwButton(context),
          const SizedBox(height: 40),
          buildLoginButton(context, "LOGIN"),
          buildRegisterButton(context),
        ],
      ),
    );
  }

  Widget buildForgotPwButton(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MaterialButton(
          padding: const EdgeInsets.all(10),
          child: Text(
            'Forgot Password?',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          onPressed: () {
            Provider.of<AppStateManager>(context, listen: false)
                .forgotPassword();
          },
        ),
      ],
    );
  }

  Widget buildRegisterButton(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MaterialButton(
          padding: const EdgeInsets.all(10),
          child: Text(
            'Create an Account',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          onPressed: () {
            Provider.of<AppStateManager>(context, listen: false).signUpCall();
          },
        ),
      ],
    );
  }

  Widget buildLoginButton(BuildContext context, String action) {
    if (_isLoginButtonTapped) {
      return SizedBox(
        height: 55,
        child: MaterialButton(
          color: Colors.red.withOpacity(0.3),
          onPressed: null,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Column(
            children: const [
              CircularProgressIndicator(),
            ],
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
            _isLoginButtonTapped = true;

            setState(() {
              _isLoginButtonTapped = true;
            });

            final response = await _authClient.loginUser(
              _usernameController.text,
              _passwordController.text,
            );

            if (response.status! < 400) {
              setState(() {
                _isLoginButtonTapped = false;
                _isLoginSuccess = true;
                _isLoginFailure = false;
                _response = response;
              });

              saveLoginTokens(response);

              var login_tokens = await getLoginTokens();

              Provider.of<AppStateManager>(context, listen: false).login(true);
            } else if (response.status! >= 400) {
              setState(() {
                _isLoginButtonTapped = false;
                _isLoginSuccess = false;
                _isLoginFailure = true;
                _response = response;
              });
            }
          },
        ),
      );
    }
  }
}
