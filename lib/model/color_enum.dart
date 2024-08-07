import 'package:flutter/material.dart';

enum BackgroundColorEnum { white, orange, blue, green, peach }

extension BackgroundColorEnumX on BackgroundColorEnum {
  int getColor() {
    switch (this) {
      case BackgroundColorEnum.white:
        return Colors.white.value;
      case BackgroundColorEnum.orange:
        return Color(0xffffa447).value;
      case BackgroundColorEnum.blue:
        return Color(0xff7ecbff).value;
      case BackgroundColorEnum.green:
        return Color(0xff1eccc3).value;
      case BackgroundColorEnum.peach:
        return Color(0xffffa3a3).value;
    }
  }
}
