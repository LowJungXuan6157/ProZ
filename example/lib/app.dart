import 'package:example/constant/theme.dart';
import 'package:example/pages/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:pro_z/pro_z.dart';

import 'pages/home/home_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      useInheritedMediaQuery: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: CustomThemeData.light(),
          home: const HomePage(),
          initialBinding: HomeBinding(),
        );
      },
    );
  }
}
