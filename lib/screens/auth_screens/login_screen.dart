import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../components/components.dart';
import '../../data/data.dart';
import '../../models/models.dart';
import '../../theme.dart';

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
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(prefLoginAccess, response.access!);
    prefs.setString(prefLoginRefresh, response.refresh!);
    prefs.setBool(prefLoggedIn, true);
  }

  Future<Map<String?, String?>> getLoginTokens() async {
    final prefs = await SharedPreferences.getInstance();

    final String? accessToken = prefs.getString(prefLoginAccess);
    final String? refreshToken = prefs.getString(prefLoginRefresh);

    return {
      "access": accessToken,
      "refresh": refreshToken,
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
        //     size: 35,
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
                    style: Theme.of(context).textTheme.displayLarge,
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
            const Icon(Icons.alternate_email_rounded),
            'Username',
            false,
            _usernameController,
          ),
          const SizedBox(height: 20),
          textField(
            context,
            const Icon(Icons.lock_rounded),
            'Password',
            true,
            _passwordController,
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
            style: Theme.of(context).textTheme.bodyText2,
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
            style: Theme.of(context).textTheme.bodyText2,
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
            style: Theme.of(context).textTheme.bodyText1,
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

// class LoginScreen extends StatelessWidget {
//   static MaterialPage page() {
//     return MaterialPage(
//         name: AppPages.loginPath,
//         key: ValueKey(AppPages.loginPath),
//         child: const LoginScreen());
//   }

//   const LoginScreen({
//     Key? key,
//     this.username,
//   }) : super(key: key);

//   final String? username;

//   final Color rwColor = const Color.fromARGB(255, 23, 197, 224);
//   final TextStyle focusedStyle = const TextStyle(color: Colors.blue);
//   final TextStyle unfocusedStyle = const TextStyle(color: Colors.grey);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: ListView(
//         scrollDirection: Axis.vertical,
//         children: [
//           Padding(
//             padding: const EdgeInsets.fromLTRB(40, 60, 40, 10),
//             child: Center(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Row(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         SizedBox(
//                           height: 120,
//                           child: Text(
//                             "LOGIN",
//                             style: Theme.of(context).textTheme.displayLarge,
//                           ),
//                         ),
//                       ]),
//                   const SizedBox(height: 20),
//                   buildTextField(
//                     username ?? 'Username',
//                     const Icon(Icons.alternate_email_rounded),
//                     context,
//                     false,
//                   ),
//                   const SizedBox(height: 20),
//                   buildTextField('Password', const Icon(Icons.lock_rounded),
//                       context, true),
//                   buildForgotPwButton(context),
//                   const SizedBox(height: 40),
//                   buildButton(context, "LOGIN"),
//                   buildRegisterButton(context),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget buildForgotPwButton(context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         MaterialButton(
//           padding: const EdgeInsets.all(10),
//           child: Text(
//             'Forgot Password?',
//             style: Theme.of(context).textTheme.bodyText2,
//           ),
//           onPressed: () {
//             Provider.of<AppStateManager>(context, listen: false)
//                 .forgotPassword();
//           },
//         ),
//       ],
//     );
//   }

//   Widget buildRegisterButton(context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         MaterialButton(
//           padding: const EdgeInsets.all(10),
//           child: Text(
//             'Create an Account',
//             style: Theme.of(context).textTheme.bodyText2,
//           ),
//           onPressed: () {
//             Provider.of<AppStateManager>(context, listen: false).signUpCall();
//           },
//         ),
//       ],
//     );
//   }

//   Widget buildButton(BuildContext context, String action) {
//     return SizedBox(
//       height: 55,
//       child: MaterialButton(
//         color: Colors.red[700],
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//         child: Text(
//           action,
//           style: Theme.of(context).textTheme.bodyText1,
//         ),
//         onPressed: () async {
//           Provider.of<AppStateManager>(context, listen: false)
//               .login('mockUsername', 'mockPassword');
//         },
//       ),
//     );
//   }
// }
