// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:scholarr_mobile_frontend/models/models.dart';
import 'package:scholarr_mobile_frontend/ui/components/components.dart';

import 'package:scholarr_mobile_frontend/models/app_state_manager.dart'
    show AppTab;

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  static MaterialPage page() {
    return MaterialPage(
        name: AppPages.settingsPath,
        key: ValueKey(AppPages.settingsPath),
        child: const SettingsScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
          child: Text(
            'SETTINGS',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      backgroundColor: Colors.transparent,
      body: Center(
        child: SizedBox(
          height: 55,
          width: 200,
          child: MaterialButton(
            color: Colors.red[700],
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Text(
              "LOGOUT",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            onPressed: () async {
              Provider.of<AppStateManager>(context, listen: false).logout();
            },
          ),
        ),
      ),
    );
  }
}
