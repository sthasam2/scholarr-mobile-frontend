import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/models.dart';
import '../../components/components.dart';

class SignUpScreen extends StatelessWidget {
  static MaterialPage page() {
    return MaterialPage(
        name: AppPages.signUpPath,
        key: ValueKey(AppPages.signUpPath),
        child: const SignUpScreen());
  }

  const SignUpScreen({
    Key? key,
    this.username,
    this.email,
  }) : super(key: key);

  final String? username;
  final String? email;

  final Color rwColor = const Color.fromARGB(255, 23, 197, 224);
  final TextStyle focusedStyle = const TextStyle(color: Colors.blue);
  final TextStyle unfocusedStyle = const TextStyle(color: Colors.grey);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: const Text(''),
        leading: GestureDetector(
          child: const Icon(
            Icons.arrow_back_rounded,
            size: 35,
          ),
          onTap: () {
            Provider.of<AppStateManager>(context, listen: false)
                .goToAuthPage(0);
            Navigator.pop(context, true);
          },
        ),
      ),
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
                            "SIGN UP",
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
                  buildTextField(
                    email ?? 'Email',
                    const Icon(Icons.email_rounded),
                    context,
                    false,
                  ),
                  const SizedBox(height: 20),
                  buildTextField('Password', const Icon(Icons.password_rounded),
                      context, true),
                  const SizedBox(height: 40),
                  buildSignUpButton(context, "SIGN UP"),
                  buildLoginButton(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // TODO login page call

  Widget buildLoginButton(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MaterialButton(
          padding: const EdgeInsets.all(10),
          child: Text(
            'Back to Login',
            style: Theme.of(context).textTheme.headline3,
          ),
          onPressed: () {
            Navigator.pop(context, true);
          },
        ),
      ],
    );
  }

  Widget buildSignUpButton(BuildContext context, String action) {
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
              .signUp('mockUsername', 'mockEmail', 'mockPassword');
        },
      ),
    );
  }
}
