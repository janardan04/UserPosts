import 'package:api_learning/features/user/adduser/bloc/common_ui_state.dart';
import 'package:api_learning/features/user/adduser/model/add_user_model.dart';
import 'package:api_learning/features/user/editUser/bloc/edit_user_bloc.dart';
import 'package:api_learning/features/user/list/bloc/user_bloc.dart';
import 'package:api_learning/features/user/list/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditUserUi extends StatefulWidget {
  final UserModel user;

  const EditUserUi({super.key, required this.user});

  @override
  State<EditUserUi> createState() => _EditUserUiState();
}

class _EditUserUiState extends State<EditUserUi> {
  late final TextEditingController nameController;
  late final TextEditingController emailController;
  late final TextEditingController genderController;
  late final TextEditingController statusController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.user.name);
    emailController = TextEditingController(text: widget.user.email);
    genderController = TextEditingController(text: widget.user.gender);
    statusController = TextEditingController(text: widget.user.status);
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    genderController.dispose();
    statusController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EditUserBloc, UiState<AddUserModel>>(
      listener: (context, state) {
        if (state is Success<AddUserModel>) {
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
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: state is Loading
                  ? null
                  : () {
                      context.read<EditUserBloc>().add(
                        EditEvent(
                          id: widget.user.id!,
                          name: nameController.text,
                          email: emailController.text,
                          gender: genderController.text,
                          status: statusController.text,
                        ),
                      );
                    },
              child: state is Loading
                  ? const SizedBox(
                      height: 18,
                      width: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
