import 'package:flutter/material.dart';
import 'routes.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'LiveSzczecin',
        theme: ThemeData.light(useMaterial3: true).copyWith(
            appBarTheme: AppBarTheme(
                color: Colors.blue.shade200,
                surfaceTintColor: Colors.transparent)),
        darkTheme: ThemeData.dark(useMaterial3: true).copyWith(
            appBarTheme: const AppBarTheme(
                color: Colors.black, surfaceTintColor: Colors.transparent)),
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
