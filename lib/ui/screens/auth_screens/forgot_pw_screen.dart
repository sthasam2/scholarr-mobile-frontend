import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:scholarr_mobile_frontend/ui/components/components.dart';
import 'package:scholarr_mobile_frontend/models/models.dart';

class ForgotPasswordScreen extends StatelessWidget {
  static MaterialPage page() {
    return MaterialPage(
        name: AppPages.forgotPwPath,
        key: ValueKey(AppPages.forgotPwPath),
        child: const ForgotPasswordScreen());
  }

  const ForgotPasswordScreen({
    Key? key,
    this.email,
  }) : super(key: key);

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
        //     child: const Icon(
        //       Icons.arrow_back_rounded,
        //       size: 30,
        //     ),
        //     onTap: () {
        //       Provider.of<AppStateManager>(context, listen: false)
        //           .goToAuthPage(0);

        //       Navigator.pop(context, true);
        //     }),
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
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 120,
                          child: Expanded(
                            child: Text(
                              "FORGOT\nPASSWORD",
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.headlineLarge,
                            ),
                          ),
                        ),
                      ]),
                  const SizedBox(height: 20),
                  alertInfoBox(
                      "Recieve an email for resetting password. Use previously registered email"),
                  const SizedBox(height: 20),
                  buildTextField(
                    email ?? 'Email',
                    const Icon(Icons.email_rounded),
                    context,
                    false,
                  ),
                  // buildForgotPwButton(context),
                  const SizedBox(height: 40),
                  buildButton(context, "SEND EMAIL"),
                  buildResetPasswordButton(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildResetPasswordButton(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MaterialButton(
          padding: const EdgeInsets.all(10),
          child: Text(
            'Already received Email?',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          onPressed: () {
            Provider.of<AppStateManager>(context, listen: false)
                .goToAuthPage(3);
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
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        onPressed: null,
        // () async {
        //   Provider.of<AppStateManager>(context, listen: false).login(true);
        // },
      ),
    );
  }
}
