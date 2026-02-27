part of 'user_bloc.dart';

sealed class UserEvent {}

class UserLoadEvent extends UserEvent {}

class UserReloadEvent extends UserEvent {}
