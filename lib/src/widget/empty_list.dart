import 'package:flutter/cupertino.dart';

class EmptyList extends StatelessWidget {
  const EmptyList({
    Key? key,
    required this.imageUrl,
    required this.text,
    this.fontColor,
  }) : super(key: key);

  final String imageUrl;
  final Color? fontColor;
  final Text text;

  @override
  Widget build(BuildContext context) {
    return Align(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(image: AssetImage(imageUrl), width: 180),
            const SizedBox(
              height: 20,
            ),
            text
          ],
        ),
      ),
    );
  }
}
