import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:integration_test/integration_test.dart';
import 'package:pro_z/pro_z.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Check ProZAnimatedProgressBar is on screen and updates', (WidgetTester tester) async {
    final progress = 0.0.obs;
    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        useInheritedMediaQuery: true,
        builder: (context, child) {
          return GetMaterialApp(
            home: Scaffold(
              body: ProZAnimatedProgressBar(
                percent: progress,
              ),
            ),
          );
        },
      ),
    );

    // Verify that the progress bar is on the screen
    expect(find.byType(ProZAnimatedProgressBar), findsOneWidget);

    // Update the value
    progress.value = 50;
    await tester.pumpAndSettle();

    // Verify that the widget updates
    final progressBar = tester.widget<ProZAnimatedProgressBar>(find.byType(ProZAnimatedProgressBar));
    expect(progressBar.percent.value, equals(50));
  });
}
