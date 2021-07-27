import 'package:exame_todo_list/core/resources/constants.dart';
import 'package:exame_todo_list/core/services/di/service_locator.dart';
import 'package:exame_todo_list/core/theme/app_theme.dart';
import 'package:exame_todo_list/features/screens/todo/todo_bloc.dart';
import 'package:exame_todo_list/features/screens/todo/todo_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([TodoBloc])
void main() {
  setUpAll(() {
    setupLocator();
  });

  Widget makeTestableWidget({required Widget child}) {
    return MaterialApp(
      theme: appTheme,
      navigatorKey: Constants.appGlobalKey,
      debugShowCheckedModeBanner: false,
      title: 'TodoList',
      home: child,
    );
  }

  group('Todo page test', () {
    testWidgets(
      'Should find elements',
      (WidgetTester tester) async {
        TodoPage page = TodoPage();

        await tester.pumpWidget(makeTestableWidget(child: page));

        //find title field
        final titleField = find.byKey(Key('title_text_field'));
        expect(titleField, findsOneWidget);

        //find date field
        final dateField = find.byKey(Key('date_text_field'));
        expect(dateField, findsOneWidget);

        //find category field
        final categoryField = find.byKey(Key('category_drop_down'));
        expect(categoryField, findsOneWidget);

        //find priority field
        final priorityField = find.byKey(Key('priority_drop_down'));
        expect(priorityField, findsOneWidget);

        final button = find.byKey(Key('button'));
        expect(button, findsOneWidget);
      },
    );
    testWidgets(
      'Should fill title field',
      (WidgetTester tester) async {
        TodoPage page = TodoPage();

        await tester.pumpWidget(makeTestableWidget(child: page));
        //select title field and fill textfield
        final titleField = find.byKey(Key('title_text_field'));
        expect(titleField, findsOneWidget);
        await tester.enterText(titleField, "Todo test");
        expect(find.text("Todo test"), findsOneWidget);
      },
    );
  });

  /// TODO: Study about find dropdown items and how dropdown works natively
  // testWidgets('Should create todo', (WidgetTester tester) async {
  //   TodoPage page = TodoPage();
  //
  //   await tester.pumpWidget(makeTestableWidget(child: page));
  //   //select title field and fill textfield
  //   final titleField = find.byKey(Key('title_text_field'));
  //   expect(titleField, findsOneWidget);
  //   await tester.enterText(titleField, "Todo test");
  //   //select date text field
  //   await tester.tap(find.byKey(Key('date_text_field')));
  //   await tester.pumpAndSettle();
  //   //should date picker is open
  //   expect(find.byType(DatePickerDialog), findsOneWidget);
  //
  //   //should select current date
  //   await tester.tap(find.text('OK'));
  //   await tester.pumpAndSettle();
  //
  //   //should close date picker and find current date;
  //   expect(find.byType(DatePickerDialog), findsNothing);
  //   expect(find.text("${DateHelper.textFieldString(DateTime.now())}"), findsOneWidget);
  //
  //   //find priority field
  //   // Finder priorityDropdown = find.byKey(Key('priority_drop_down'));
  //   // await tester.tap(priorityDropdown);
  //   // await tester.pumpAndSettle();
  //
  //   //find category field
  //   // final Finder buttonToTap = find.byKey(Key('category_drop_down'));
  //   //
  //   // await tester.dragUntilVisible(
  //   //   buttonToTap, // what you want to find
  //   //   find.byType(SingleChildScrollView), // widget you want to scroll
  //   //   const Offset(0, 50), // delta to move
  //   // );
  //   // await tester.tap(find.byKey(Key('category_drop_down')));
  //   // await tester.pumpAndSettle();
  //   //
  //   // await tester.tap(find.byKey(Key('category_item_0')));
  //   // await tester.pumpAndSettle();
  //
  //   // expect(find.text("Trabalho"), findsOneWidget);
  //
  //   //should
  //   // await tester.tap(find.byKey(Key('button')));
  //   //   },
  //   // );
  // });
}
