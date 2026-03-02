import 'dart:convert';

import 'package:api_learning/features/syllabus/model/syllabus_content_model.dart';
import 'package:api_learning/features/syllabus/model/syllabus_model.dart';
import 'package:flutter/material.dart';

class SyllabusDetailUi extends StatelessWidget {
  final SyllabusModel item;

  const SyllabusDetailUi({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> data = jsonDecode(item.contentJson);

    final List modules = data['modules'];
    final List<ModuleModel> moduleList = modules
        .map((e) => ModuleModel.fromJson(e))
        .toList();

    return Scaffold(
      appBar: AppBar(title: Text(item.title)),
      body: ListView.builder(
        itemCount: moduleList.length,
        itemBuilder: (context, index) {
          final module = moduleList[index];

          return Card(
            margin: EdgeInsets.all(8),
            child: Padding(
              padding: EdgeInsets.all(6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Module ${module.moduleNumber}: ${module.moduleTitle}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),

                  Text(
                    'Topics:',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  for (var i = 0; i < module.topics.length; i++)
                    Text(' ${i + 1}. ${module.topics[i]}'),

                  SizedBox(height: 8),

                  Text(
                    'Learning Outcomes:',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),

                  for (var i = 0; i < module.learningOutcomes.length; i++)
                    Text('  ${i + 1}. ${module.learningOutcomes[i]}'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
