import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:scholarr_mobile_frontend/models/models.dart';
import 'package:scholarr_mobile_frontend/navigator/app_router.dart';
import 'package:scholarr_mobile_frontend/ui/theme.dart';

void main() {
  runApp(const App());
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final _appStateManager = AppStateManager();
  final _classgroupManager = ClassgroupManager();
  final _classroomManager = ClassroomManager();
  final _classroomContentManager = ClasscontentManager();
  late AppRouter _appRouter;

  @override
  void initState() {
    super.initState();
    _appRouter = AppRouter(
        appStateManager: _appStateManager,
        classgroupManager: _classgroupManager,
        classroomManager: _classroomManager,
        classroomContentManager: _classroomContentManager);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => _appStateManager),
        ChangeNotifierProvider(create: (context) => _classgroupManager),
        ChangeNotifierProvider(create: (context) => _classroomManager),
        ChangeNotifierProvider(create: (context) => _classroomContentManager)
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.dark(),
          title: "Scholarr Mobile",
          home: Router(
            routerDelegate: _appRouter,
            backButtonDispatcher: RootBackButtonDispatcher(),
          )),
    );
  }
}
