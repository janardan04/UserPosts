import 'package:api_learning/features/user/list/api/api_service.dart';
import 'package:api_learning/features/user/list/model/user_model.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'user_event.dart';

part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  ApiService _apiService;

  UserBloc(this._apiService) : super(UserInitial()) {
    on<UserLoadEvent>((event, emit) async {
      // switch(event){
      //   case UserLoadEvent:
      //     break;
      //   case UserReloadEvent:
      //     break;
      // }

      emit(UserLoading());
      try {
        final Usermodel? users = await _apiService.getDetails();
        emit(UserLoaded(users!));
      } catch (e) {
        // throw Exception('');
        emit(UserError(e.toString()));
      }
      // TODO: implement event handler
    });
  }
}
