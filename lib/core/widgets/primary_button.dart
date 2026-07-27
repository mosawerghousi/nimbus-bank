import 'dart:ui';

import 'package:flutter/material.dart';

import '../extensions/context_extensions.dart';
import '../../app/theme/app_spacing.dart';
import '../../app/theme/app_text_styles.dart';

enum PrimaryButtonVariant { primary, subtle, ghost }

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = PrimaryButtonVariant.primary,
    this.icon,
    this.expanded = true,
    this.height = 58,
  });

  final String label;
  final VoidCallback? onPressed;
  final PrimaryButtonVariant variant;
  final IconData? icon;
  final bool expanded;
  final double height;

  @override
  Widget build(BuildContext context) {
    final isPrimary = variant == PrimaryButtonVariant.primary;

    final BoxDecoration decoration;
    final Color foreground;

    if (isPrimary) {
      decoration = BoxDecoration(
        gradient: context.colors.primaryGradient,
        borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
        boxShadow: [
          BoxShadow(
            color: context.colors.primary.withValues(alpha: 0.28),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      );
      foreground = context.colors.textInverse;
    } else if (variant == PrimaryButtonVariant.subtle) {
      decoration = BoxDecoration(
        color: context.colors.textPrimary,
        borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
      );
      // NOT textInverse: that's fixed white for use on primaryGradient fills.
      // This surface is textPrimary-colored (near-white in dark theme, near-black
      // in light theme), so background is the color that actually contrasts here.
      foreground = context.colors.background;
    } else {
      decoration = BoxDecoration(
        color: Colors.transparent,
        border: Border.all(color: context.colors.border, width: 1),
        borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
      );
      foreground = context.colors.textPrimary;
    }

    final child = Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
        onTap: onPressed,
        child: Container(
          height: height,
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
          decoration: decoration,
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: AppTextStyles.labelLarge.copyWith(
                  color: foreground,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.3,
                ),
              ),
              if (icon != null) ...[
                const SizedBox(width: AppSpacing.sm),
                Icon(icon, color: foreground, size: 18),
              ],
            ],
          ),
        ),
      ),
    );

    if (expanded) return SizedBox(width: double.infinity, child: child);
    return child;
  }
}

class CircleIconButton extends StatelessWidget {
  const CircleIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.size = 44,
    this.background,
    this.iconColor,
    this.borderColor,
    this.frosted = true,
  });

  final IconData icon;
  final VoidCallback? onPressed;
  final double size;
  final Color? background;
  final Color? iconColor;
  final Color? borderColor;

  /// When true, applies a backdrop blur so the button reads as
  /// glassmorphic over hero imagery.
  final bool frosted;

  @override
  Widget build(BuildContext context) {
    final button = Material(
      color: background ?? context.colors.glass,
      shape: CircleBorder(
        side: BorderSide(
          color: borderColor ?? context.colors.border,
          width: 1,
        ),
      ),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onPressed,
        child: SizedBox(
          width: size,
          height: size,
          child: Icon(
            icon,
            color: iconColor ?? context.colors.textPrimary,
            size: 20,
          ),
        ),
      ),
    );

    if (!frosted) return button;

    return ClipOval(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
        child: DecoratedBox(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.18),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: button,
        ),
      ),
    );
  }
}
