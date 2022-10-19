import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_login_api/Constants/constants.dart';
import 'package:getx_login_api/Screens/Home/View/home_screen.dart';
import 'package:getx_login_api/Services/Auth/basic_auth.dart';
import 'package:http/http.dart' as http;

class LoginController extends GetxController {
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool loginStatus = false;

  var email = '';
  var password = '';

  @override
  void onClose() {
    super.onClose();
    emailController.dispose();
    passwordController.dispose();
    loginStatus = false;
  }

  String? emailValidate(String value) {
    if (!GetUtils.isEmail(value)) {
      return 'Enter a valid email id';
    } else {
      return null;
    }
  }

  String? passwordValidate(String value) {
    if (value.length < 8) {
      return 'Password length should be at least 8 characters';
    } else {
      return null;
    }
  }

  Future<dynamic> loginUserOnServer(
      emailId, password, deviceId, deviceVersion) async {
    try {
      print('loginUser');
      print(emailId);
      var basicAuth = await authHeader();
      var url = Uri.parse('${Constants.baseUrl}${Constants.login}');
      var response = await http.post(url, headers: <String, String>{
        'authorization': basicAuth,
        'Accept-Language': Constants.acceptedLanguage,
        'platform': Platform.operatingSystem,
        'version': deviceVersion,
        'device-id': deviceId
      }, body: {
        'email': emailId,
        'password': password,
        'country_id': Constants.countryId,
      });
      // print(response);
      return response;
    } catch (e) {
      print(e);
      return ' ';
    }
  }

  Future<void> loginUser() async {
    final isValid = loginFormKey.currentState!.validate();
    if (!isValid) {
      loginStatus = false;
      print('Invalid Form');
      return;
    } else {
      print("Form is Valid");
      loginFormKey.currentState!.save();
      final response = await loginUserOnServer(
          email, password, Constants.deviceId, Constants.deviceVersion);
      print("resposne  = ${response.body}");

      if (response == " ") {
        Get.back();
        Get.snackbar("Login Error", "Something went wrong, try again",
            backgroundColor: Colors.red.withOpacity(0.4));
        // customSnackBar(Constants.connectionFailed,Constants.checkInternetConnection);
      } else if (response.statusCode == 200) {
        Map mapdata = jsonDecode(response.body.toString());
        if (mapdata['success'] == '0') {
          Get.snackbar("Login Error", "Something went wrong, try again",
              backgroundColor: Colors.red.withOpacity(0.4));
          // customSnackBar(Constants.pleaseTryAgain, mapdata['message']);
        } else if (response.statusCode == 200) {
          print(response);
          Map mapdata = jsonDecode(response.body.toString());
          if (mapdata['success'] == '1') {
            Get.snackbar("Login Success", "Welcome",
                backgroundColor: Colors.green.withOpacity(0.4));
            Get.to(() => const HomeScreen());
            // customSnackBar(Constants.pleaseTryAgain, mapdata['message']);
          } else {
            return;
          }
          // loginStatus = true;
        }
      }
    }
  }
}
