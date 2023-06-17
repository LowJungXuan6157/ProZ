import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:pro_z/pro_z.dart';

void main() {
  group('DrawnLine', () {
    test('Properties should be correctly instantiated', () {
      final path = [Offset.zero];
      const color = Colors.red;
      const width = 5.0;
      final drawnLine = DrawnLine(path, color, width);

      expect(drawnLine.path, path);
      expect(drawnLine.color, color);
      expect(drawnLine.width, width);
    });
  });
}
