import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:scholarr_mobile_frontend/models/models.dart';
import 'package:scholarr_mobile_frontend/ui/components/components.dart';

class EmptyClassroomScreen extends StatelessWidget {
  final ClassroomManager manager;

  const EmptyClassroomScreen({
    Key? key,
    required this.manager,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 1
    return RefreshIndicator(
      onRefresh: () async {
        manager.setClassroomItems();
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(40, 0, 40, 10),
        // 2
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: AspectRatio(
                aspectRatio: 1 / 1,
                child: Image.asset(
                  'assets/classroom_assets/empty_classroom.png',
                  color: Colors.white.withOpacity(0.5),
                  colorBlendMode: BlendMode.modulate,
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            Text(
              'NO CLASSGROUPS',
              style: Theme.of(context).textTheme.labelLarge,
              textAlign: TextAlign.center,
            ),
            Text(
              'Create or join a classroom',
              style: Theme.of(context).textTheme.labelMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
