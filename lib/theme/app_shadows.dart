import 'package:flutter/material.dart';

abstract final class AppShadows {
  static const List<BoxShadow> card = [
    BoxShadow(color: Color(0x0D0F172A), blurRadius: 14, offset: Offset(0, 5)),
  ];

  static const List<BoxShadow> soft = [
    BoxShadow(color: Color(0x0A0F172A), blurRadius: 22, offset: Offset(0, 8)),
  ];

  static const List<BoxShadow> navigation = [
    BoxShadow(color: Color(0x1A0F172A), blurRadius: 28, offset: Offset(0, 10)),
  ];
}
