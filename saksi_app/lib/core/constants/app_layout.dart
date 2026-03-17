import 'package:flutter/material.dart';

class AppLayout {
  static const double gutter = 24;

  static const double radiusSm = 12;
  static const double radiusMd = 16;
  static const double radiusLg = 20;
  static const double radiusXl = 24;

  static const BoxShadow cardShadow = BoxShadow(
    color: Color(0x0A000000),
    blurRadius: 30,
    offset: Offset(0, 8),
  );

  static const BoxShadow surfaceShadow = BoxShadow(
    color: Color(0x0D000000),
    blurRadius: 20,
    offset: Offset(0, 6),
  );

  static const BoxShadow headerShadow = BoxShadow(
    color: Color(0x0A000000),
    blurRadius: 16,
    offset: Offset(0, 2),
  );
}

