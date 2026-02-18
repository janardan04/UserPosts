import 'dart:convert';
import 'dart:core';

import 'package:api_learning/features/user/adduser/model/AddUserModel.dart';
import 'package:api_learning/features/user/list/model/user_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final http.Client client;

  const ApiService({required this.client});

  final uri = 'https://gorest.co.in/public/v2/users';

  Future<List<Usermodel>> getDetails() async {
    var response = await client.get(
      Uri.parse(uri),
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer 1eb84e67c9c0951a86210e990658c286d499e798fc576d08b9d4d0cccfe42326',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> user = jsonDecode(response.body);
      return user.map<Usermodel>((e) => Usermodel.fromJson(e)).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<Addusermodel> addUser(Addusermodel user) async {
    var response = await client.post(
      Uri.parse(uri),
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer 1eb84e67c9c0951a86210e990658c286d499e798fc576d08b9d4d0cccfe42326',
      },
      body: jsonEncode(user.toJson()),
    );
    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      return Addusermodel.fromJson(data);
    } else {
      throw Exception("Failed to create user : ${response.body}");
    }
  }

  Future<Addusermodel> editUser(int id, Addusermodel user) async {
    var response = await client.put(
      Uri.parse('https://gorest.co.in/public/v2/users/$id'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer 1eb84e67c9c0951a86210e990658c286d499e798fc576d08b9d4d0cccfe42326',
      },
      body: jsonEncode(user.toJson()),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return Addusermodel.fromJson(data);
    } else {
      throw Exception('Failed To Edit${response.reasonPhrase}');
    }
  }

  Future<dynamic> deleteUser(int id) async {
    var response = await client.delete(
      Uri.parse('https://gorest.co.in/public/v2/users/$id'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer 1eb84e67c9c0951a86210e990658c286d499e798fc576d08b9d4d0cccfe42326',
      },
    );
    if (response.statusCode == 204) {
      return "User Deleted Successfully";
    } else {
      throw Exception('Failed to delete${response.reasonPhrase}');
    }
  }
}
