part of 'user_listing_cubit.dart';

@immutable
sealed class UserListingState {}

final class UserListingInitial extends UserListingState {}

class UserListingLoading extends UserListingState {}

class UserListingLoaded extends UserListingState {
  List<Usermodel> users;

  UserListingLoaded(this.users);
}

class UserListingError extends UserListingState {
  final String error;

  UserListingError(this.error);
}
