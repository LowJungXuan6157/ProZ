import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:integration_test/integration_test.dart';
import 'package:pro_z/pro_z.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('ProZDrawing App', () {
    testWidgets('Check ProZDrawingWidget is on screen', (WidgetTester tester) async {
      // Build your app here.
      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(360, 690),
          minTextAdapt: true,
          splitScreenMode: true,
          useInheritedMediaQuery: true,
          builder: (context, child) {
            return GetMaterialApp(
              home: Scaffold(
                body: ProZDrawingWidget(
                  borderColor: Colors.black,
                  lineColor: Colors.black,
                  isLoading: (bool isLoading) {},
                ),
              ),
            );
          },
        ),
      );
      expect(find.byType(ProZDrawingWidget), findsOneWidget);
    });
  });
}
