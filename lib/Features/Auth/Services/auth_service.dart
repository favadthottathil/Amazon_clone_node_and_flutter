import 'dart:convert';

import 'package:amazon_clone_with_nodejs/Constants/error_handling.dart';
import 'package:amazon_clone_with_nodejs/Constants/global_variables.dart';
import 'package:amazon_clone_with_nodejs/Constants/utilities.dart';
import 'package:amazon_clone_with_nodejs/Features/Home/Screens/home_screen.dart';
import 'package:amazon_clone_with_nodejs/Features/Models/user_model.dart';
import 'package:amazon_clone_with_nodejs/Features/Providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  // sign up user
  signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      UserModel user = UserModel(
        id: '',
        name: name,
        email: email,
        password: password,
        address: '',
        type: '',
        token: '',
      );

      final response = await http.post(
        Uri.parse('$apiEndpoint/api/signup'),
        body: user.toJson(),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8'
        },
      );

      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () {
          showSnackbar(context, 'Account created! successfully');
        },
      );
    } catch (e) {
      showSnackbar(context, e.toString());
    }
  }

  // SIGN IN
  signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      UserModel user = UserModel(
        id: '',
        name: '',
        email: email,
        password: password,
        address: '',
        type: '',
        token: '',
      );

      final response = await http.post(
        Uri.parse('$apiEndpoint/api/signin'),
        body: user.toJson(),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8'
        },
      );

      print(response.body);

      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          Provider.of<UserProvider>(context, listen: false).setUser(response.body);
          await prefs.setString('x-auth-token', jsonDecode(response.body)['token']);
          Navigator.pushNamedAndRemoveUntil(
            context,
            HomeScreen.routName,
            (route) => false,
          );
        },
      );
    } catch (e) {
      showSnackbar(context, e.toString());
    }
  }

  // GET USER DATA
  // SIGN IN
  getUserData({
    required BuildContext context,
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      String? token = prefs.getString('x-auth-token');

      if (token == null) {
        await prefs.setString('x-auth-token', '');
      }

      final tokenResponse = await http.post(
        Uri.parse('$apiEndpoint/tokenIsValid'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token!,
        },
      );

      final bool response = jsonDecode(tokenResponse.body);

      if (response) {

        
        
      }

      // print(response.body);

      // httpErrorHandle(
      //   response: response,
      //   context: context,
      //   onSuccess: () async {
      //     SharedPreferences prefs = await SharedPreferences.getInstance();
      //     Provider.of<UserProvider>(context, listen: false).setUser(response.body);
      //     await prefs.setString('x-auth-token', jsonDecode(response.body)['token']);
      //     Navigator.pushNamedAndRemoveUntil(
      //       context,
      //       HomeScreen.routName,
      //       (route) => false,
      //     );
      //   },
      // );
    } catch (e) {
      showSnackbar(context, e.toString());
    }
  }
}
