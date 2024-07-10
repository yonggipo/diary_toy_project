import 'package:flutter/material.dart';

extension ColorUtils on Color {
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) {
      buffer.write('FF');
      buffer.write(hexString.replaceFirst('#', ''));
    } else if (hexString.length == 8 || hexString.length == 9) {
      buffer.write(hexString.replaceFirst('#', ''));
    } else {
      throw ArgumentError('Invalid hex color format');
    }
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
