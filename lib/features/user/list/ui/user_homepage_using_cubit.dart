import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc_cubit/user_listing_cubit.dart';

class UserHomepageCubit extends StatefulWidget {
  const UserHomepageCubit({super.key});

  @override
  State<UserHomepageCubit> createState() => _UserHomepageCubitState();
}

class _UserHomepageCubitState extends State<UserHomepageCubit> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GET API USING BLOC CUBIT"),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: BlocConsumer<UserListingCubit, UserListingState>(
        listener: (context, state) {
          // TODO: implement listener
          print(state);
        },
        builder: (context, state) {
          if (state is UserListingInitial) {
            return Stack(
              children: [
                Positioned(
                  bottom: 800,
                  right: 180,
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<UserListingCubit>().getDetails();
                    },
                    style: ButtonStyle(
                      foregroundColor: WidgetStateProperty.all(
                        Colors.greenAccent,
                      ),
                      backgroundColor: WidgetStateProperty.all(Colors.black54),
                    ),
                    child: Text(
                      'Details',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else if (state is UserListingLoading) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.red,
                strokeWidth: 6,
                strokeAlign: 6,
              ),
            );
          } else if (state is UserListingLoaded) {
            return ListView.builder(
              itemCount: state.usermodel.users?.length,
              itemBuilder: (context, index) {
                final user = state.usermodel.users![index];

                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(user.image!),
                  ),
                  title: Text(user.firstName.toString()),
                  subtitle: Text(user.company!.name.toString()),
                  textColor: Colors.deepPurple,
                );
              },
            );
          } else if (state is UserListingError) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  state.error,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    context.read<UserListingCubit>().getDetails();
                  },
                  child: Text('Try Again'),
                ),
              ],
            );
          } else {
            return SizedBox.shrink();
          }
        },
      ),
    );
  }
}
