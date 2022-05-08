import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:scholarr_mobile_frontend/models/app_state_manager.dart';

Widget menuCard(BuildContext context, ImageProvider imageProvider, String label,
    int indexToGoTo) {
  return Card(
    margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
    elevation: 2.0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    child: SizedBox(
      width: 145,
      height: 145,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          debugPrint('Menu Card tapped.');
          Provider.of<AppStateManager>(context, listen: false).showMenu(false);
          Provider.of<AppStateManager>(context, listen: false)
              .goToTab(indexToGoTo);
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(25, 35, 25, 25),
          child: Column(
            children: [
              Image(
                fit: BoxFit.scaleDown,
                height: 45,
                image: imageProvider,
              ),
              const SizedBox(height: 20),
              Text(
                label,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
