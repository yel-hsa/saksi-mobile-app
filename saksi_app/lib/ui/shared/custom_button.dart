import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/text_styles.dart';

enum ButtonVariant { primary, secondary, outline, ghost }
enum ButtonSize { sm, md, lg }

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final ButtonVariant variant;
  final ButtonSize size;
  final bool fullWidth;
  final Widget? icon;

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.variant = ButtonVariant.primary,
    this.size = ButtonSize.md,
    this.fullWidth = false,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    Color bgColor;
    Color textColor;
    BorderSide border = BorderSide.none;
    List<BoxShadow> shadow = [];

    switch (variant) {
      case ButtonVariant.primary:
        bgColor = AppColors.alertRed;
        textColor = Colors.white;
        shadow = [
          BoxShadow(
            color: AppColors.alertRed.withOpacity(0.25),
            blurRadius: 20,
            offset: const Offset(0, 8),
          )
        ];
        break;
      case ButtonVariant.secondary:
        bgColor = AppColors.textPrimary;
        textColor = Colors.white;
        shadow = [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ];
        break;
      case ButtonVariant.outline:
        bgColor = Colors.white;
        textColor = AppColors.textPrimary;
        border = const BorderSide(color: AppColors.borderLight, width: 2);
        break;
      case ButtonVariant.ghost:
        bgColor = Colors.transparent;
        textColor = Color(0xFF4B5563);
        break;
    }

    double verticalPadding;
    double horizontalPadding;
    double fontSize;
    double borderRadius;
    double gap;

    switch (size) {
      case ButtonSize.sm:
        verticalPadding = 8;
        horizontalPadding = 16;
        fontSize = 12;
        borderRadius = 8;
        gap = 6;
        break;
      case ButtonSize.md:
        verticalPadding = 14;
        horizontalPadding = 24;
        fontSize = 13;
        borderRadius = 12;
        gap = 8;
        break;
      case ButtonSize.lg:
        verticalPadding = 16;
        horizontalPadding = 32;
        fontSize = 15;
        borderRadius = 16;
        gap = 12;
        break;
    }

    Widget content = Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (icon != null) ...[
          icon!,
          SizedBox(width: gap),
        ],
        Text(
          text,
          style: AppTextStyles.baseStyle.copyWith(
            color: textColor,
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );

    return SizedBox(
      width: fullWidth ? double.infinity : null,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(borderRadius),
          border: border != BorderSide.none ? Border.fromBorderSide(border) : null,
          boxShadow: shadow,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onPressed,
            borderRadius: BorderRadius.circular(borderRadius),
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: verticalPadding,
                horizontal: horizontalPadding,
              ),
              child: content,
            ),
          ),
        ),
      ),
    );
  }
}
