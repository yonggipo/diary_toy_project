import 'package:flutter/material.dart';

import 'presentation/app_root.dart';
import 'application/injector.dart';

void main() async {
  await initializeGetIt();
  runApp(const AppRoot());
}
