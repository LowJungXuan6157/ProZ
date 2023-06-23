import 'package:example/model/home.dart';
import 'package:pro_z/pro_z.dart';

class HomeController extends GetxController {
  final HomeState state = HomeState();
  final mainList = [
    Home(
      name: 'Animated Progress Bar',
      path: '',
    ),
  ];

  @override
  void onInit() {
    // Ideal place to initialize your variables or start API calls.
    super.onInit();
  }

  @override
  void onReady() {
    // Run anything that needs to happen after all initializations are done.
    super.onReady();
  }

  @override
  void onClose() {
    // Clean up resources like listeners or streams.
    super.onClose();
  }

  void onSelected() {
    // Get.to(WidgetDetailPagePage(), binding: WidgetDetailPageBinding());
  }
}

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
  }
}

class HomeState {
  HomeState() {
    ///Initialize variables
  }
}
