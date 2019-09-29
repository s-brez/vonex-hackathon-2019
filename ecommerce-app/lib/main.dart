// Copyright 2019 Google LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     https://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.


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
