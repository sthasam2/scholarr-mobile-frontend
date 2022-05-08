import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:scholarr_mobile_frontend/models/models.dart';

Widget backButton(context) {
  return SizedBox(
    height: 55,
    width: 55,
    child: MaterialButton(
      color: Color.fromRGBO(255, 255, 255, 0.3),
      elevation: 2,
      child: const Icon(Icons.arrow_back_rounded),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(23),
      ),
      onPressed: () {
        Provider.of<AppStateManager>(context, listen: false)
            .goToTab(AppTab.home);
        Navigator.pop(context, true);
      },
    ),
  );
}
