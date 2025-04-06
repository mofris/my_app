import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_app/models/user_models.dart';
import 'package:http/http.dart' as http;

class AuthProvider with ChangeNotifier {
  Future<UserModel?> login(String email, String password) async {
    try {
      var body = jsonEncode({
        'email': email,
        'password': password,
      });

      var response = await http.post(
        // Uri.parse('http://10.9.193.38/api/login'),
        Uri.parse('http://192.168.8.108/api/login'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: body,
      );

      // print('Status Code: ${response.statusCode}');
      // print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        // Ambil bagian "data" dari response
        var userData = data['data']['user'];

        // Tambahkan access_token & token_type ke user model
        // userData['access_token'] = data['data']['access_token'];
        // userData['token_type'] = data['data']['token_type'];

        return UserModel.fromJson(userData);
      } else {
        return null;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }
}
