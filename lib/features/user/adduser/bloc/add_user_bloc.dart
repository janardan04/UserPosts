import 'package:api_learning/features/user/adduser/model/AddUserModel.dart';
import 'package:api_learning/features/user/list/api/api_service.dart';
import 'package:api_learning/features/user/list/bloc/user_bloc.dart';
import 'package:api_learning/features/user/list/model/user_model.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'add_user_event.dart';

part 'add_user_state.dart';

class AddUserBloc extends Bloc<AddUserEvent, AddUserState> {
  final ApiService apiService;

  AddUserBloc(this.apiService) : super(AddUserInitial()) {
    on<AddNewUserEvent>((event, emit) async {
      emit(AddUserAddingState());
      try {
        final newUser = Addusermodel(
          name: event.name,
          email: event.email,
          gender: event.gender,
          status: event.status,
        );

        await apiService.addUser(newUser);
        emit(AddUserSuccessState());
        print(newUser);
      } catch (e) {
        emit(AddUserErrorState(e.toString()));
      }
      emit(AddUserAddingState());
    });
  }
}
