import 'dart:math';
import 'dart:math' as Math;
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:teamdrt/config/pallete.dart';

// ignore: camel_case_types
class bgPainter extends CustomPainter{
  bgPainter({
    Animation<double> animation
  }):
        bluePaint=Paint()..color=Palette.lightBlue
          ..style = PaintingStyle.fill,
        blueAnim = CurvedAnimation(
          parent: animation,
          curve: const SpringCurve(),
          reverseCurve: Curves.easeInCirc,
        ),
        liquidAnim = CurvedAnimation(
          curve: Curves.elasticOut,
          reverseCurve: Curves.easeInBack,
          parent: animation,
        ),
  super(repaint: animation);

  final Animation<double> liquidAnim;
  final Animation<double> blueAnim;

  final Paint bluePaint;

  @override
  void paint(Canvas canvas, Size size) {
    paintBLue(canvas, size);
    paintBLue2(canvas, size);
  }


  num degToRad(num deg) => deg * (Math.pi / 180.0);


  void paintBLue(Canvas canvas, Size size){
    final path=Path();
    path.lineTo(0, size.height/3);
    path.quadraticBezierTo(0, size.height/4-250,size.width/1.5, 0);
    canvas.drawPath(path, bluePaint);
  }

  void paintBLue2(Canvas canvas, Size size){
    final path=Path();
    path.moveTo(0, size.height/1.4);
    path.quadraticBezierTo(size.width/3, size.height,size.width/1.08, size.height-50);
    path.lineTo(0, size.height);
    path.moveTo(0, size.height);
    path.lineTo(size.width/2,size.height);
    canvas.drawPath(path, bluePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    throw true;
  }

  void _addPointsToPath(Path path, List<Point> points) {
    if (points.length < 3) {
      throw UnsupportedError('Need three or more points to create a path.');
    }

    for (var i = 0; i < points.length - 2; i++) {
      final xc = (points[i].x + points[i + 1].x) / 2;
      final yc = (points[i].y + points[i + 1].y) / 2;
      path.quadraticBezierTo(points[i].x, points[i].y, xc, yc);
    }

    // connect the last two points
    path.quadraticBezierTo(
        points[points.length - 2].x,
        points[points.length - 2].y,
        points[points.length - 1].x,
        points[points.length - 1].y);
  }
}

class Point {
  final double x;
  final double y;

  Point(this.x, this.y);
}

class SpringCurve extends Curve {
  const SpringCurve({
    this.a = 0.15,
    this.w = 19.4,
  });
  final double a;
  final double w;

  @override
  double transformInternal(double t) {
    return (-(pow(e, -t / a) * cos(t * w)) + 1).toDouble();
  }
}