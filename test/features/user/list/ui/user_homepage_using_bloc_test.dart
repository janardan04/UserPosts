import 'package:api_learning/features/user/list/bloc/user_bloc.dart';
import 'package:api_learning/features/user/list/ui/user_homepage_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('description', () {
    testWidgets('Given Text widget in appBar'
        'when the application is Load'
        'Then the title should be display', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider(
            create: (_) => UserBloc(),
            child: UserHomePageUi(),
          ),
        ),
      );
      expect(find.byKey(Key('BlocConsumer')), findsNWidgets(1));
      expect(find.byKey(const Key('title_text')), findsOneWidget);
      expect(find.text('Using the Bloc'), findsOneWidget);
    });
    // testWidgets('Given ', (WidgetTester tester) async {
    //   await
    // });
  });
}
