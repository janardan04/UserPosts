import 'package:api_learning/features/syllabus/data/db_helper.dart';
import 'package:api_learning/features/syllabus/model/syllabus_model.dart';

class LocalDataSource {
  final DbHelper _dbHelper;

  LocalDataSource([DbHelper? dbHelper])
    : _dbHelper = dbHelper ?? DbHelper.instance;

  Future<SyllabusModel> insertSyllabus(SyllabusModel syllabusModel) async {
    final db = await _dbHelper.database;
    final id = await db.insert('syllabus', syllabusModel.toMap());
    return SyllabusModel(
      id: id,
      title: syllabusModel.title,
      contentJson: syllabusModel.contentJson,
    );
  }

  Future<List<SyllabusModel>> getSyllabus() async {
    final db = await _dbHelper.database;

    final result = await db.query('syllabus', orderBy: 'id DESC');

    return result.map((e) => SyllabusModel.fromMap(e)).toList();
  }

  Future<void> deleteSyllabus(int id) async {
    final db = await _dbHelper.database;
    await db.delete('syllabus', where: 'id = ?', whereArgs: [id]);
  }
}
