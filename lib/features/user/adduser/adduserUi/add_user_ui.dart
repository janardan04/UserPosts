import 'package:api_learning/features/user/adduser/bloc/add_user_bloc.dart';
import 'package:api_learning/features/user/adduser/model/add_user_model.dart';
import 'package:api_learning/features/user/list/bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/common_ui_state.dart';

class AddUserUi extends StatefulWidget {
  const AddUserUi({super.key});

  @override
  State<AddUserUi> createState() => _AddUserUiState();
}

class _AddUserUiState extends State<AddUserUi> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();

  String selectedGender = 'male';

  String status = 'active';

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddUserBloc, UiState<AddUserModel>>(
      listener: (context, state) {
        if (state is Success<AddUserModel>) {
          context.read<UserBloc>().add(UserLoadEvent());
          Navigator.pop(context);

          Fluttertoast.showToast(
            msg: 'User Added Successfully',
            backgroundColor: Colors.green,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
          );
        }
        if (state is Failure<AddUserModel>) {
          Fluttertoast.showToast(
            msg: state.errorMsg ?? 'Something wrong',
            backgroundColor: Colors.red,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
          );
        }
      },
      builder: (context, state) {
        return AlertDialog(
          title: const Text('Add New User'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                ),
                RadioGroup<String>(
                  groupValue: selectedGender,
                  onChanged: (value) {
                    setState(() {
                      selectedGender = value!;
                    });
                  },
                  child: Row(
                    children: [
                      Radio<String>(value: "male"),
                      const Text('male'),
                      Radio<String>(value: "female"),
                      const Text('Female'),
                    ],
                  ),
                ),
                RadioGroup<String>(
                  groupValue: status,
                  onChanged: (value) {
                    setState(() {
                      status = value!;
                    });
                  },
                  child: Row(
                    children: [
                      Radio<String>(value: 'Active'),
                      const Text('Active'),
                      Radio<String>(value: 'Inactive'),
                      const Text('Inactive'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: state is Loading
                  ? null
                  : () {
                      context.read<AddUserBloc>().add(
                        AddNewUserEvent(
                          name: nameController.text,
                          email: emailController.text,
                          gender: selectedGender,
                          status: status,
                        ),
                      );
                    },
              child: state is Loading
                  ? const SizedBox(
                      height: 18,
                      width: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Add'),
            ),
          ],
        );
      },
    );
  }
}
