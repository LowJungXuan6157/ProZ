import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ProZDrawingWidget extends StatefulWidget {
  final Color borderColor, lineColor;
  final Color? background;
  final double borderRadius, lineWidth, height, width;
  final EdgeInsetsGeometry padding, margin;
  final Function(Uint8List?)? onChanged;
  final Function(bool) isLoading;
  final Function()? onClear;

  const ProZDrawingWidget({
    Key? key,
    this.borderColor = Colors.black,
    this.lineColor = Colors.black,
    this.lineWidth = 5.0,
    this.borderRadius = 10,
    this.height = 300,
    this.width = double.infinity,
    this.padding = EdgeInsets.zero,
    this.margin = EdgeInsets.zero,
    this.onChanged,
    this.background,
    required this.isLoading,
    this.onClear,
  }) : super(key: key);

  @override
  State<ProZDrawingWidget> createState() => _ProZDrawingWidgetState();
}

class _ProZDrawingWidgetState extends State<ProZDrawingWidget> {
  final GlobalKey _globalKey = GlobalKey();
  List<DrawnLine> lines = <DrawnLine>[];
  late DrawnLine line;

  StreamController<List<DrawnLine>> linesStreamController = StreamController<List<DrawnLine>>.broadcast();
  StreamController<DrawnLine> currentLineStreamController = StreamController<DrawnLine>.broadcast();

  @override
  void initState() {
    line = DrawnLine([Offset.zero], widget.lineColor, widget.lineWidth);
    super.initState();
  }

  update() async {
    widget.isLoading(true);
    final result = await Future.delayed(const Duration(seconds: 1), () async {
      ui.Image image = await (_globalKey.currentContext?.findRenderObject() as RenderRepaintBoundary).toImage();
      ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List? pngBytes = byteData?.buffer.asUint8List();
      widget.isLoading(false);
      return pngBytes;
    });
    if (widget.onChanged != null) {
      widget.onChanged!(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: widget.padding,
      margin: widget.margin,
      height: widget.height,
      width: widget.width,
      decoration: BoxDecoration(
        color: widget.background,
        border: Border.all(color: widget.borderColor),
        borderRadius: BorderRadius.circular(widget.borderRadius),
      ),
      child: ClipRRect(
        child: Stack(
          children: [
            // all line
            RepaintBoundary(
              key: _globalKey,
              child: Container(
                padding: const EdgeInsets.all(4.0),
                alignment: Alignment.topLeft,
                child: StreamBuilder<List<DrawnLine>>(
                  stream: linesStreamController.stream,
                  builder: (context, snapshot) {
                    return CustomPaint(painter: MyPainter(lines: lines));
                  },
                ),
              ),
            ),
            // current line
            GestureDetector(
              onPanStart: (details) {
                setState(() {
                  RenderBox box = context.findRenderObject() as RenderBox;
                  Offset point = box.globalToLocal(details.globalPosition);
                  line = DrawnLine([point], widget.lineColor, widget.lineWidth);
                });
              },
              onPanUpdate: (details) {
                setState(() {
                  RenderBox box = context.findRenderObject() as RenderBox;
                  Offset point = box.globalToLocal(details.globalPosition);
                  List<Offset> path = List.from(line.path)..add(point);
                  line = DrawnLine(path, widget.lineColor, widget.lineWidth);
                  currentLineStreamController.add(line);
                });
              },
              onPanEnd: (details) {
                setState(() {
                  lines = List.from(lines)..add(line);
                  linesStreamController.add(lines);
                  update();
                });
              },
              child: RepaintBoundary(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  padding: const EdgeInsets.all(4.0),
                  color: Colors.transparent,
                  alignment: Alignment.topLeft,
                  child: StreamBuilder<DrawnLine>(
                    stream: currentLineStreamController.stream,
                    builder: (context, snapshot) {
                      return CustomPaint(painter: MyPainter(lines: [line]));
                    },
                  ),
                ),
              ),
            ),
            Positioned(
              right: 0,
              child: IconButton(
                onPressed: () {
                  setState(() {
                    lines = [];
                    line = DrawnLine([Offset.zero], widget.lineColor, widget.lineWidth);
                    if (widget.onClear != null) widget.onClear!();
                    if (widget.onChanged != null) widget.onChanged!(null);
                  });
                },
                icon: const Icon(Icons.clear),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  final List<DrawnLine> lines;

  MyPainter({required this.lines});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.redAccent
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5.0;

    for (int i = 0; i < lines.length; ++i) {
      for (int j = 0; j < lines[i].path.length - 1; ++j) {
        paint.color = lines[i].color;
        paint.strokeWidth = lines[i].width;
        canvas.drawLine(lines[i].path[j], lines[i].path[j + 1], paint);
      }
    }
  }

  @override
  bool shouldRepaint(MyPainter oldDelegate) => true;
}

class DrawnLine {
  final List<Offset> path;
  final Color color;
  final double width;

  DrawnLine(this.path, this.color, this.width);
}
