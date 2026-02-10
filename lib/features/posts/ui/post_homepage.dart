import 'package:api_learning/features/posts/bloc/posts_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostHomepage extends StatefulWidget {
  const PostHomepage({super.key});

  @override
  State<PostHomepage> createState() => _PostHomepageState();
}

class _PostHomepageState extends State<PostHomepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts Homepage'),
        backgroundColor: Colors.red,
      ),
      body: BlocConsumer<PostsBloc, PostsState>(
        listener: (context, state) {
          print(state);
        },
        builder: (context, state) {
          if (state is PostsInitial) {
            return Stack(
              children: [
                Positioned(
                  bottom: 500,
                  right: 190,
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<PostsBloc>().add(ShowPostsEvent());
                    },
                    child: Text(
                      'View',
                      style: TextStyle(color: Colors.deepOrange, fontSize: 20),
                    ),
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                        Colors.brown.shade50,
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else if (state is PostsLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is PostsLoaded) {
            return ListView.builder(
              itemCount: state.postModel.hits!.length,
              itemBuilder: (context, index) {
                final data = state.postModel.hits![index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.network(
                    data.largeImageURL!,
                    width: double.infinity, // full width
                    fit: BoxFit.contain, // show full image
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const SizedBox(
                        height: 300,
                        child: Center(child: CircularProgressIndicator()),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return const SizedBox(
                        height: 300,
                        child: Center(child: Icon(Icons.error)),
                      );
                    },
                  ),
                );
              },
            );
          } else if (state is PostsError) {
            return Center(child: Text(state.error));
          } else {
            return SizedBox.shrink();
          }
        },
      ),
    );
  }
}
