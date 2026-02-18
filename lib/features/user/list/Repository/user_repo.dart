import 'dart:convert';

import 'package:api_learning/features/user/list/api/api_service.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

import '../model/user_model.dart';

class UserRepo {
  final ApiService _apiService;

  UserRepo({ApiService? apiService})
    : _apiService = apiService ?? ApiService(client: http.Client());

  Future<List<Usermodel>> getDetails() async {
    return await _apiService.getDetails();
  }
}
