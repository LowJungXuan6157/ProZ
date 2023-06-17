import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pro_z/pro_z.dart';

void main() {
  group('RatingWidget', () {
    testWidgets('RatingWidget correctly initializes with initial value',
            (WidgetTester tester) async {
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

          // Expect to find two filled stars and three unfilled stars
          expect(find.byIcon(Icons.star), findsNWidgets(2));
          expect(find.byIcon(Icons.star_border), findsNWidgets(3));
        });
  });
}
