import '../exports.dart';

extension SizedBoxExtensions on num {
  SizedBox get height => SizedBox(height: toDouble());

  SizedBox get width => SizedBox(width: toDouble());
}
