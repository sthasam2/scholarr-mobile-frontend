import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:scholarr_mobile_frontend/models/models.dart';

Widget buildMenuFloatingActionButton(context, child, onPressToggleMenu) {
  return FloatingActionButton(
    backgroundColor: Color.fromRGBO(255, 255, 255, 0.3),
    elevation: 2,
    child: child,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(23),
    ),
    onPressed: () {
      Provider.of<AppStateManager>(context, listen: false)
          .showMenu(onPressToggleMenu);
    },
  );
}
