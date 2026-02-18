import 'package:api_learning/features/posts/apiService/posts_api.dart';
import 'package:api_learning/features/posts/bloc/posts_bloc.dart';
import 'package:api_learning/features/posts/ui/post_homepage.dart';
import 'package:api_learning/features/user/adduser/bloc/add_user_bloc.dart';
import 'package:api_learning/features/user/list/Repository/user_repo.dart';
import 'package:api_learning/features/user/list/api/api_service.dart';
import 'package:api_learning/features/user/list/bloc/user_bloc.dart';
import 'package:api_learning/features/user/list/ui/home_page.dart';
import 'package:api_learning/features/user/list/ui/user_homepage_using_bloc.dart';
import 'package:api_learning/features/user/list/ui/user_homepage_using_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'features/user/list/bloc_cubit/user_listing_cubit.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final _apiService = ApiService(client: http.Client());
    final _postApi = PostsApi();
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => UserBloc()),
        BlocProvider(create: (context) => UserListingCubit()),
        BlocProvider(create: (context) => PostsBloc(_postApi)),
        BlocProvider(
          create: (context) => AddUserBloc(ApiService(client: http.Client())),
        ),
      ],
      child: MaterialApp(home: HomePage()),
    );
  }
}
