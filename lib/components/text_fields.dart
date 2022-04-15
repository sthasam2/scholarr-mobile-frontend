import 'package:flutter/material.dart';

import '../theme.dart';

Widget buildTextField(
    String hintText, Icon icon, BuildContext context, bool obscureText) {
  return TextField(
    obscureText: obscureText,
    enableSuggestions: !obscureText,
    autocorrect: !obscureText,
    style: Theme.of(context).textTheme.bodyText1,
    cursorColor: selectionColor,
    decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(20.0),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.blue,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        filled: true,
        fillColor: const Color.fromARGB(100, 113, 113, 113),
        focusColor: const Color.fromARGB(255, 113, 113, 113),
        hintText: hintText,
        hintStyle: const TextStyle(height: 1),
        prefixIcon: icon),
  );
}

textField(
  BuildContext context,
  Icon icon,
  String hintText,
  bool obscureText,
  TextEditingController controller,
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(5, 0, 0, 10),
        child: Text(
          hintText.toUpperCase(),
          style: Theme.of(context).textTheme.labelMedium,
        ),
      ),
      TextField(
        obscureText: obscureText,
        enableSuggestions: !obscureText,
        autocorrect: !obscureText,
        style: Theme.of(context).textTheme.bodyText2,
        cursorColor: selectionColor,
        controller: controller,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(20.0),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(15),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.blue,
                style: BorderStyle.solid,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            filled: true,
            fillColor: const Color.fromARGB(100, 113, 113, 113),
            focusColor: const Color.fromARGB(255, 113, 113, 113),
            hintText: hintText,
            hintStyle: const TextStyle(height: 1),
            prefixIcon: icon),
      ),
    ],
  );
}
