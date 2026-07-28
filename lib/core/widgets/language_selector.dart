import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/localization/locale_provider.dart';
import '../../app/theme/app_spacing.dart';
import '../../app/theme/app_text_styles.dart';
import '../extensions/context_extensions.dart';

/// A three-way English / العربية / دری segmented control backed by
/// [localeProvider]. Drop it into any settings/profile surface. Mirrors
/// [ThemeModeSelector]'s structure exactly.
class LanguageSelector extends ConsumerWidget {
  const LanguageSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localeProvider);
    final notifier = ref.read(localeProvider.notifier);

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
            label: context.strings.languageEnglish,
            icon: Icons.public_rounded,
            selected: locale.languageCode == 'en',
            onTap: () => notifier.set(const Locale('en')),
          ),
          _Segment(
            label: context.strings.languageArabic,
            icon: Icons.translate_rounded,
            selected: locale.languageCode == 'ar',
            onTap: () => notifier.set(const Locale('ar')),
          ),
          _Segment(
            label: context.strings.languageDari,
            icon: Icons.language_rounded,
            selected: locale.languageCode == 'fa',
            onTap: () => notifier.set(const Locale('fa', 'AF')),
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
