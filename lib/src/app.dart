import 'package:flutter/material.dart';
//
import 'package:liveszczecin/src/routes.dart';
import 'package:liveszczecin/src/globals.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'LiveSzczecin',
        scaffoldMessengerKey: snackbarKey,
        theme: ThemeData.light(useMaterial3: true).copyWith(
            appBarTheme: AppBarTheme(
                color: Colors.blue.shade200, scrolledUnderElevation: 0)),
        darkTheme: ThemeData.dark(useMaterial3: true).copyWith(
            appBarTheme: const AppBarTheme(
                color: Colors.black, scrolledUnderElevation: 0)),
        themeMode: ThemeMode.system,
        onGenerateRoute: (RouteSettings settings) {
          return MaterialPageRoute(
              builder: (BuildContext context) => makeRoute(
                    context: context,
                    routeName: settings.name,
                    arguments: settings.arguments,
                  ));
        });
  }
}
