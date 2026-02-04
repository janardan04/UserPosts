import 'package:api_learning/homepage.dart';
import 'package:flutter/material.dart';
void main(){
  runApp(MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _api_fetchState();
}

class _api_fetchState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title:Center(child: const Text("API Fetching")),),
        body: Homepage(),
      ),
    );
  }
}