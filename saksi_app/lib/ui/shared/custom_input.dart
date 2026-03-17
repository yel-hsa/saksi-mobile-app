import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/text_styles.dart';

class CustomInput extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final Widget? leftIcon;
  final Widget? rightIcon;
  final String? errorText;
  final bool obscureText;
  final TextInputType keyboardType;

  const CustomInput({
    super.key,
    required this.hintText,
    this.controller,
    this.leftIcon,
    this.rightIcon,
    this.errorText,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          style: AppTextStyles.bodyLarge.copyWith(fontWeight: FontWeight.w500),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: AppTextStyles.bodyLarge.copyWith(color: Colors.grey[400]),
            prefixIcon: leftIcon != null
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: IconTheme(
                      data: IconThemeData(color: Colors.grey[400], size: 20),
                      child: leftIcon!,
                    ),
                  )
                : null,
            suffixIcon: rightIcon != null
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: IconTheme(
                      data: IconThemeData(color: Colors.grey[400], size: 20),
                      child: rightIcon!,
                    ),
                  )
                : null,
            prefixIconConstraints: const BoxConstraints(minWidth: 40, minHeight: 40),
            suffixIconConstraints: const BoxConstraints(minWidth: 40, minHeight: 40),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: errorText != null ? AppColors.alertRed : Colors.grey[200]!, width: 2),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: errorText != null ? AppColors.alertRed : Colors.grey[200]!, width: 2),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: errorText != null ? AppColors.alertRed : AppColors.textPrimary, width: 2),
            ),
          ),
        ),
        if (errorText != null) ...[
          const SizedBox(height: 6),
          Padding(
            padding: const EdgeInsets.only(left: 4.0),
            child: Text(
              errorText!,
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.alertRed,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
