import 'dart:convert';

import 'package:api_learning/features/syllabus/data/ai_service.dart';
import 'package:api_learning/features/syllabus/data/local_data_source.dart';
import 'package:api_learning/features/syllabus/model/syllabus_model.dart';

class SyllabusRepository {
  final AiService _aiService;
  final LocalDataSource _localDataSource;

  SyllabusRepository([AiService? aiService, LocalDataSource? localDataSource])
    : _aiService = aiService ?? AiService(),
      _localDataSource = localDataSource ?? LocalDataSource();

  Future<SyllabusModel> generateAndSave(String topic) async {
    final res = await _aiService.generateSyllabus(topic);
    final responseDecoded = jsonDecode(res);
    final model = SyllabusModel(
      title: responseDecoded['title'],
      contentJson: res,
    );

    return await _localDataSource.insertSyllabus(model);
  }

  Future<List<SyllabusModel>> getSyllabus() async {
    return await _localDataSource.getSyllabus();
  }

  Future<void> deleteSyllabus(int id) async {
    await _localDataSource.deleteSyllabus(id);
  }
}
