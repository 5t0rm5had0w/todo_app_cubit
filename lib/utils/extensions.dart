import 'package:intl/intl.dart';

import '../exports.dart';

extension SizedBoxExtensions on num {
  SizedBox get height => SizedBox(height: toDouble());

  SizedBox get width => SizedBox(width: toDouble());
}

extension CustomDateTimeString on String {

  // print(formatted); // Natija: 2025-05-09 18:15
  get formattedDate {
    // 2025-05-09T18:15
    DateTime tempDate = DateTime.parse(this);
    return DateFormat('MMM dd HH:mm').format(tempDate);
  }
}