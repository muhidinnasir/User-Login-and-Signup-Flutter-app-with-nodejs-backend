import 'package:ashewa_apps_with_nodejs/constants/global_varible.dart';
import 'package:ashewa_apps_with_nodejs/features/Home/screens/home_screen.dart';
import 'package:ashewa_apps_with_nodejs/features/auth/auth_screean.dart';
import 'package:ashewa_apps_with_nodejs/model/user_model.dart';
import 'package:ashewa_apps_with_nodejs/providers/user_provider.dart';
import 'package:ashewa_apps_with_nodejs/router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'features/auth/services/auth_services.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  final AuthService authService = AuthService();
  final _messangerKey = GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    authService.getUserData(context);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: _messangerKey,
      title: 'Ashewa.com Full-Stack Flutter project Apps',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: GlobalVirable.backgroundColor,
        colorScheme: const ColorScheme.light(
          primary: GlobalVirable.secondaryColor,
        ),
        appBarTheme: const AppBarTheme(
          elevation: 0,
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      onGenerateRoute: (settings) => generateRoute(settings),
      home: Builder(builder: (context) {
        return FutureBuilder(
          future: authService.getUserData(context),
          builder: (context, snapshot) {
            // if (snapshot.connectionState == ConnectionState.done) {
            return Provider.of<UserProvider>(context).user.token.isNotEmpty
                ? const HomePage()
                : const AuthScreen();
            // }
            // return const Center(child: CircularProgressIndicator());
          },
        );
      }),
    );
  }
}
