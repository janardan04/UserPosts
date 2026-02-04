import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'user_model.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<User> users = [];

  Future<void> apiCall() async {
    final response = await http.get(
      Uri.parse('https://gorest.co.in/public/v2/users'),
    );

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);

      setState(() {
        users = data.map((e) => User.fromJson(e)).toList();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    apiCall();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(users[index].name),
          subtitle: Text(users[index].email),
        );
      },
    );
  }
}

//bloc listener
//bloc builder
//bloc provider
//buildWhen
//MultiblocProvider
//blocCOnsumer
//cubit
//
