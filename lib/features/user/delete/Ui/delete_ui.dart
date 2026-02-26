import 'package:api_learning/features/user/adduser/bloc/common_ui_state.dart';
import 'package:api_learning/features/user/delete/bloc/delete_user_bloc.dart';
import 'package:api_learning/features/user/list/bloc/user_bloc.dart';
import 'package:api_learning/features/user/list/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeleteUi extends StatelessWidget {
  final UserModel user;

  const DeleteUi({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DeleteUserBloc, UiState<String>>(
      listener: (context, state) {
        if (state is Success<String>) {
          context.read<UserBloc>().add(UserLoadEvent());
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('User deleted successfully')),
          );
        } else if (state is Failure<String>) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMsg ?? 'Failed to delete user')),
          );
        }
      },
      builder: (context, state) {
        return AlertDialog(
          title: const Text('Confirmation'),
          content: const Text('Do you really want to Delete?'),
          actions: [
            TextButton(
              onPressed: state is Loading ? null : () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: state is Loading
                  ? null
                  : () {
                      context.read<DeleteUserBloc>().add(
                        DeleteEvent(id: user.id ?? 0),
                      );
                    },
              child: state is Loading
                  ? const SizedBox(
                      height: 18,
                      width: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Yes'),
            ),
          ],
        );
      },
    );
  }
}
