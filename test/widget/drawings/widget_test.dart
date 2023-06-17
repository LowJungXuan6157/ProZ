import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pro_z/pro_z.dart';

void main() {
  testWidgets('ProZDrawingWidget renders correctly', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ProZDrawingWidget(
            borderColor: Colors.black,
            lineColor: Colors.black,
            isLoading: (bool isLoading) {},
          ),
        ),
      ),
    );

    // Verify that our widget renders.
    expect(find.byType(ProZDrawingWidget), findsOneWidget);
  });
}
