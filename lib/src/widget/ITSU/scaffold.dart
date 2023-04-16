import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProZScaffold extends StatefulWidget {
  const ProZScaffold({
    Key? key,
    required this.appBar,
    required this.body,
    this.isCurve = false,
    this.backgroundColor = Colors.white,
    this.fab,
    this.bottomNavigationBar,
  }) : super(key: key);
  final PreferredSizeWidget appBar;
  final Widget body;
  final bool isCurve;
  final Color backgroundColor;
  final Widget? fab, bottomNavigationBar;

  //passing the required options for hamburger

  @override
  State<ProZScaffold> createState() => _ProZScaffoldState();
}

class _ProZScaffoldState extends State<ProZScaffold> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Positioned(
          top: 0,
          height: 0.40.sh,
          child: Image.asset(
            "assets/images/appbar_background.png",
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.transparent,
            /* endDrawerEnableOpenDragGesture: false,
            //to open drawer
            endDrawer:
                widget.hamburger == true ? drawerColumn(widget.options) : null,*/
            appBar: widget.appBar,
            body: Container(
              width: 1.sw,
              height: double.infinity,
              decoration: BoxDecoration(
                color: widget.backgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: widget.isCurve ? Radius.circular(30.r) : Radius.zero,
                  topRight: widget.isCurve ? Radius.circular(30.r) : Radius.zero,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: widget.isCurve ? Radius.circular(30.r) : Radius.zero,
                  topRight: widget.isCurve ? Radius.circular(30.r) : Radius.zero,
                ),
                child: widget.body,
              ),
            ),
            floatingActionButtonLocation: ExpandableFab.location,
            floatingActionButton: widget.fab,
            bottomNavigationBar: widget.bottomNavigationBar,
          ),
        ),
      ],
    );
  }
}