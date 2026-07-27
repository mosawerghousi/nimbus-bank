import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../core/widgets/sub_page_scaffold.dart';
import '../../../home/presentation/providers/bank_providers.dart';
import '../providers/external_accounts_providers.dart';

class LinkedAccountsPage extends ConsumerWidget {
  const LinkedAccountsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accounts = ref.watch(accountsProvider);
    final externalAccounts = ref.watch(externalAccountsProvider);
    final currency = NumberFormat.currency(locale: 'en_US', symbol: '\$');

    return SubPageScaffold(
      eyebrow: 'MONEY, ALL IN ONE PLACE',
      title: 'Linked accounts',
      subtitle: 'Your Nimbus accounts, plus any outside banks you connect.',
      bottom: PrimaryButton(
        label: 'Link a new bank',
        icon: Icons.add_link_rounded,
        onPressed: () => context.push('/profile/linked-accounts/connect'),
      ),
      children: [
        Text('NIMBUS ACCOUNTS', style: AppTextStyles.overline),
        const SizedBox(height: AppSpacing.sm),
        ...accounts.map(
          (a) => Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.xs),
            child: Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: context.colors.surface,
                borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
                border: Border.all(color: context.colors.border),
              ),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      gradient: context.gradientForKey(a.colorKey),
                      borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                    ),
                    child: Icon(
                      Icons.account_balance_rounded,
                      size: 18,
                      color: context.colors.textInverse,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(a.name, style: AppTextStyles.titleSmall),
                        const SizedBox(height: 2),
                        Text(a.maskedNumber, style: AppTextStyles.bodySmall),
                      ],
                    ),
                  ),
                  Text(
                    currency.format(a.balance),
                    style: AppTextStyles.titleSmall,
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.xl),
        Text('EXTERNAL BANKS', style: AppTextStyles.overline),
        const SizedBox(height: AppSpacing.sm),
        ...externalAccounts.map(
          (a) => _ExternalTile(name: a.name, masked: a.maskedNumber),
        ),
      ],
    );
  }
}

class _ExternalTile extends StatelessWidget {
  const _ExternalTile({required this.name, required this.masked});
  final String name;
  final String masked;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.xs),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: context.colors.surface,
          borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
          border: Border.all(color: context.colors.border),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: context.colors.surfaceElevated,
                borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
              ),
              child: Icon(
                Icons.account_balance_outlined,
                size: 18,
                color: context.colors.textSecondary,
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: AppTextStyles.titleSmall),
                  const SizedBox(height: 2),
                  Text(masked, style: AppTextStyles.bodySmall),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: 4),
              decoration: BoxDecoration(
                color: context.colors.secondary.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
              ),
              child: Text(
                'CONNECTED',
                style: AppTextStyles.overline.copyWith(
                  color: context.colors.secondary,
                  fontSize: 9,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
