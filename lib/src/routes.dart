import 'package:flutter/material.dart';
//
import 'widgets/home_widget.dart';
import 'widgets/camera_widget.dart';
import 'widgets/about_widget.dart';
//
import 'models/camera_model.dart';

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
      return const HomeWidget();
    case '/camera':
      return CameraWidget(camera: arguments as CameraModel);
    case '/about':
      return const AboutWidget();
    default:
      throw 'Route $routeName is not defined';
  }
}
