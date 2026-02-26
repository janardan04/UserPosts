import 'package:api_learning/features/user/favourite/bloc/favorites_bloc.dart';
import 'package:api_learning/features/user/adduser/bloc/common_ui_state.dart';
import 'package:api_learning/features/user/list/bloc/user_bloc.dart';
import 'package:api_learning/features/user/list/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListFavoriteUsers extends StatelessWidget {
  const ListFavoriteUsers({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favorite Users')),
      body: BlocBuilder<UserBloc, UiState<List<UserModel>>>(
        builder: (context, userState) {
          if (userState is Loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (userState is Success<List<UserModel>>) {
            final allUsers = userState.data ?? [];

            return BlocBuilder<FavoritesBloc, UiState<List<String>>>(
              builder: (context, favState) {
                if (favState is Success<List<String>>) {
                  final favoriteIds = favState.data ?? [];

                  final favoriteUsers = allUsers
                      .where((user) => favoriteIds.contains(user.id.toString()))
                      .toList();

                  if (favoriteUsers.isEmpty) {
                    return const Center(child: Text("No favorite users"));
                  }

                  return ListView.builder(
                    itemCount: favoriteUsers.length,
                    itemBuilder: (context, index) {
                      final user = favoriteUsers[index];

                      return ListTile(
                        title: Text(user.name ?? ""),
                        subtitle: Text(user.email ?? ""),
                      );
                    },
                  );
                }

                return const Center(child: CircularProgressIndicator());
              },
            );
          }

          if (userState is Failure<List<UserModel>>) {
            return Center(child: Text(userState.errorMsg ?? ""));
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
