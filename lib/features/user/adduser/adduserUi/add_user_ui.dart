import 'package:api_learning/features/user/adduser/bloc/add_user_bloc.dart';
import 'package:api_learning/features/user/list/bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddUserUi extends StatefulWidget {
  const AddUserUi({super.key});

  @override
  State<AddUserUi> createState() => _AddUserUiState();
}

class _AddUserUiState extends State<AddUserUi> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();

  // final genderController = TextEditingController();
  String selectedGender = 'male';

  // final statusController = TextEditingController();
  String status = 'active';

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddUserBloc, AddUserState>(
      listener: (context, state) {
        if (state is AddUserSuccessState) {
          print('**** State is AddUserSuccessState');
          context.read<UserBloc>().add(UserLoadEvent());
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        // if(state is AddUserInitial)
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
                // const SizedBox(height: 5,),
                // const Text('Gender'),
                Row(
                  children: [
                    Radio<String>(
                      value: "male",
                      groupValue: selectedGender,
                      onChanged: (value) {
                        setState(() {
                          selectedGender = value!;
                        });
                      },
                    ),
                    const Text('male'),
                    Radio<String>(
                      value: "female",
                      groupValue: selectedGender,
                      onChanged: (value) {
                        setState(() {
                          selectedGender = value!;
                        });
                      },
                    ),
                    const Text('Female'),
                  ],
                ),
                // const SizedBox(height: 10),
                // const Text('Status'),
                Row(
                  children: [
                    Radio<String>(
                      value: 'Active',
                      groupValue: status,
                      onChanged: (value) {
                        setState(() {
                          status = value!;
                        });
                      },
                    ),
                    const Text('Active'),
                    Radio<String>(
                      value: 'Inactive',
                      groupValue: status,
                      onChanged: (value) {
                        setState(() {
                          status = value!;
                        });
                      },
                    ),
                    const Text('Inactive'),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => {Navigator.pop(context)},
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () => {
                context.read<AddUserBloc>()..add(
                  AddNewUserEvent(
                    name: nameController.text,
                    email: emailController.text,
                    gender: selectedGender,
                    status: status,
                  ),
                ),
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }
}
