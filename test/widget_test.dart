import 'package:flutter_test/flutter_test.dart';

import 'package:battle_card/main.dart';

void main() {
  testWidgets('App loads with StartScreen', (WidgetTester tester) async {
    await tester.pumpWidget(const BattleCardApp());

    // StartScreen should show the app title and start button
    expect(find.text('バトルカード'), findsOneWidget);
    expect(find.text('カードをつくる！'), findsOneWidget);
  });
}
