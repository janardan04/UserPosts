import 'package:api_learning/features/user/adduser/adduserUi/add_user_ui.dart';
import 'package:api_learning/features/user/adduser/bloc/add_user_bloc.dart';
import 'package:api_learning/features/user/delete/Ui/delete_ui.dart';
import 'package:api_learning/features/user/delete/bloc/delete_user_bloc.dart';
import 'package:api_learning/features/user/editUser/bloc/edit_user_bloc.dart';
import 'package:api_learning/features/user/editUser/editUi/edit_user_ui.dart';
import 'package:api_learning/features/user/list/api/api_service.dart';
import 'package:api_learning/features/user/list/bloc/user_bloc.dart';
import 'package:api_learning/features/user/list/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class UserHomepageUsingBloc extends StatefulWidget {
  const UserHomepageUsingBloc({super.key});

  @override
  State<UserHomepageUsingBloc> createState() => _UserHomepageUsingBlocState();
}

class _UserHomepageUsingBlocState extends State<UserHomepageUsingBloc> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Using the Bloc'),
        backgroundColor: Colors.deepPurple,
      ),
      body: BlocConsumer<UserBloc, UserState>(
        listener: (context, state) {
          print(state);
        },
        builder: (context, state) {
          if (state is UserInitial) {
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
          } else if (state is UserLoading) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.red,
                strokeWidth: 6,
                strokeAlign: 6,
              ),
            );
          } else if (state is UserLoaded) {
            return Stack(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: state.users.length,
                    itemBuilder: (context, index) {
                      final data = state.users[index];

                      return ListTile(
                        title: Text(data.name ?? ""),
                        subtitle: Text(data.email ?? ""),
                        onTap: () => {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text(
                                  data.name!,
                                  style: TextStyle(
                                    color: Colors.purple,
                                    fontFamily: "Outfit",
                                  ),
                                ),
                                content: Row(
                                  children: [
                                    Text(data.gender!.toUpperCase()),
                                    Text(' '),
                                    Text(
                                      ' ' + data.status!.toUpperCase(),
                                      style: TextStyle(
                                        color: data.status! == 'active'
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
          } else if (state is UserError) {
            return Center(child: Text(state.error));
          } else {
            return SizedBox.shrink();
          }
        },
      ),
    );
  }
}
