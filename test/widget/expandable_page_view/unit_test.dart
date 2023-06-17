import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pro_z/pro_z.dart';

void main() {
  test('ProZExpandablePageView initialPage Test', () {
    final pageController = PageController();
    final testWidget = ProZExpandablePageView(
      initialPage: 1,
      pageController: pageController,
      children: [Container(), Container()],
    );

    expect(testWidget.initialPage, 1);
  });
}
