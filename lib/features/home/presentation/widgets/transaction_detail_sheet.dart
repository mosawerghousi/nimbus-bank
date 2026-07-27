import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../domain/entities/spend_category.dart';
import '../../domain/entities/transaction.dart';
import '../providers/bank_providers.dart';

/// A bottom sheet showing the full detail of a single [Transaction] —
/// merchant, amount, category, date and status. Reused by both the home
/// dashboard's "Recent transactions" list and the full Transactions tab.
class TransactionDetailSheet extends ConsumerWidget {
  const TransactionDetailSheet({super.key, required this.transaction});

  final Transaction transaction;

  static Future<void> show(BuildContext context, Transaction transaction) {
    return showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => TransactionDetailSheet(transaction: transaction),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(categoriesProvider);
    final accounts = ref.watch(accountsProvider);
    final category = categories.firstWhere(
      (c) => c.id == transaction.categoryId,
      orElse: () => SpendCategory(
        id: transaction.categoryId,
        label: 'Other',
        icon: Icons.receipt_long_rounded,
        colorKey: 'textMuted',
      ),
    );
    final account = accounts.firstWhere(
      (a) => a.id == transaction.accountId,
      orElse: () => accounts.first,
    );
    final color = context.colorForKey(category.colorKey);
    final currency = NumberFormat.currency(locale: 'en_US', symbol: '\$');
    final amountLabel = transaction.isIncome
        ? '+${currency.format(transaction.amount)}'
        : '-${currency.format(transaction.amount.abs())}';

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
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.14),
                shape: BoxShape.circle,
              ),
              child: Icon(transaction.icon, size: 28, color: color),
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              transaction.merchant,
              textAlign: TextAlign.center,
              style: AppTextStyles.headlineMedium,
            ),
            const SizedBox(height: 4),
            Text(
              amountLabel,
              style: AppTextStyles.displaySmall.copyWith(
                color: transaction.isIncome
                    ? context.colors.secondary
                    : context.colors.textPrimary,
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: context.colors.surfaceElevated,
                borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
              ),
              child: Column(
                children: [
                  _DetailRow(label: 'Category', value: category.label),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: AppSpacing.sm),
                    child: Divider(),
                  ),
                  _DetailRow(
                    label: 'Date',
                    value: DateFormat('EEEE, MMM d · h:mm a')
                        .format(transaction.date),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: AppSpacing.sm),
                    child: Divider(),
                  ),
                  _DetailRow(label: 'Account', value: account.name),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: AppSpacing.sm),
                    child: Divider(),
                  ),
                  _DetailRow(
                    label: 'Status',
                    value: transaction.status,
                    valueColor: context.colors.secondary,
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Close',
                style: AppTextStyles.labelLarge.copyWith(
                  color: context.colors.textSecondary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.label, required this.value, this.valueColor});
  final String label;
  final String value;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: AppTextStyles.bodyMedium),
        Text(
          value,
          style: AppTextStyles.titleSmall.copyWith(
            color: valueColor ?? context.colors.textPrimary,
          ),
        ),
      ],
    );
  }
}
