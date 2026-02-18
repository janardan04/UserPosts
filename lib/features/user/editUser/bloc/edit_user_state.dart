part of 'edit_user_bloc.dart';

@immutable
sealed class EditUserState {}

final class EditUserInitial extends EditUserState {}

final class EditUserSuccess extends EditUserState {}

final class EditUserError extends EditUserState {
  String? error;

  EditUserError(this.error);
}
