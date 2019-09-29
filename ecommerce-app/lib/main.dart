// Another template for listing products
// Card listings: https://codelabs.developers.google.com/codelabs/mdc-102-flutter/#5
// How to make the app super pretty: https://codelabs.developers.google.com/codelabs/mdc-103-flutter/#0
// How to make the app even prettier: https://codelabs.developers.google.com/codelabs/mdc-104-flutter/#7 

// State management 101
// https://flutter.dev/docs/development/data-and-backend/state-mgmt/intro

// App routing 101
// https://flutter.dev/docs/development/ui/navigation

// Widget components 101
// https://flutter.dev/docs/development/ui/widgets

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';

import 'login.dart';
import 'cupertinoStore.dart';
import 'model/app_state_model.dart';

// TODO: Convert ShrineApp to stateful widget (104)
class ShrineApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Up-Cycle',
      // TODO: Change home: to a Backdrop with a HomePage frontLayer (104)
      home: CupertinoStoreHomePage(),
      // TODO: Make currentCategory field take _currentCategory (104)
      // TODO: Pass _currentCategory for frontLayer (104)
      // TODO: Change backLayer field value to CategoryMenuPage (104)
      initialRoute: '/login',
      onGenerateRoute: _getRoute,
      // TODO: Add a theme (103)
    );
  }

  Route<dynamic> _getRoute(RouteSettings settings) {
    if (settings.name != '/login') {
      return null;
    }

    return MaterialPageRoute<void>(
      settings: settings,
      builder: (BuildContext context) => LoginPage(),
      fullscreenDialog: true,
    );
  }
}

// TODO: Build a Shrine Theme (103)
// TODO: Build a Shrine Text Theme (103)




void main() {
  // This app is designed only to work vertically, so we limit
  // orientations to portrait up and down.
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  return runApp(
    ChangeNotifierProvider<AppStateModel>(
      builder: (context) => AppStateModel()..loadProducts(),
      child: ShrineApp(),
    ),
  );
}
