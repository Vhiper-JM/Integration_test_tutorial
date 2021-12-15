import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:integration_test_tutorial/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets(
    "Not inputting a text and wanting to go to the display page shows " // Try to convey as much information as possible with
    "an error and prevents from going to the display page.",            // the testWidgets description
    (WidgetTester tester) async {
      await tester.pumpWidget(MyApp());                     // The method pumpWidget will LOAD the widget that is passed to it
                                                            // as an argument
      await tester.tap(find.byType(FloatingActionButton));  // The tap method will tap whichever widget is passed to it.
      await tester.pumpAndSettle();                         // pumpAndSettle() will wait for every frame of animation to be completed
                                                            // once there is no frames left, the rest of the code will be executed/


      expect(find.byType(TypingPage), findsOneWidget);
      expect(find.byType(DisplayPage), findsNothing);
      expect(find.text('Input at least one character'), findsOneWidget);
    },
  );

  testWidgets(
    "After inputting a text, go to the display page which contains that same text "
    "and then navigate back to the typing page where the input should be clear",
    (WidgetTester tester) async {
      await tester.pumpWidget(MyApp());

      final inputText = 'Hello there, this is an input.';
      await tester.enterText(find.byKey(Key('your-text-field')), inputText);

      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      expect(find.byType(TypingPage), findsNothing);
      expect(find.byType(DisplayPage), findsOneWidget);
      expect(find.text(inputText), findsOneWidget);

      await tester.tap(find.byType(BackButton));
      await tester.pumpAndSettle();

      expect(find.byType(TypingPage), findsOneWidget);
      expect(find.byType(DisplayPage), findsNothing);
      expect(find.text(inputText), findsNothing);
    },
  );
}
