import 'package:api_learning/features/user/list/api/api_service.dart';
import 'package:api_learning/features/user/list/model/user_model.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'user_listing_state.dart';

class UserListingCubit extends Cubit<UserListingState> {
  ApiService apiService;

  UserListingCubit(this.apiService) : super(UserListingInitial());

  Future<void> getDetails() async {
    emit(UserListingLoading());
    try {
      Usermodel? usermodel = await apiService.getDetails();
      emit(UserListingLoaded(usermodel!));
    } catch (e) {
      emit(UserListingError(e.toString()));
    }
  }
}
