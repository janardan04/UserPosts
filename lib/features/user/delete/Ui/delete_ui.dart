import 'package:api_learning/features/user/adduser/model/AddUserModel.dart';
import 'package:api_learning/features/user/delete/bloc/delete_user_bloc.dart';
import 'package:api_learning/features/user/list/bloc/user_bloc.dart';
import 'package:api_learning/features/user/list/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeleteUi extends StatefulWidget {
  final Usermodel user;

  const DeleteUi({super.key, required this.user});

  @override
  State<DeleteUi> createState() => _DeleteUiState();
}

class _DeleteUiState extends State<DeleteUi> {
  late final TextEditingController idController;

  void initState() {
    super.initState();
    idController = TextEditingController(text: widget.user.id.toString());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DeleteUserBloc, DeleteUserState>(
      listener: (context, state) {
        if (state is DeleteSuccessfully) {
          context.read<UserBloc>().add(UserLoadEvent());
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return AlertDialog(
          title: const Text('Confirmation'),
          content: SingleChildScrollView(
            child: Row(children: [const Text('Do you really want to Delete?')]),
          ),
          actions: [
            TextButton(
              onPressed: () => {Navigator.pop(context)},
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                context.read<DeleteUserBloc>().add(
                  DeleteEvent(id: int.parse(idController.text)),
                );
              },
              child: Text('Yes'),
            ),
          ],
        );
      },
    );
  }
}
