import 'dart:convert';
import 'dart:io';

import 'package:api_learning/features/user/list/Repository/user_repo.dart';
import 'package:api_learning/features/user/list/bloc/user_bloc.dart';
import 'package:api_learning/features/user/list/bloc_cubit/user_listing_cubit.dart';
import 'package:api_learning/features/user/list/model/user_model.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockUserRepo extends Mock implements UserRepo {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late UserRepo userRepo;
  late UserListingCubit userBloc;
  late List<Usermodel> userList;
  group('User Listing', () {
    setUp(() {
      print("setUp");
    });
    setUpAll(() async {
      print("setUpAll");

      userRepo = MockUserRepo();
      userBloc = UserListingCubit(userRepo: userRepo);
      final file = File('test/Json/userlist.json');
      final jsonString = await file.readAsString();

      final jsonMap = jsonDecode(jsonString);

      userList = jsonMap.map<Usermodel>((e) => Usermodel.fromJson(e)).toList();
    });
    blocTest<UserListingCubit, UserListingState>(
      ' for UserList '
      'when User is Loaded'
      'then user list should be display',

      build: () {
        when(() => userRepo.getDetails()).thenAnswer((_) async {
          print("UserList-===> $userList");
          return userList;
        });
        return userBloc;
      },
      act: (UserListingCubit bloc) => bloc.getDetails(),

      expect: () => [isA<UserListingLoading>(), isA<UserListingLoaded>()],
    );
  });
}
