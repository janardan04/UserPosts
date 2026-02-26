import 'package:api_learning/features/user/list/Repository/user_repo.dart';
import 'package:api_learning/features/user/list/api/api_service.dart';
import 'package:api_learning/features/user/list/model/user_model.dart';
import 'package:api_learning/features/user/adduser/bloc/common_ui_state.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'user_event.dart';

class UserBloc extends Bloc<UserEvent, UiState<List<Usermodel>>> {
  UserRepo _userRepo;

  UserBloc({UserRepo? userRepo})
    // UserBloc(Usermodel user , [UserRepo? userRepo])
    // UserBloc(UserRepo? userRepo)
    : _userRepo = userRepo ?? UserRepo(),
      super(Initial()) {
    on<UserLoadEvent>((event, emit) async {
      // switch(event){
      //   case UserLoadEvent:
      //     break;
      //   case UserReloadEvent:
      //     break;
      // }
      print('*** on Event added triggered for ${event}, now getting users');

      emit(Loading());
      try {
        final List<Usermodel> users = await _userRepo.getDetails();
        emit(Success(users));
      } catch (e) {
        // throw Exception('');
        emit(Failure(e.toString()));
      }
      // TODO: implement event handler
    });
  }
}
