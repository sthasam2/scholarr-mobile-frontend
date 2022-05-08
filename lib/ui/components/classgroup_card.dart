import 'package:flutter/material.dart';

import 'package:scholarr_mobile_frontend/models/models.dart';

Widget ClassGroupCard(BuildContext context, ClassGroupItem classgroup) {
  return Card(
    elevation: 2.0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
    child: SizedBox(
      height: 120,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () {
          debugPrint("card tapped");
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(25.0, 10, 25, 10),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  classgroup.name,
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center,
                ),
                Spacer(),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today_rounded,
                      size: 16,
                    ),
                    SizedBox(width: 5),
                    Text(
                      classgroup.batch,
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ],
                ),
                SizedBox(width: 50),
                Row(
                  children: [
                    Icon(
                      Icons.school_rounded,
                      size: 16,
                    ),
                    SizedBox(width: 5),
                    Text(
                      classgroup.faculty,
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.business_rounded,
                      size: 16,
                    ),
                    SizedBox(width: 5),
                    Text(
                      classgroup.organisation,
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
