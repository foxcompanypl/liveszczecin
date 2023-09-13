import 'package:flutter/material.dart';
//
import 'package:liveszczecin/src/screens/home_screen.dart';
import 'package:liveszczecin/src/screens/camera_screen.dart';
import 'package:liveszczecin/src/screens/about_screen.dart';
//
import 'package:liveszczecin/src/models/camera_model.dart';

Widget makeRoute(
    {required BuildContext context, String? routeName, Object? arguments}) {
  return _buildRoute(
      context: context, routeName: routeName, arguments: arguments);
}

Widget _buildRoute({
  required BuildContext context,
  String? routeName,
  Object? arguments,
}) {
  switch (routeName) {
    case '/':
      return const HomeScreen();
    case '/camera':
      return CameraScreen(camera: arguments as CameraModel);
    case '/about':
      return const AboutScreen();
    default:
      throw 'Route $routeName is not defined';
  }
}
