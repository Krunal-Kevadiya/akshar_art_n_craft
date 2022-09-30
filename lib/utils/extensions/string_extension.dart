import 'package:flutter/material.dart';

extension ColorFromStringExtension on String {
  Color asColor() {
    var color = toUpperCase().replaceAll('#', '');
    if (color.length == 6) {
      color = 'FF$color';
    }
    return Color(int.parse(color, radix: 16));
  }

  String asInitialCharacter() {
    if (this != '') {
      final array = split(' ');
      if (array.length >= 2) {
        return '${array[0][0]}${array[1][0]}'.toUpperCase();
      }
      if (array.isNotEmpty) {
        return array[0][0].toUpperCase();
      }
    }
    return 'NA';
  }
}
