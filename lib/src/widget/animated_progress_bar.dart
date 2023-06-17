import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProZAnimatedProgressBar extends StatefulWidget {
  final RxDouble percent;
  final Color backgroundColor;
  final Color progressColor;
  final double height;
  final double width;
  final double borderRadius;

  const ProZAnimatedProgressBar({
    super.key,
    required this.percent,
    this.backgroundColor = Colors.grey,
    this.progressColor = const Color(0xffd3af37),
    this.height = 10,
    this.width = 300,
    this.borderRadius = 12,
  });

  @override
  State<ProZAnimatedProgressBar> createState() => _ProZAnimatedProgressBarState();
}

class _ProZAnimatedProgressBarState extends State<ProZAnimatedProgressBar> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Center(
        child: Stack(
          children: [
            Container(
              width: widget.width,
              height: widget.height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(widget.borderRadius.r),
                color: Colors.grey,
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: widget.percent / 100 * widget.width,
              height: widget.height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(widget.borderRadius.r),
                color: widget.progressColor,
              ),
            ),
          ],
        ),
      );
    });
  }
}
