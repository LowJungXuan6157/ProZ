import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'widget_detail_page_controller.dart';

class WidgetDetailPagePage extends GetView<WidgetDetailPageController> {
  const WidgetDetailPagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text('WidgetDetailPage Page'),
      ),
    );
  }
}