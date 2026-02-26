import 'package:api_learning/features/user/adduser/adduserUi/add_user_ui.dart';
import 'package:api_learning/features/user/adduser/bloc/add_user_bloc.dart';
import 'package:api_learning/features/user/delete/Ui/delete_ui.dart';
import 'package:api_learning/features/user/delete/bloc/delete_user_bloc.dart';
import 'package:api_learning/features/user/editUser/bloc/edit_user_bloc.dart';
import 'package:api_learning/features/user/editUser/editUi/edit_user_ui.dart';
import 'package:api_learning/features/user/list/api/api_service.dart';
import 'package:api_learning/features/user/list/bloc/user_bloc.dart';
import 'package:api_learning/features/user/list/model/user_model.dart';
import 'package:api_learning/features/user/list/ui/user_details_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../../adduser/bloc/common_ui_state.dart';

class UserHomepageUi extends StatefulWidget {
  const UserHomepageUi({super.key});

  @override
  State<UserHomepageUi> createState() => _UserHomepageUiState();
}

class _UserHomepageUiState extends State<UserHomepageUi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Using the Bloc'),
        backgroundColor: Colors.deepPurple,
      ),
      body: BlocConsumer<UserBloc, UiState<List<UserModel>>>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is Initial) {
            return Center(
              child: ElevatedButton(
                onPressed: () {
                  context.read<UserBloc>().add(UserLoadEvent());
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
          } else if (state is Success<List<UserModel>>) {
            final users = state.data ?? [];
            return Stack(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      final data = users[index];

                      return ListTile(
                        title: Text(data.name ?? ""),
                        subtitle: Text(data.email ?? ""),
                        onTap: () {
                          showUserDetailsDialog(context, data);
                        },
                        trailing: PopupMenuButton<String>(
                          onSelected: (value) {
                            if (value == 'Edit') {
                              showDialog(
                                context: context,
                                builder: (_) {
                                  return BlocProvider(
                                    create: (_) => EditUserBloc(
                                      ApiService(client: http.Client()),
                                    ),
                                    child: EditUserUi(user: data),
                                  );
                                },
                              );
                            } else if (value == 'Delete') {
                              showDialog(
                                context: context,
                                builder: (_) {
                                  return BlocProvider(
                                    create: (_) => DeleteUserBloc(
                                      ApiService(client: http.Client()),
                                    ),
                                    child: DeleteUi(user: data),
                                  );
                                },
                              );
                            }
                          },
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              value: 'Edit',
                              height: 20,
                              child: Row(
                                children: [
                                  Icon(Icons.edit, size: 30),
                                  SizedBox(width: 6),
                                ],
                              ),
                            ),
                            PopupMenuItem(
                              value: 'Delete',
                              height: 20,
                              child: Row(
                                children: [
                                  Icon(Icons.delete, size: 30),
                                  SizedBox(width: 6),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
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
          } else if (state is Failure<List<UserModel>>) {
            return Center(child: Text(state.errorMsg ?? "Unknown Error"));
          } else {
            return SizedBox.shrink();
          }
        },
      ),
    );
  }
}
