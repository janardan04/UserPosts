import 'package:api_learning/features/syllabus/data/db_helper.dart';
import 'package:api_learning/features/syllabus/model/syllabus_model.dart';
import 'package:sqflite/sql.dart';

class LocalDataSource {
  final DbHelper _dbHelper;

  LocalDataSource([DbHelper? dbHelper])
    : _dbHelper = dbHelper ?? DbHelper.instance;

  Future<SyllabusModel> insertSyllabusDb(SyllabusModel syllabusModel) async {
    final db = await _dbHelper.database;
    final id = await db.insert(
      'syllabus',
      syllabusModel.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return SyllabusModel(
      id: id,
      title: syllabusModel.title,
      contentJson: syllabusModel.contentJson,
    );
  }

  Future<List<SyllabusModel>> getSyllabusDb() async {
    final db = await _dbHelper.database;

    final result = await db.query('syllabus', orderBy: 'id DESC');

    return result.map((e) => SyllabusModel.fromMap(e)).toList();
  }

  Future<void> deleteSyllabusDb(int id) async {
    final db = await _dbHelper.database;
    await db.delete('syllabus', where: 'id = ?', whereArgs: [id]);
  }
}
