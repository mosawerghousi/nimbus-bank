import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_text_styles.dart';

/// An icon chip + label used in the dashboard's quick-actions row
/// (Send, Request, Top up, More).
class QuickActionButton extends StatelessWidget {
  const QuickActionButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    this.filled = false,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  /// When true, renders the icon chip filled with [ColorTokens.primaryGradient]
  /// instead of a plain surface tile — used to draw attention to the
  /// primary action (Send).
  final bool filled;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
          child: InkWell(
            borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
            onTap: onTap,
            child: Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                gradient: filled ? context.colors.primaryGradient : null,
                color: filled ? null : context.colors.surface,
                shape: BoxShape.circle,
                border: filled
                    ? null
                    : Border.all(color: context.colors.border),
              ),
              child: Icon(
                icon,
                size: 22,
                color: filled
                    ? context.colors.textInverse
                    : context.colors.textPrimary,
              ),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          label,
          style: AppTextStyles.labelMedium.copyWith(
            color: context.colors.textSecondary,
          ),
        ),
      ],
    );
  }
}
