import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:solana_wallet/constants.dart';
import 'dart:convert';

import '../models/User.dart';
import 'shared_preferences_helper.dart';

class AuthProvider with ChangeNotifier {
  User? _user;

  User? get user => _user;

  Future<void> login(String username, String password) async {
    print(username+password);
    final url = Uri.parse('$baseUri/user/login'); 
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'mixed': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      print(responseData);
      _user = User.fromJson(responseData);
      await SharedPreferencesHelper.setToken(_user!.token);
      notifyListeners();
    } else {
      throw Exception('Failed to login');
    }
  }
}
