import 'package:api_learning/features/user/adduser/bloc/common_ui_state.dart';
import 'package:api_learning/features/user/adduser/model/add_user_model.dart';
import 'package:api_learning/features/user/list/api/api_service.dart';
import 'package:bloc/bloc.dart';

part 'add_user_event.dart';

class AddUserBloc extends Bloc<AddUserEvent, UiState<AddUserModel>> {
  final ApiService apiService;

  AddUserBloc(this.apiService) : super(Initial()) {
    on<AddNewUserEvent>((event, emit) async {
      emit(Loading());
      try {
        final newUser = AddUserModel(
          name: event.name,
          email: event.email,
          gender: event.gender,
          status: event.status,
        );
        await apiService.addUser(newUser);
        emit(Success(newUser));
      } catch (e) {
        emit(Failure(e.toString()));
      }
    });
  }
}
