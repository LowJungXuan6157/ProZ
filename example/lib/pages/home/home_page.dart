import 'package:flutter/material.dart';
import 'package:pro_z/pro_z.dart';

import 'home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pro Z SDK'),
      ),
      body: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: controller.mainList.length,
        itemBuilder: (ctx, index) {
          final item = controller.mainList[index];
          return ListTile(
            title: Text("${item.name}"),
            trailing: const Icon(Icons.arrow_forward_ios_rounded),
            onTap: controller.onSelected,
          );
        },
      ),
    );
  }
}
