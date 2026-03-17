import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_layout.dart';
import '../../core/constants/text_styles.dart';

class FilterPill extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback? onTap;
  final IconData? icon;

  const FilterPill({
    super.key,
    required this.label,
    required this.selected,
    this.onTap,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final bg = selected ? AppColors.textPrimary : Colors.white;
    final fg = selected ? Colors.white : Colors.grey[600]!;

    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(AppLayout.radiusSm),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppLayout.radiusSm),
        child: Ink(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(AppLayout.radiusSm),
            border: selected ? null : Border.all(color: Colors.grey[200]!),
            boxShadow: selected
                ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Icon(icon, size: 18, color: fg),
                const SizedBox(width: 8),
              ],
              Text(
                label,
                style: AppTextStyles.bodyMedium.copyWith(color: fg, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

