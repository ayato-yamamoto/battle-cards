import 'package:flutter_test/flutter_test.dart';

import 'package:battle_card/main.dart';

void main() {
  testWidgets('App loads correctly', (WidgetTester tester) async {
    await tester.pumpWidget(const BattleCardApp());

    expect(find.text('Battle Card Creator'), findsOneWidget);
    expect(find.text('Create Your Card'), findsOneWidget);
  });
}
