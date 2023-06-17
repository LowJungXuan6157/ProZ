import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:pro_z/pro_z.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets("Integration Test for ProZExpandablePageView", (WidgetTester tester) async {
    final pageController = PageController();

    await tester.pumpWidget(MaterialApp(
      home: ProZExpandablePageView(
        initialPage: 0,
        pageController: pageController, // use the same pageController here
        children: [Container(), Container()],
      ),
    ));

    // verify if ProZExpandablePageView is found
    expect(find.byType(ProZExpandablePageView), findsOneWidget);

    // swipe page view
    await tester.drag(find.byType(ProZExpandablePageView), const Offset(-400.0, 0.0));
    await tester.pumpAndSettle();

    // after swiping, the controller's page should be 1
    expect(pageController.page?.round(), 1); // now it should work
  });
}
