import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/models.dart';
import '../../components/components.dart';

class LoginScreen extends StatelessWidget {
  static MaterialPage page() {
    return MaterialPage(
        name: AppPages.loginPath,
        key: ValueKey(AppPages.loginPath),
        child: const LoginScreen());
  }

  const LoginScreen({
    Key? key,
    this.username,
  }) : super(key: key);

  final String? username;

  final Color rwColor = const Color.fromARGB(255, 23, 197, 224);
  final TextStyle focusedStyle = const TextStyle(color: Colors.blue);
  final TextStyle unfocusedStyle = const TextStyle(color: Colors.grey);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(40, 60, 40, 10),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 120,
                          child: Text(
                            "LOGIN",
                            style: Theme.of(context).textTheme.displayLarge,
                          ),
                        ),
                      ]),
                  const SizedBox(height: 20),
                  buildTextField(
                    username ?? 'Username',
                    const Icon(Icons.alternate_email_rounded),
                    context,
                    false,
                  ),
                  const SizedBox(height: 20),
                  buildTextField('Password', const Icon(Icons.password_rounded),
                      context, true),
                  buildForgotPwButton(context),
                  const SizedBox(height: 40),
                  buildButton(context, "LOGIN"),
                  buildRegisterButton(context),
                ],
              ),
            ),
          ),
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
            style: Theme.of(context).textTheme.headline3,
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
            style: Theme.of(context).textTheme.headline3,
          ),
          onPressed: () {
            Provider.of<AppStateManager>(context, listen: false).signUpCall();
          },
        ),
      ],
    );
  }

  Widget buildButton(BuildContext context, String action) {
    return SizedBox(
      height: 55,
      child: MaterialButton(
        color: Colors.red[700],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Text(
          action,
          style: Theme.of(context).textTheme.bodyText1,
        ),
        onPressed: () async {
          Provider.of<AppStateManager>(context, listen: false)
              .login('mockUsername', 'mockPassword');
        },
      ),
    );
  }
}
