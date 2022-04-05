import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/models.dart';
import '../../components/components.dart';

class ResetPasswordScreen extends StatelessWidget {
  static MaterialPage page() {
    return MaterialPage(
        name: AppPages.resetPwPath,
        key: ValueKey(AppPages.resetPwPath),
        child: const ResetPasswordScreen());
  }

  const ResetPasswordScreen({
    Key? key,
    this.email,
    this.token,
  }) : super(key: key);

  final String? email;
  final String? token;

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
              Navigator.pop(context, true);
            }),
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
                            "RESET\nPASSWORD",
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.displayLarge,
                          ),
                        ),
                      ]),
                  const SizedBox(height: 20),
                  alertInfoBox(
                      "Use `token`, registered email, and a new password to reset password"),
                  const SizedBox(height: 20),
                  buildTextField(
                    token ?? 'Token from Email',
                    const Icon(Icons.code_rounded),
                    context,
                    false,
                  ),
                  const SizedBox(height: 20),
                  buildTextField(
                    email ?? 'Registered Email',
                    const Icon(Icons.email_rounded),
                    context,
                    false,
                  ),
                  const SizedBox(height: 20),
                  buildTextField(
                    'New Password',
                    const Icon(Icons.password_rounded),
                    context,
                    true,
                  ),
                  const SizedBox(height: 40),
                  buildButton(context, "RESET PASSWORD"),
                ],
              ),
            ),
          ),
        ],
      ),
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
