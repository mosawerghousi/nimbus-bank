import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_text_styles.dart';

class _MoreAction {
  const _MoreAction(this.icon, this.label, this.route);
  final IconData icon;
  final String label;
  final String route;
}

const _actions = [
  _MoreAction(Icons.description_outlined, 'Statements', '/statements'),
  _MoreAction(Icons.currency_exchange_rounded, 'Currency exchange', '/exchange'),
  _MoreAction(Icons.card_giftcard_rounded, 'Refer a friend', '/refer'),
  _MoreAction(Icons.support_agent_rounded, 'Help & support', '/profile/help'),
];

/// The sheet behind the dashboard's "More" quick action — a grid of
/// secondary money-management actions that don't warrant their own spot in
/// the primary quick-actions row.
class MoreActionsSheet extends StatelessWidget {
  const MoreActionsSheet({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => const MoreActionsSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        margin: const EdgeInsets.all(AppSpacing.sm),
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.pageHPadding,
          AppSpacing.md,
          AppSpacing.pageHPadding,
          AppSpacing.lg,
        ),
        decoration: BoxDecoration(
          color: context.colors.surface,
          borderRadius: BorderRadius.circular(AppSpacing.radiusXl),
          border: Border.all(color: context.colors.border),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: context.colors.border,
                borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            Align(
              alignment: Alignment.centerLeft,
              child: Text('MORE ACTIONS', style: AppTextStyles.overline),
            ),
            const SizedBox(height: AppSpacing.md),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _actions.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: AppSpacing.sm,
                crossAxisSpacing: AppSpacing.sm,
                childAspectRatio: 1.7,
              ),
              itemBuilder: (context, i) {
                final action = _actions[i];
                return Material(
                  color: context.colors.surfaceElevated,
                  borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
                    onTap: () {
                      Navigator.of(context).pop();
                      context.push(action.route);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
                        border: Border.all(color: context.colors.border),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(action.icon, size: 22, color: context.colors.primary),
                          const SizedBox(height: AppSpacing.sm),
                          Text(
                            action.label,
                            style: AppTextStyles.titleSmall,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
