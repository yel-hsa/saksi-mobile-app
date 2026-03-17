import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/text_styles.dart';

enum BadgeVariant { success, warning, danger, info, neutral }
enum BadgeSize { sm, md }

class StatusBadge extends StatelessWidget {
  final String text;
  final BadgeVariant variant;
  final BadgeSize size;

  const StatusBadge({
    super.key,
    required this.text,
    this.variant = BadgeVariant.neutral,
    this.size = BadgeSize.md,
  });

  @override
  Widget build(BuildContext context) {
    Color bgColor;
    Color textColor;
    Color borderColor;

    switch (variant) {
      case BadgeVariant.success:
        bgColor = AppColors.successBg;
        textColor = AppColors.successText;
        borderColor = AppColors.successBorder;
        break;
      case BadgeVariant.warning:
        bgColor = AppColors.warningBg;
        textColor = AppColors.warningText;
        borderColor = AppColors.warningBorder;
        break;
      case BadgeVariant.danger:
        bgColor = const Color(0xFFFEF2F2); // red-50
        textColor = AppColors.alertRed;
        borderColor = const Color(0xFFFECACA); // red-200
        break;
      case BadgeVariant.info:
        bgColor = AppColors.infoBg;
        textColor = AppColors.infoText;
        borderColor = AppColors.infoBorder;
        break;
      case BadgeVariant.neutral:
        bgColor = AppColors.surfaceMuted;
        textColor = AppColors.textSecondary;
        borderColor = AppColors.borderLight;
        break;
    }

    double fontSize;
    double verticalPadding;
    double horizontalPadding;
    double borderRadius;

    switch (size) {
      case BadgeSize.sm:
        fontSize = 10;
        verticalPadding = 2;
        horizontalPadding = 8;
        borderRadius = 6;
        break;
      case BadgeSize.md:
        fontSize = 11;
        verticalPadding = 4;
        horizontalPadding = 10;
        borderRadius = 8;
        break;
    }

    return DecoratedBox(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color: borderColor),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: verticalPadding,
          horizontal: horizontalPadding,
        ),
        child: Text(
          text.toUpperCase(),
          style: AppTextStyles.baseStyle.copyWith(
            color: textColor,
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
      ),
    );
  }
}
