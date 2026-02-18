import 'dart:math';

import 'package:api_learning/features/user/editUser/bloc/edit_user_bloc.dart';
import 'package:api_learning/features/user/list/bloc/user_bloc.dart';
import 'package:api_learning/features/user/list/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditUserUi extends StatefulWidget {
  final Usermodel user;

  const EditUserUi({super.key, required this.user});

  @override
  State<EditUserUi> createState() => _EditUserUiState();
}

class _EditUserUiState extends State<EditUserUi> {
  late final TextEditingController nameController;
  late final TextEditingController emailController;
  late final TextEditingController genderController;
  late final TextEditingController statusController;
  late final TextEditingController idController;

  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.user.name);
    emailController = TextEditingController(text: widget.user.email);
    genderController = TextEditingController(text: widget.user.gender);
    statusController = TextEditingController(text: widget.user.status);
    idController = TextEditingController(text: widget.user.id.toString());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EditUserBloc, EditUserState>(
      listener: (context, state) {
        if (state is EditUserSuccess) {
          context.read<UserBloc>().add(UserLoadEvent());
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return AlertDialog(
          title: Text('Edit Details'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                ),
                TextField(
                  controller: genderController,
                  decoration: InputDecoration(labelText: 'Gender'),
                ),
                TextField(
                  controller: statusController,
                  decoration: InputDecoration(labelText: 'Status'),
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () => {Navigator.pop(context)},
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () => {
                context.read<EditUserBloc>()..add(
                  EditEvent(
                    id: int.parse(idController.text),
                    name: nameController.text,
                    email: emailController.text,
                    gender: genderController.text,
                    status: statusController.text,
                  ),
                ),
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
