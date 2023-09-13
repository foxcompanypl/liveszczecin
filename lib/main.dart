import 'package:flutter/material.dart';
import 'src/init.dart';
import 'src/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializer();
  runApp(const App());
}
