import 'package:flutter_test/flutter_test.dart';
import 'package:pro_z/pro_z.dart';

void main() {
  group('RatingWidget', () {
    test('Initial value should be correctly set', () {
      final ratingWidget = RatingWidget(
        onChanged: (_) {},
        initialValue: 2,
      );

      expect(ratingWidget.initialValue, 2);
    });
  });
}
