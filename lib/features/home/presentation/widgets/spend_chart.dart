import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../providers/bank_providers.dart';

/// Hand-rolled "spending this month" breakdown — a proportional stacked bar
/// plus a ranked legend. No charting package: segment widths are plain
/// [Expanded] flex values sized from [transactionsByCategoryProvider], in
/// keeping with this workspace's zero-extra-dependency chart convention.
class SpendChart extends ConsumerWidget {
  const SpendChart({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final totals = ref.watch(transactionsByCategoryProvider);
    final categories = ref.watch(categoriesProvider);
    final currency = NumberFormat.currency(locale: 'en_US', symbol: '\$');

    final entries = totals.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    final grandTotal = entries.fold<double>(0, (sum, e) => sum + e.value);

    if (entries.isEmpty || grandTotal == 0) {
      return Container(
        padding: const EdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(
          color: context.colors.surface,
          borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
          border: Border.all(color: context.colors.border),
        ),
        child: Text(
          context.strings.spendChartNoSpending,
          style: AppTextStyles.bodyMedium,
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        border: Border.all(color: context.colors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(context.strings.spendChartTotalSpent, style: AppTextStyles.bodyMedium),
              Text(
                currency.format(grandTotal),
                style: AppTextStyles.titleLarge,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          ClipRRect(
            borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
            child: SizedBox(
              height: 10,
              child: Row(
                children: entries.map((e) {
                  final label = categories
                      .firstWhere(
                        (c) => c.id == e.key,
                        orElse: () => categories.first,
                      )
                      .colorKey;
                  return Expanded(
                    flex: (e.value * 1000).round().clamp(1, 1000000),
                    child: Container(
                      color: context.colorForKey(label),
                      margin: const EdgeInsets.symmetric(horizontal: 1),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          ...entries.map((e) {
            final category = categories.firstWhere(
              (c) => c.id == e.key,
              orElse: () => categories.first,
            );
            final percent = (e.value / grandTotal * 100).round();
            return Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: Row(
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: context.colorForKey(category.colorKey),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Icon(
                    category.icon,
                    size: 14,
                    color: context.colors.textMuted,
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(context.strings.spendCategoryLabel(category.id), style: AppTextStyles.bodyMedium),
                  ),
                  Text(
                    '$percent%',
                    style: AppTextStyles.labelMedium.copyWith(
                      color: context.colors.textMuted,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  SizedBox(
                    width: 70,
                    child: Text(
                      currency.format(e.value),
                      textAlign: TextAlign.right,
                      style: AppTextStyles.titleSmall,
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
