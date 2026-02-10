import 'dart:convert';

import 'package:api_learning/features/user/list/model/user_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<Usermodel?> getDetails() async {
    var uri = 'https://dummyjson.com/users';
    var response = await http.get(Uri.parse(uri));

    if (response.statusCode == 200) {
      Usermodel user = Usermodel.fromJson(jsonDecode(response.body));
      return user;
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
