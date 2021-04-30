
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class backGroundCurve extends CustomPainter {

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.style = PaintingStyle.fill;
    paint.strokeWidth= size.height;
    paint.shader=ui.Gradient.linear(Offset(size.width*0.85, 0), Offset(size.width*0.85, size.height), [Colors.black,Color(0xFF9F140B)]);
    Path path = Path();
    path.moveTo(size.width*0.7, 0);
    path.quadraticBezierTo(size.width, size.height/2, size.width*0.7, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    canvas.drawPath(path, paint);

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}