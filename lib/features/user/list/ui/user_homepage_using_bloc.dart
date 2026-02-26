import 'package:api_learning/features/user/adduser/adduserUi/add_user_ui.dart';
import 'package:api_learning/features/user/adduser/bloc/add_user_bloc.dart';
import 'package:api_learning/features/user/delete/Ui/delete_ui.dart';
import 'package:api_learning/features/user/delete/bloc/delete_user_bloc.dart';
import 'package:api_learning/features/user/editUser/bloc/edit_user_bloc.dart';
import 'package:api_learning/features/user/editUser/editUi/edit_user_ui.dart';
import 'package:api_learning/features/user/favourite/bloc/favorites_bloc.dart';
import 'package:api_learning/features/user/favourite/favorite_UI/list_favorite_users.dart';
import 'package:api_learning/features/user/list/api/api_service.dart';
import 'package:api_learning/features/user/list/bloc/user_bloc.dart';
import 'package:api_learning/features/user/list/model/user_model.dart';
import 'package:api_learning/features/user/list/ui/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../../favourite/bloc/ui_state.dart';

class UserHomepageUsingBloc extends StatefulWidget {
  const UserHomepageUsingBloc({super.key});

  @override
  State<UserHomepageUsingBloc> createState() => _UserHomepageUsingBlocState();
}

class _UserHomepageUsingBlocState extends State<UserHomepageUsingBloc> {
  FavoritesBloc? _favoritesBloc;
  List<String> favoriteIds = [];

  void initState() {
    super.initState();
    _favoritesBloc = context.read<FavoritesBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return ListFavoriteUsers();
                    },
                  ),
                );
              },
              icon: Icon(Icons.favorite, color: Colors.red, size: 35),
            ),
          ],
        ),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: BlocConsumer<UserBloc, UiState<List<Usermodel>>>(
        key: Key('BlocConsumer'),
        listener: (context, state) {
          print(state);
        },
        builder: (context, state) {
          if (state is Initial) {
            return Center(
              child: ElevatedButton(
                onPressed: () {
                  context.read<UserBloc>().add(UserLoadEvent()); //changes
                },
                child: Text('Display Users', style: TextStyle(fontSize: 20)),
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(
                    Colors.deepOrangeAccent,
                  ),
                ),
              ),
            );
          } else if (state is Loading) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.red,
                strokeWidth: 6,
                strokeAlign: 6,
              ),
            );
          } else if (state is Success<List<Usermodel>>) {
            return Stack(
              children: [
                ListView.builder(
                  itemCount: state.data?.length ?? 0,
                  itemBuilder: (context, index) {
                    final user = state.data![index];
                    return ListTile(
                      title: Text(user.name ?? ""),
                      subtitle: Text(user.email ?? ""),
                      onTap: () => {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text(
                                user.name!,
                                style: TextStyle(
                                  color: Colors.purple,
                                  fontFamily: "Outfit",
                                ),
                              ),
                              content: Row(
                                children: [
                                  Text(user.gender!.toUpperCase()),
                                  Text(' '),
                                  Text(
                                    ' ${user.status!.toUpperCase()}',
                                    style: TextStyle(
                                      color: user.status! == 'active'
                                          ? Colors.green
                                          : Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      },
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (_) {
                                  return BlocProvider(
                                    create: (_) => EditUserBloc(
                                      ApiService(client: http.Client()),
                                    ),
                                    child: EditUserUi(user: user),
                                  );
                                },
                              );
                            },
                            icon: Icon(Icons.edit),
                          ),
                          IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (_) {
                                  return BlocProvider(
                                    create: (_) => DeleteUserBloc(
                                      ApiService(client: http.Client()),
                                    ),
                                    child: DeleteUi(user: user),
                                  );
                                },
                              );
                            },
                            icon: Icon(Icons.delete),
                          ),
                          BlocBuilder<FavoritesBloc, UiState<List<String>>>(
                            bloc: _favoritesBloc,
                            buildWhen: (prev, curr) {
                              if (curr is Success) {
                                return _favoritesBloc?.currentUser == user.id;
                              }
                              return false;
                            },
                            builder: (context, favState) {
                              if (state is Loading) {
                                return CircularProgressIndicator();
                              }

                              final isFav = _favoritesBloc?.isFavoriteUser(
                                userId: user.id!,
                              );
                              return IconButton(
                                onPressed: user.id != null
                                    ? () {
                                        final favoritesBloc = context
                                            .read<FavoritesBloc>();
                                        if (favoritesBloc.isFavoriteUser(
                                          userId: user.id!,
                                        )) {
                                          favoritesBloc.removeFromFavorites(
                                            userId: user.id!,
                                          );
                                        } else {
                                          favoritesBloc.addToFavorites(
                                            userId: user.id!,
                                          );
                                        }
                                      }
                                    : null,
                                icon: Icon(
                                  isFav == true
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: isFav == true ? Colors.red : null,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
                Positioned(
                  bottom: 80,
                  right: 30,
                  child: ElevatedButton(
                    onPressed: () => {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return BlocProvider.value(
                            value: context.read<AddUserBloc>(),
                            child: const AddUserUi(),
                          );
                        },
                      ),
                    },
                    child: Row(
                      children: [
                        Icon(Icons.person_add, size: 30),
                        SizedBox(width: 6),
                      ],
                    ),
                  ),
                ),
              ],
            );
          } else if (state is Failure<List<Usermodel>>) {
            return Center(child: Text(state.errorMsg.toString()));
          } else {
            return SizedBox.shrink();
          }
        },
      ),
    );
  }
}

/*
*
*
*
* UserListing UI
*   UserListingBloc
*   FavoritesBloc
*
*a
* FavoritesBloc
* -> Mark as Favorite (event -> favorite_marked -> user_listing_refresh)
*
*
* */
