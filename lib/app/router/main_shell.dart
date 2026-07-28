import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/extensions/context_extensions.dart';
import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';

class MainShell extends StatelessWidget {
  const MainShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  static const _icons = <IconData>[
    Icons.home_rounded,
    Icons.credit_card_rounded,
    Icons.receipt_long_rounded,
    Icons.person_rounded,
  ];

  List<String> _labels(BuildContext context) => [
        context.strings.navHome,
        context.strings.navCards,
        context.strings.navActivity,
        context.strings.navProfile,
      ];

  void _onTap(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    final labels = _labels(context);
    return Scaffold(
      extendBody: true,
      backgroundColor: context.colors.background,
      body: navigationShell,
      bottomNavigationBar: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.md,
            0,
            AppSpacing.md,
            AppSpacing.md,
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.xs,
              vertical: AppSpacing.xs,
            ),
            decoration: BoxDecoration(
              color: context.colors.surface,
              borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
              border: Border.all(color: context.colors.border),
              boxShadow: [
                BoxShadow(
                  color: context.colors.scrim.withValues(alpha: 0.4),
                  blurRadius: 24,
                  offset: const Offset(0, 12),
                ),
              ],
            ),
            child: Row(
              children: List.generate(_icons.length, (i) {
                final icon = _icons[i];
                final label = labels[i];
                final active = i == navigationShell.currentIndex;
                return Expanded(
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => _onTap(i),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 240),
                      curve: Curves.easeOut,
                      height: 52,
                      decoration: BoxDecoration(
                        gradient: active ? context.colors.primaryGradient : null,
                        borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            icon,
                            color: active
                                ? context.colors.textInverse
                                : context.colors.textSecondary,
                            size: 20,
                          ),
                          if (active) ...[
                            const SizedBox(width: 6),
                            // FittedBox (not Flexible+fade): a faded clip mid
                            // Arabic/Dari word cuts across joined letterforms
                            // and reads as garbled text instead of a clean
                            // truncation, so longer translated labels shrink
                            // to fit rather than clip.
                            Flexible(
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  label,
                                  maxLines: 1,
                                  style: AppTextStyles.labelMedium.copyWith(
                                    color: context.colors.textInverse,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
