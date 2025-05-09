import '../exports.dart';

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Layer 1

    /// x
    double x = size.width;

    /// y
    double y = size.height;

    Paint paint_fill_0 = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    Path path_0 = Path();
    // path_0.moveTo(0, y);
    // path_0.lineTo(0, size.height - 80);
    // var start = Offset(10, 20);
    // var end = Offset(30, 10);
    // path_0.quadraticBezierTo(start.dx, start.dy, end.dx, end.dy);

    path_0.moveTo(0, y);
    path_0.lineTo(0, y * 0.08);
    path_0.quadraticBezierTo(x / 16, 0, x * 0.34, y * 0.1);
    path_0.quadraticBezierTo(x / 2, y * 0.14, x - (x * 0.34), y * 0.1);
    path_0.quadraticBezierTo(x - (x / 16), 0, x, y * 0.08);
    path_0.lineTo(x, y);
    path_0.close();

    // path_0.lineTo(0, y);
    // path_0.quadraticBezierTo(x/6, 0, x/6, y/9);

    // path_0.quadraticBezierTo(size.width * 0.1627714, size.height * 0.2884833, size.width * 0.2822857, size.height * 0.3183583);
    // path_0.quadraticBezierTo(size.width * 0.3738143, size.height * 0.3305000, size.width * 0.4981000, size.height * 0.3350500);
    // path_0.quadraticBezierTo(size.width * 0.6339286, size.height * 0.3284583, size.width * 0.7173857, size.height * 0.3159917);
    // path_0.quadraticBezierTo(size.width * 0.8323286, size.height * 0.2895750, size.width * 0.8928714, size.height * 0.2922167);
    // path_0.quadraticBezierTo(size.width * 0.9490429, size.height * 0.2905083, size.width, size.height * 0.3341667);
    // path_0.lineTo(size.width * 1.0028571, size.height * 1.0016667);
    // path_0.lineTo(size.width * 0.0042857, size.height * 1.0050000);
    //
    canvas.drawPath(path_0, paint_fill_0);

    // Layer 1

    Paint paint_stroke_0 = Paint()
      ..color = const Color.fromARGB(255, 33, 150, 243)
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    canvas.drawPath(path_0, paint_stroke_0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
