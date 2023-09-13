import 'package:flutter/material.dart';
//
import 'package:liveszczecin/src/init.dart';
import 'package:liveszczecin/src/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializer();
  runApp(const App());
}
