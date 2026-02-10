import 'dart:convert';
import 'dart:io';

import 'package:api_learning/features/posts/model/postmodel.dart';
import 'package:http/http.dart' as http;

class PostsApi {
  Future<PostModel> getPosts() async {
    final uri =
        'https://pixabay.com/api/?key=52135188-9fc837b6c7c9d50a9cc2cc6e4&q';

    var response = await http.get(Uri.parse(uri));
    if (response.statusCode == 200) {
      final PostModel posts = PostModel.fromJson(jsonDecode(response.body));

      return posts;

      // return posts.map<PostModel>((e) => PostModel.fromJson(e)).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
