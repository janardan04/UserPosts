import 'package:api_learning/features/user/list/api/api_service.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'delete_user_event.dart';

part 'delete_user_state.dart';

class DeleteUserBloc extends Bloc<DeleteUserEvent, DeleteUserState> {
  final ApiService apiservice;

  DeleteUserBloc(this.apiservice) : super(DeleteUserInitial()) {
    on<DeleteEvent>((event, emit) async {
      emit(DeleteUserInitial());

      try {
        String res = await apiservice.deleteUser(event.id);
        emit(DeleteSuccessfully(res));
      } catch (e) {
        emit(DeleteError(e.toString()));
      }
    });
  }
}
