import 'package:api_learning/features/syllabus/model/syllabus_model.dart';
import 'package:api_learning/features/syllabus/repository/syllabus_repository.dart';
import 'package:api_learning/features/user/adduser/bloc/common_ui_state.dart';
import 'package:bloc/bloc.dart';

class SyllabusCubit extends Cubit<UiState<List<SyllabusModel>>> {
  final SyllabusRepository _syllabusRepository;

  SyllabusCubit([SyllabusRepository? syllabusRepository])
    : _syllabusRepository = syllabusRepository ?? SyllabusRepository(),
      super(Initial());

  Future<void> generateAndSave(String topic) async {
    emit(Loading());
    try {
      await _syllabusRepository.generateAndSave(topic);
      final list = await _syllabusRepository.getSyllabus();
      emit(Success(list));
    } catch (e) {
      emit(Failure(e.toString()));
    }
  }

  Future<void> getSyllabus() async {
    emit(Loading());
    try {
      final response = await _syllabusRepository.getSyllabus();
      emit(Success(response));
    } catch (e) {
      emit(Failure(e.toString()));
    }
  }

  Future<void> deleteSyllabus(int id) async {
    emit(Loading());
    try {
      await _syllabusRepository.deleteSyllabus(id);
      final list = await _syllabusRepository.getSyllabus();
      emit(Success(list));
    } catch (e) {
      emit(Failure(e.toString()));
    }
  }
}
