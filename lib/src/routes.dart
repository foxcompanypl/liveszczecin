import 'package:flutter/material.dart';
import 'models/camera_model.dart';
import 'widgets/home_widget.dart';
import 'widgets/camera_widget.dart';

Widget makeRoute(
    {required BuildContext context, String? routeName, Object? arguments}) {
  final Widget child =
      _buildRoute(context: context, routeName: routeName, arguments: arguments);
  return child;
}

Widget _buildRoute({
  required BuildContext context,
  String? routeName,
  Object? arguments,
}) {
  switch (routeName) {
    case '/':
      return HomeWidget();
    case '/camera':
      return CameraWidget(camera: arguments as CameraModel);
    default:
      throw 'Route $routeName is not defined';
  }
}
