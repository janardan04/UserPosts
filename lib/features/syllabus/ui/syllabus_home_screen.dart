import 'package:api_learning/features/syllabus/cubit/syllabus_cubit.dart';
import 'package:api_learning/features/syllabus/model/syllabus_model.dart';
import 'package:api_learning/features/syllabus/ui/syllabus_detail_ui.dart';
import 'package:api_learning/features/user/adduser/bloc/common_ui_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SyllabusHomeScreen extends StatefulWidget {
  const SyllabusHomeScreen({super.key});

  @override
  State<SyllabusHomeScreen> createState() => _SyllabusHomeScreenState();
}

class _SyllabusHomeScreenState extends State<SyllabusHomeScreen> {
  final _topicController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _topicController.dispose();
  }

  @override
  void initState() {
    super.initState();
    context.read<SyllabusCubit>().getSyllabus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _topicController,
          decoration: InputDecoration(hintText: 'Enter Topic'),
        ),
        actions: [
          IconButton(
            onPressed: () {
              final topic = _topicController.text.trim();
              if (!topic.isEmpty) {
                context.read<SyllabusCubit>().generateAndSave(topic);
                _topicController.clear();
              }
            },
            icon: const Icon(Icons.send),
          ),
        ],
      ),
      body: BlocBuilder<SyllabusCubit, UiState<List<SyllabusModel>>>(
        builder: (context, state) {
          if (state is Loading) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  Text(
                    'Generating Syllabus',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            );
          } else if (state is Success<List<SyllabusModel>>) {
            final syllabi = state.data ?? [];
            if (syllabi.isEmpty) {
              return const Center(child: Text('No Syllabus is Generated yet'));
            }
            return ListView.builder(
              itemCount: syllabi.length,
              itemBuilder: (context, index) {
                final item = syllabi[index];
                return ListTile(
                  title: Text(item.title),
                  trailing: IconButton(
                    onPressed: () {
                      context.read<SyllabusCubit>().deleteSyllabus(item.id!);
                    },
                    icon: Icon(Icons.delete),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return SyllabusDetailUi(item: item);
                        },
                      ),
                    );
                  },
                );
              },
            );
          } else {
            return SizedBox.shrink();
          }
        },
      ),
    );
  }
}
