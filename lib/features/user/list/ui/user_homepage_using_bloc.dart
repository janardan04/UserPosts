import 'package:api_learning/features/user/list/bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                child: Text('press', style: TextStyle(fontSize: 20)),
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(
                    Colors.deepOrangeAccent,
                  ),
                ),
              ),
            );
          } else if (state is UserLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is UserLoaded) {
            return ListView.builder(
              itemCount: state.usermodel.users?.length,
              itemBuilder: (context, index) {
                final data = state.usermodel.users![index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(data.image.toString()),
                  ),
                  title: Text(data.firstName.toString()),
                  subtitle: Text(data.email.toString()),
                  trailing: Text(
                    data.role.toString(),
                    style: TextStyle(color: Colors.green),
                  ),
                );
              },
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
