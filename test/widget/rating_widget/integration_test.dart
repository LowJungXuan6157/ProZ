import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:pro_z/pro_z.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('RatingWidget integration test', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: RatingWidget(
            onChanged: (_) {},
            initialValue: 2,
          ),
        ),
      ),
    );

    // Verify initial value is set
    expect(find.byIcon(Icons.star), findsNWidgets(2));
    expect(find.byIcon(Icons.star_border), findsNWidgets(3));

    // Tap on the fourth star
    await tester.tap(find.byIcon(Icons.star_border).at(1));
    await tester.pumpAndSettle();

    // Verify fourth star is filled
    expect(find.byIcon(Icons.star), findsNWidgets(4));
    expect(find.byIcon(Icons.star_border), findsNWidgets(1));
  });
}
