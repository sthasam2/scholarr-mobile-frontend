import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget alertInfoBox(String message) {
  return Card(
    color: const Color.fromARGB(86, 95, 191, 242),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
    child: Padding(
      padding: EdgeInsets.all(10),
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