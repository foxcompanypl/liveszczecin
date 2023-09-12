import 'package:flutter/material.dart';

final GlobalKey<ScaffoldMessengerState> snackbarKey =
    GlobalKey<ScaffoldMessengerState>();

void showSnack(String text) {
  final SnackBar snackBar = SnackBar(content: Text(text));
  snackbarKey.currentState?.showSnackBar(snackBar);
}
