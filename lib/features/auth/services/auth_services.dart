// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:ashewa_apps_with_nodejs/common/widgets/error_handling.dart';
import 'package:ashewa_apps_with_nodejs/common/widgets/utils.dart';
import 'package:ashewa_apps_with_nodejs/constants/global_varible.dart';
import 'package:ashewa_apps_with_nodejs/features/Home/screens/home_screen.dart';
import 'package:ashewa_apps_with_nodejs/model/user_model.dart';
import 'package:ashewa_apps_with_nodejs/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  // signin
  void signupUser({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      User user = User(
          id: '',
          name: name,
          email: email,
          password: password,
          address: '',
          type: '',
          token: '');
      http.Response res = await http.post(
        Uri.parse("$url/api/signup"),
        body: user.toJson(),
        headers: <String, String>{
          'content-Type': 'application/json; charset=UTF-8'
        },
      );
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            showSnackBars(
                context, 'Account Created! Login with same credentials!');
          });
    } catch (e) {
      print(e);
      showSnackBars(context, e.toString());
    }
  }

  // sign in user
  void signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$url/api/signin'),
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      print(res.body);
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          Provider.of<UserProvider>(context, listen: false).setUser(res.body);
          await prefs.setString('x-auth-token', jsonDecode(res.body)['token']);
          Navigator.pushNamed(
            context,
            HomePage.routName,
            // (route) => false,
          );
          print('object');
        },
      );
    } catch (e) {
      showSnackBars(context, e.toString());
    }
  }

  // get user data
  Future<void> getUserData(
    BuildContext context,
  ) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      if (token == null) {
        prefs.setString('x-auth-token', '');
      }

      var tokenRes = await http.post(
        Uri.parse('$url/tokenIsValid'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token!
        },
      );

      var response = jsonDecode(tokenRes.body);

      if (response == true) {
        http.Response userRes = await http.get(
          Uri.parse('$url/'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token
          },
        );

        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUser(userRes.body);
      }
    } catch (e) {
      showSnackBars(context, e.toString());
    }
  }
}
