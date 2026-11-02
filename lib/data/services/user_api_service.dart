import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:learn_flutter/data/models/user.dart';

class UserApiService {
  final String baseUrl = 'https://fake-json-api.mock.beeceptor.com/users';
  final http.Client client; 

  UserApiService({required this.client});

  Future<List<User>> fetchUsers() async {
    final response = await client.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);
      return jsonData.map((json) => User.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }
}