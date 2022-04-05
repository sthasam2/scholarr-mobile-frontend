import 'package:flutter/material.dart';

Widget buildMenuCard(
    BuildContext context, ImageProvider imageProvider, String label) {
  return Card(
    elevation: 2.0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    child: InkWell(
      splashColor: Colors.blue.withAlpha(30),
      onTap: () {
        debugPrint('Card tapped.');
      },
      child: SizedBox(
        width: 145,
        height: 145,
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
                style: Theme.of(context).textTheme.headline3,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
