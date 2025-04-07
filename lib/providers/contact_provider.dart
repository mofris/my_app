import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_app/models/contact_model.dart';
import 'package:http/http.dart' as http;

class ContactProvider with ChangeNotifier {
  Future<List<ContactModel>> getContacts() async {
    try {
      var response = await http.get(
        // Uri.parse('http://10.9.193.38/api/contact'),
        // Uri.parse('http://192.168.8.108/api/contact'),
        Uri.parse('https://my-app.daisysunday.site/api/contact'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      // print('Status Code: ${response.statusCode}');
      // print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        // Ambil data dari response body
        var data = jsonDecode(response.body);

        // Ambil bagian "data" dari response
        var dataContact = data['data'];

        List<ContactModel> contacts = [];
        List parsedJson = dataContact;

        parsedJson.forEach((data) {
          contacts.add(ContactModel.fromJson(data));
        });

        return contacts;
      } else {
        return [];
      }
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }

  Future<bool> addContact(String name, String number) async {
    try {
      final response = await http.post(
        // Uri.parse('http://192.168.8.108/api/contact/created'),
        Uri.parse('https://my-app.daisysunday.site/api/contact/created'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'name': name,
          'number': number,
        }),
      );

      // print('Response add: ${response.body}');

      if (response.statusCode == 201) {
        notifyListeners(); // agar UI bisa refresh jika perlu
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }

  Future<bool> updateContact(int id, String name, String number) async {
    try {
      final response = await http.put(
        Uri.parse('https://my-app.daisysunday.site/api/contact/update/$id'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'name': name,
          'number': number,
        }),
      );

      print('Response update: ${response.body}');

      if (response.statusCode == 200) {
        notifyListeners();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }

  Future<bool> deleteContact(int id) async {
    try {
      var response = await http.delete(
        Uri.parse('https://my-app.daisysunday.site/api/contact/$id'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      // print('Status Code (DELETE): ${response.statusCode}');
      // print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        notifyListeners(); // agar UI bisa refresh jika perlu
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }
}
