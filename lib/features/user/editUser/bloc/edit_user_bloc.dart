import 'package:api_learning/features/user/adduser/model/AddUserModel.dart';
import 'package:api_learning/features/user/favourite/bloc/ui_state.dart';
import 'package:api_learning/features/user/list/api/api_service.dart';
import 'package:api_learning/features/user/list/model/user_model.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'edit_user_event.dart';

class EditUserBloc extends Bloc<EditUserEvent, UiState<Addusermodel>> {
  final ApiService apiService;

  EditUserBloc(this.apiService) : super(Initial()) {
    on<EditEvent>((event, emit) async {
      emit(Loading());
      try {
        final user = Addusermodel(
          name: event.name,
          email: event.email,
          gender: event.gender,
          status: event.status,
        );

        final updated = await apiService.editUser(event.id, user);
        emit(Success(updated));
      } catch (e) {
        emit(Failure(e.toString()));
      }
    });
  }
}
