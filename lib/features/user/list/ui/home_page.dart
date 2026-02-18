import 'package:api_learning/features/posts/apiService/posts_api.dart';
import 'package:api_learning/features/posts/bloc/posts_bloc.dart';
import 'package:api_learning/features/posts/ui/post_homepage.dart';
import 'package:api_learning/features/user/list/api/api_service.dart';
import 'package:api_learning/features/user/list/bloc/user_bloc.dart';
import 'package:api_learning/features/user/list/bloc_cubit/user_listing_cubit.dart';
import 'package:api_learning/features/user/list/ui/user_homepage_using_bloc.dart';
import 'package:api_learning/features/user/list/ui/user_homepage_using_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Welcome To Home')),
        backgroundColor: Colors.cyan,
      ),
      body: Stack(
        children: [
          Positioned(
            bottom: 470,
            right: 180,
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => UserHomepageUsingBloc(),
                      ),
                    );
                  },
                  child: Text('BLOC', style: TextStyle(fontSize: 20)),
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(
                      Colors.lightBlueAccent,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BlocProvider(
                          create: (context) => UserListingCubit(),
                          child: UserHomepageCubit(),
                        ),
                      ),
                    );
                  },
                  child: Text('CUBIT', style: TextStyle(fontSize: 20)),
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Colors.green),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BlocProvider(
                          create: (context) => PostsBloc(PostsApi()),
                          child: PostHomepage(),
                        ),
                      ),
                    );
                  },
                  child: Text('Posts', style: TextStyle(fontSize: 20)),
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Colors.grey),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
