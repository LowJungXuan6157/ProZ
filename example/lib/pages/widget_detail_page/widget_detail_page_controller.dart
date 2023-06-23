import 'package:get/get.dart';

class WidgetDetailPageController extends GetxController {
  final WidgetDetailPageState state = WidgetDetailPageState();
  
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
}

class WidgetDetailPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WidgetDetailPageController());
  }
}

class WidgetDetailPageState {
  WidgetDetailPageState() {
    ///Initialize variables
  }
}