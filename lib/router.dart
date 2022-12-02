import 'package:ashewa_apps_with_nodejs/features/Home/screens/home_screen.dart';
import 'package:ashewa_apps_with_nodejs/features/auth/auth_screean.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case AuthScreen.routName:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const AuthScreen(),
      );
    case HomePage.routName:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const HomePage(),
      );
    default:
      return MaterialPageRoute(
          settings: settings,
          builder: (_) => const Scaffold(
                body: Center(
                  child: Text('Screen does not exist'),
                ),
              ));
  }
}
