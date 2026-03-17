import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_layout.dart';

enum CardPadding { none, sm, md, lg }

class CustomCard extends StatelessWidget {
  final Widget child;
  final CardPadding padding;
  final bool interactive;
  final VoidCallback? onTap;
  final BorderRadius? borderRadius;

  const CustomCard({
    super.key,
    required this.child,
    this.padding = CardPadding.md,
    this.interactive = false,
    this.onTap,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    EdgeInsetsGeometry edgeInsets;
    switch (padding) {
      case CardPadding.none:
        edgeInsets = EdgeInsets.zero;
        break;
      case CardPadding.sm:
        edgeInsets = const EdgeInsets.all(16.0);
        break;
      case CardPadding.md:
        edgeInsets = const EdgeInsets.all(24.0);
        break;
      case CardPadding.lg:
        edgeInsets = const EdgeInsets.all(32.0);
        break;
    }

    final radius = borderRadius ?? BorderRadius.circular(AppLayout.radiusXl);

    final cardContent = Material(
      color: Colors.white,
      borderRadius: radius,
      child: Ink(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: radius,
          border: Border.all(color: AppColors.borderLight),
          boxShadow: const [AppLayout.cardShadow],
        ),
        child: Padding(
          padding: edgeInsets,
          child: child,
        ),
      ),
    );

    if (interactive || onTap != null) {
      return MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Material(
          color: Colors.transparent,
          borderRadius: radius,
          child: InkWell(
            onTap: onTap,
            borderRadius: radius,
            child: cardContent,
          ),
        ),
      );
    }

    return cardContent;
  }
}
