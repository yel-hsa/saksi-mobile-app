import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTextStyles {
  static TextStyle get baseStyle => GoogleFonts.inter(
        color: AppColors.textPrimary,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      );

  static TextStyle get heading1 => GoogleFonts.inter(
        color: AppColors.textPrimary,
        fontSize: 24,
        fontWeight: FontWeight.w900,
      );

  static TextStyle get heading2 => GoogleFonts.inter(
        color: AppColors.textPrimary,
        fontSize: 20,
        fontWeight: FontWeight.w900,
      );

  static TextStyle get heading3 => GoogleFonts.inter(
        color: AppColors.textPrimary,
        fontSize: 18,
        fontWeight: FontWeight.w900,
      );

  static TextStyle get bodyLarge => GoogleFonts.inter(
        color: AppColors.textPrimary,
        fontSize: 15,
        fontWeight: FontWeight.w500,
      );

  static TextStyle get bodyMedium => GoogleFonts.inter(
        color: AppColors.textPrimary,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      );

  static TextStyle get bodySmall => GoogleFonts.inter(
        color: AppColors.textSecondary,
        fontSize: 12,
        fontWeight: FontWeight.w500,
      );

  static TextStyle get labelCaps => GoogleFonts.inter(
        color: Colors.grey[400],
        fontSize: 11,
        fontWeight: FontWeight.w700,
        letterSpacing: 3,
      );

  static TextStyle get navLabel => GoogleFonts.inter(
        color: AppColors.textPrimary,
        fontSize: 12,
        fontWeight: FontWeight.w600,
      );

  static TextStyle get buttonLabel => GoogleFonts.inter(
        color: Colors.white,
        fontSize: 13,
        fontWeight: FontWeight.w700,
      );

  static TextStyle get decibelDisplay => GoogleFonts.inter(
        color: AppColors.textPrimary,
        fontSize: 48,
        fontWeight: FontWeight.w800,
      );
}
