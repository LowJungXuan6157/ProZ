import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pro_z/pro_z.dart';

void main() {
  testWidgets('ProZExpandablePageView creation Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: ProZExpandablePageView(
        initialPage: 0,
        pageController: PageController(),
        children: [Container(), Container()],
      ),
    ));

    // Verify that the PageView was created with 1 page.
    expect(find.byType(Container), findsNWidgets(1));
  });
}
