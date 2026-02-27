import 'package:api_learning/features/user/list/Repository/user_repo.dart';
import 'package:api_learning/features/user/list/model/user_model.dart';
import 'package:bloc/bloc.dart';

part 'user_listing_state.dart';

class UserListingCubit extends Cubit<UserListingState> {
  final UserRepo _userRepo;

  UserListingCubit({UserRepo? userRepo})
    : _userRepo = userRepo ?? UserRepo(),
      super(UserListingInitial());

  Future<void> getDetails() async {
    emit(UserListingLoading());
    try {
      List<UserModel> usermodel = await _userRepo.getDetails();
      emit(UserListingLoaded(usermodel));
    } catch (e) {
      emit(UserListingError(e.toString()));
    }
  }
}
