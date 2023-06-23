import 'package:example/app.dart';
import 'package:flutter/material.dart';
import 'package:pro_z/pro_z.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: ProZDrawingWidget(isLoading: print),
      ),
    );
  }
}
