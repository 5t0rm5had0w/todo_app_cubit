import 'dart:ui';

import '../exports.dart';

Widget showMyProgress() {
  return BackdropFilter(
    filter: ImageFilter.blur(sigmaY: 2, sigmaX: 2),
    child: Container(
      alignment: Alignment.center,
      // color: Colors.black.withValues(alpha: 0.0),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              color: Colors.greenAccent,
              blurRadius: 150,
              spreadRadius: 1,
              blurStyle: BlurStyle.normal,
            ),
          ],
          color: Colors.greenAccent.withValues(alpha: 0.8),
          borderRadius: BorderRadius.circular(12),
        ),
        child: CircularProgressIndicator(),
      ),
    ),
  );
}
