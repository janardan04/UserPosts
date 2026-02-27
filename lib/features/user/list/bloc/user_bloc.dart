import 'package:api_learning/features/user/list/Repository/user_repo.dart';
import 'package:api_learning/features/user/list/model/user_model.dart';
import 'package:api_learning/features/user/adduser/bloc/common_ui_state.dart';
import 'package:bloc/bloc.dart';

part 'user_event.dart';

class UserBloc extends Bloc<UserEvent, UiState<List<UserModel>>> {
  final UserRepo _userRepo;

  UserBloc({UserRepo? userRepo})
    : _userRepo = userRepo ?? UserRepo(),
      super(Initial()) {
    on<UserLoadEvent>((event, emit) async {
      emit(Loading());
      try {
        final List<UserModel> users = await _userRepo.getDetails();
        emit(Success(users));
      } catch (e) {
        emit(Failure(e.toString()));
      }
    });
  }
}
