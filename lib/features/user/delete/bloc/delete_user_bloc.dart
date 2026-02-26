import 'dart:ffi';

import 'package:api_learning/features/user/adduser/bloc/common_ui_state.dart';
import 'package:api_learning/features/user/list/api/api_service.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'delete_user_event.dart';

class DeleteUserBloc extends Bloc<DeleteUserEvent, UiState<String>> {
  final ApiService apiservice;

  DeleteUserBloc(this.apiservice) : super(Initial()) {
    on<DeleteEvent>((event, emit) async {
      emit(Loading());

      try {
        await apiservice.deleteUser(event.id);
        emit(Success(null));
      } catch (e) {
        emit(Failure(e.toString()));
      }
    });
  }
}
