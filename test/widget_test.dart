import 'package:flutter_test/flutter_test.dart';

import 'package:battle_card/main.dart';

void main() {
  testWidgets('App loads correctly', (WidgetTester tester) async {
    await tester.pumpWidget(const BattleCardApp());

    expect(find.text('バトルカード作成'), findsOneWidget);
    expect(find.text('カードを作成'), findsOneWidget);
  });
}
