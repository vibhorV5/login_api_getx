import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:getx_login_api/Constants/constants.dart';

Future<String> authHeader() async {
  debugPrint("auth header");
  String basicAuth = 'Basic ' +
      base64Encode(utf8.encode('${Constants.username}:${Constants.password}'));
  return basicAuth;
}
