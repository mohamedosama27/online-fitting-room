import 'package:flutter/material.dart';

class CurvePainter extends CustomPainter {
  Color firstColor;
  Color secondColor;
  int splitAt;
  CurvePainter(firstColor,secondColor,splitAt){
    this.firstColor=firstColor;
    this.secondColor=secondColor;
    this.splitAt=splitAt;
  }
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = firstColor;
    paint.style = PaintingStyle.fill;
    paint.strokeWidth= size.height;
    var paint2 = Paint();
    paint2.color = secondColor;
    paint2.style = PaintingStyle.fill;
    paint2.strokeWidth= size.height;

    canvas.drawLine(Offset(0,0), Offset(size.width/splitAt,0), paint);
    canvas.drawLine(Offset(size.width/splitAt,0), Offset(size.width,0), paint2);

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}