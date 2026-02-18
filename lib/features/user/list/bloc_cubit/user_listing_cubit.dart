import 'package:api_learning/features/user/list/Repository/user_repo.dart';
import 'package:api_learning/features/user/list/api/api_service.dart';
import 'package:api_learning/features/user/list/model/user_model.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'user_listing_state.dart';

class UserListingCubit extends Cubit<UserListingState> {
  UserRepo _userRepo;

  UserListingCubit({UserRepo? userRepo})
    : _userRepo = userRepo ?? UserRepo(),
      super(UserListingInitial());

  getDetails() async {
    emit(UserListingLoading());
    try {
      List<Usermodel> usermodel = await _userRepo.getDetails();
      emit(UserListingLoaded(usermodel));
    } catch (e) {
      print("Errorr===>> $e");
      emit(UserListingError(e.toString()));
    }
  }
}
