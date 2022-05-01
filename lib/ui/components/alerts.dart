import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

Widget alertInfoBox(String message) {
  return Card(
    color: const Color.fromARGB(86, 95, 191, 242),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
    child: Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Icon(Icons.info_outline, color: Colors.blue.withOpacity(0.8)),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              message,
              style: GoogleFonts.montserrat(
                  color: Colors.blue.withOpacity(0.8),
                  fontSize: 14,
                  fontWeight: FontWeight.w400),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget successInfoBox(BuildContext context, String title, String message) {
  Color _foregroundColor = Colors.green.withOpacity(0.8);
  Color _backgroundColor = Colors.green.withOpacity(0.2);

  return Card(
    color: _backgroundColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
    child: Container(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Icon(Icons.done, color: _foregroundColor),
            const SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.montserrat(
                        color: _foregroundColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    message,
                    style: GoogleFonts.montserrat(
                        color: _foregroundColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
          ],
        )),
  );
}

Widget errorInfoBox(BuildContext context, String title, dynamic message) {
  Color _foregroundColor = Colors.red.withOpacity(0.8);
  Color _backgroundColor = Colors.red.withOpacity(0.2);

  var converted_message;
  if (message is Map) {
    converted_message = jsonEncode(message);
  } else if (message is String) {
    converted_message = message;
  }

  return Card(
    color: _backgroundColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
    child: Container(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Icon(Icons.warning, color: _foregroundColor),
            const SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.montserrat(
                        color: _foregroundColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    converted_message,
                    style: GoogleFonts.montserrat(
                        color: _foregroundColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
          ],
        )),
  );
}
