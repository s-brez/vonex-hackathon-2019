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

import 'app.dart';
import 'model/app_state_model.dart';

void main() {
  // This app is designed only to work vertically, so we limit
  // orientations to portrait up and down.
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  return runApp(
    ChangeNotifierProvider<AppStateModel>(
      builder: (context) => AppStateModel()..loadProducts(),
      child: CupertinoStoreApp(),
    ),
  );
}
