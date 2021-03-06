// ignore_for_file: unused_field

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'package:scholarr_mobile_frontend/data/data.dart';
import 'package:scholarr_mobile_frontend/models/models.dart';
import 'package:scholarr_mobile_frontend/ui/components/components.dart';

class SignUpScreen extends StatefulWidget {
  final String? username;
  final String? email;
  final String? password;

  const SignUpScreen({
    Key? key,
    this.username,
    this.email,
    this.password,
  }) : super(key: key);

  static MaterialPage page() {
    return MaterialPage(
        name: AppPages.signUpPath,
        key: ValueKey(AppPages.signUpPath),
        child: const SignUpScreen());
  }

  @override
  State<SignUpScreen> createState() => SignUpScreenState();
}

class SignUpScreenState extends State<SignUpScreen> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final AuthClient _authClient = AuthClient();
  final _client = http.Client();

  bool _isSignUpButtonTapped = false;

  var _isSignUpSuccess = false;
  var _isSignUpFailure = false;
  var _response = null;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
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
              Provider.of<AppStateManager>(context, listen: false)
                  .goToAuthPage(0);
              Navigator.pop(context, true);
            }),
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
                    "SIGN UP",
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                ),
              ]),
          _response != null && _isSignUpSuccess
              ? successInfoBox(
                  context,
                  _response.success["message"],
                  _response.success["verbose"],
                )
              : Container(),
          _response != null && _isSignUpFailure
              ? errorInfoBox(
                  context,
                  _response.error["message"],
                  _response.error["verbose"],
                )
              : Container(),
          const SizedBox(height: 20),
          textField(
            context,
            Icons.account_circle_rounded,
            'Username',
            false,
            _usernameController,
            TextInputType.name,
          ),
          const SizedBox(height: 20),
          textField(
            context,
            Icons.email_rounded,
            'Email',
            false,
            _emailController,
            TextInputType.emailAddress,
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
          const SizedBox(height: 40),
          buildSignUpButton(context, "SIGN UP"),
          buildLoginButton(context),
        ],
      ),
    );
  }

  Widget buildLoginButton(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MaterialButton(
          padding: const EdgeInsets.all(10),
          child: Text(
            'Back to Login',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          onPressed: () {
            Navigator.pop(context, true);
          },
        ),
      ],
    );
  }

  Widget buildSignUpButton(BuildContext context, String action) {
    if (_isSignUpButtonTapped) {
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
            // Provider.of<AppStateManager>(context, listen: false).signUp(
            //     _usernameController.text,
            //     _emailController.text,
            //     _passwordController.text);
            _isSignUpButtonTapped = true;

            setState(() {
              _isSignUpButtonTapped = true;
            });

            final response = await _authClient.registerUser(
              _usernameController.text,
              _emailController.text,
              _passwordController.text,
            );

            if (response.status! < 400) {
              setState(() {
                _isSignUpButtonTapped = false;
                _isSignUpSuccess = true;
                _isSignUpFailure = false;
                _response = response;
              });
            } else if (response.status! >= 400) {
              setState(() {
                _isSignUpButtonTapped = false;
                _isSignUpSuccess = false;
                _isSignUpFailure = true;
                _response = response;
              });
            }
          },
        ),
      );
    }
  }
}
