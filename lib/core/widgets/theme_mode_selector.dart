import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/theme/app_spacing.dart';
import '../../app/theme/app_text_styles.dart';
import '../../app/theme/theme_mode_provider.dart';
import '../extensions/context_extensions.dart';

/// A three-way Light / System / Dark segmented control backed by
/// [themeModeProvider]. Drop it into any settings/profile surface.
class ThemeModeSelector extends ConsumerWidget {
  const ThemeModeSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mode = ref.watch(themeModeProvider);
    final notifier = ref.read(themeModeProvider.notifier);

    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
        border: Border.all(color: context.colors.border),
      ),
      child: Row(
        children: [
          _Segment(
            label: 'Light',
            icon: Icons.light_mode_outlined,
            selected: mode == ThemeMode.light,
            onTap: () => notifier.set(ThemeMode.light),
          ),
          _Segment(
            label: 'System',
            icon: Icons.brightness_auto_outlined,
            selected: mode == ThemeMode.system,
            onTap: () => notifier.set(ThemeMode.system),
          ),
          _Segment(
            label: 'Dark',
            icon: Icons.dark_mode_outlined,
            selected: mode == ThemeMode.dark,
            onTap: () => notifier.set(ThemeMode.dark),
          ),
        ],
      ),
    );
  }
}

class _Segment extends StatelessWidget {
  const _Segment({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOut,
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
          decoration: BoxDecoration(
            gradient: selected ? context.colors.primaryGradient : null,
            borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 18,
                color: selected
                    ? context.colors.textInverse
                    : context.colors.textMuted,
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: AppTextStyles.labelMedium.copyWith(
                  color: selected
                      ? context.colors.textInverse
                      : context.colors.textSecondary,
                  fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
