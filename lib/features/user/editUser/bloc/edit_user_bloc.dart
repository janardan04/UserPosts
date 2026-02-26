import 'package:api_learning/features/user/adduser/bloc/common_ui_state.dart';
import 'package:api_learning/features/user/adduser/model/add_user_model.dart';
import 'package:api_learning/features/user/list/api/api_service.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'edit_user_event.dart';

class EditUserBloc extends Bloc<EditUserEvent, UiState<AddUserModel>> {
  final ApiService apiService;

  EditUserBloc(this.apiService) : super(Initial()) {
    on<EditEvent>((event, emit) async {
      emit(Loading());
      try {
        final user = AddUserModel(
          name: event.name,
          email: event.email,
          gender: event.gender,
          status: event.status,
        );

        await apiService.editUser(event.id, user);
        emit(Success(user));
      } catch (e) {
        emit(Failure(e.toString()));
      }
    });
  }
}
