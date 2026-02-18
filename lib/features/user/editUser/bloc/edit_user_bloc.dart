import 'package:api_learning/features/user/adduser/model/AddUserModel.dart';
import 'package:api_learning/features/user/list/api/api_service.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'edit_user_event.dart';

part 'edit_user_state.dart';

class EditUserBloc extends Bloc<EditUserEvent, EditUserState> {
  final ApiService apiService;

  EditUserBloc(this.apiService) : super(EditUserInitial()) {
    on<EditEvent>((event, emit) async {
      emit(EditUserInitial());
      try {
        final user = Addusermodel(
          name: event.name,
          email: event.email,
          gender: event.gender,
          status: event.status,
        );

        await apiService.editUser(event.id, user);
        emit(EditUserSuccess());
      } catch (e) {
        emit(EditUserError(e.toString()));
      }
    });
  }
}
