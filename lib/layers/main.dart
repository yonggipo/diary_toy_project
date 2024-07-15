import 'package:flutter/material.dart';

import 'presentation/app_root.dart';
import 'presentation/injector.dart';

void main() async {
  await initializeGetIt();
  runApp(const AppRoot());
}
