part of 'user_listing_cubit.dart';

@immutable
sealed class UserListingState {}

final class UserListingInitial extends UserListingState {}

class UserListingLoading extends UserListingState {}

class UserListingLoaded extends UserListingState {
  Usermodel usermodel;

  UserListingLoaded(this.usermodel);
}

class UserListingError extends UserListingState {
  final String error;

  UserListingError(this.error);
}
