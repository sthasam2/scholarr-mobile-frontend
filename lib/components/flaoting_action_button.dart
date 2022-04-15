import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:scholarr_mobile_frontend/models/models.dart';

Widget buildMenuFloatingActionButton(context, child, menuToggle) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
    child: FloatingActionButton(
      backgroundColor: Color.fromRGBO(255, 255, 255, 0.15),
      elevation: 2,
      child: child,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      onPressed: () {
        Provider.of<AppStateManager>(context, listen: false)
            .showMenu(menuToggle);
      },
    ),
  );
}
