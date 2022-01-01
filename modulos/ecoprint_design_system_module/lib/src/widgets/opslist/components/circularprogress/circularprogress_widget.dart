import 'package:flutter/material.dart';

class CircularprogressWidget extends StatelessWidget {
  final double top;
  final double bottom;
  final double left;
  final double right;
  final double swidth;
  final double sheight;
  final double strok;
  final Color color;

  const CircularprogressWidget({
    Key? key,
    required this.top,
    required this.bottom,
    required this.left,
    required this.right,
    required this.swidth,
    required this.sheight,
    required this.strok,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: swidth,
      height: sheight,
      padding: EdgeInsets.fromLTRB(left, top, right, bottom),
      child: SizedBox(
        width: swidth,
        height: sheight,
        child: CircularProgressIndicator(
          strokeWidth: strok,
          valueColor: AlwaysStoppedAnimation(color),
        ),
      ),
    );
  }
}
