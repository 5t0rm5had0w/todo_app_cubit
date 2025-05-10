import '../../../exports.dart';

const Color colorPrimary = Color(0xFF2BA2F3);
const Color colorBackground = Color(0xFFFAFAFA);
const Color colorGrey = Color(0xFF808080);
const Color colorLightGrey = Color(0xFFF1F1F3);

const List<List<Color>> gradientColors = [
  [Color(0xFFFF1B6B), Color(0xFFD91D5B)],
  [Color(0xFF6E78FF), Color(0xFF5E66D8)],
  [Color(0xFF5FC52E), Color(0xFF51A72A)],
  [Color(0xFFF7C2E6), Color(0xFFD2A5C4)],
  [Color(0xFF8752A3), Color(0xFF73468A)],
  [Color(0xFFD7930D), Color(0xFFFF930F)],
  [Color(0xFF595CFF), Color(0xFF4C4E98)],
  [Color(0xFFB6F3C9), Color(0xFF9ACFCB)],
  [Color(0xFF6F7BF7), Color(0xFF5E6FDC)],
  [Color(0xFF103783), Color(0xFF0E2F6F)],
  [Color(0xFF0061FF), Color(0xFF0052D8)],
  [Color(0xFF0974F1), Color(0xFF0863CD)],
  [Color(0xFFE2DB1F), Color(0xFFBEBE1A)],
  [Color(0xFF586AA3), Color(0xFF0965C0)],
  [Color(0xFFF28367), Color(0xFFCD6F58)],
  [Color(0xFF0ED3CE), Color(0xFF11D3F3)],
];

List<Color> getRandomColor(int index) {
  return gradientColors[index % gradientColors.length];
}
