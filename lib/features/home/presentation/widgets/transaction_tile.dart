import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../domain/entities/spend_category.dart';
import '../../domain/entities/transaction.dart';
import '../providers/bank_providers.dart';

/// A single ledger row — a category icon, merchant + category, and the
/// signed amount (mint for income, default ink for spend). Shared by the
/// home dashboard's "Recent transactions" list and the full Transactions tab.
class TransactionTile extends ConsumerWidget {
  const TransactionTile({
    super.key,
    required this.transaction,
    this.onTap,
  });

  final Transaction transaction;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(categoriesProvider);
    final category = categories.firstWhere(
      (c) => c.id == transaction.categoryId,
      orElse: () => SpendCategory(
        id: transaction.categoryId,
        label: 'Other',
        icon: Icons.receipt_long_rounded,
        colorKey: 'textMuted',
      ),
    );
    final color = context.colorForKey(category.colorKey);
    final currency = NumberFormat.currency(locale: 'en_US', symbol: '\$');
    final amountLabel = transaction.isIncome
        ? '+${currency.format(transaction.amount)}'
        : '-${currency.format(transaction.amount.abs())}';

    return Material(
      color: context.colors.surface,
      borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
            border: Border.all(color: context.colors.border),
          ),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
                ),
                child: Icon(transaction.icon, size: 20, color: color),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      transaction.merchant,
                      style: AppTextStyles.titleSmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${context.strings.spendCategoryLabel(category.id)} · ${DateFormat('MMM d').format(transaction.date)}',
                      style: AppTextStyles.bodySmall,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Text(
                amountLabel,
                style: AppTextStyles.titleSmall.copyWith(
                  color: transaction.isIncome
                      ? context.colors.secondary
                      : context.colors.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
