// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:tap_game/main.dart';

void main() {
  testWidgets('home screen starts a game', (WidgetTester tester) async {
    await tester.pumpWidget(const TapGameApp());

    expect(find.text('DUAL TAP'), findsOneWidget);
    expect(find.text('Start game'), findsOneWidget);

    await tester.tap(find.text('Start game'));
    await tester.pumpAndSettle();

    expect(find.text('PLAYER A'), findsOneWidget);
    expect(find.text('PLAYER B'), findsOneWidget);
  });

  testWidgets('tapping a player updates their score',
      (WidgetTester tester) async {
    await tester.pumpWidget(const TapGameApp());
    await tester.tap(find.text('Start game'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('PLAYER A'));
    await tester.pump();

    expect(find.text('5'), findsOneWidget);
  });
}
