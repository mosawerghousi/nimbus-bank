import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../core/widgets/sub_page_scaffold.dart';
import '../../../home/data/mock_bank_repository.dart';
import '../../../home/domain/entities/spend_category.dart';
import '../../../home/domain/entities/transaction.dart';
import '../../../home/presentation/providers/bank_providers.dart';

/// A single calendar month's spend/income summary, computed on the fly from
/// [transactionsProvider] — real data, not a stub.
class _MonthSummary {
  const _MonthSummary(this.month, this.spent, this.income, this.transactions);
  final DateTime month;
  final double spent;
  final double income;
  final List<Transaction> transactions;
}

class StatementsPage extends ConsumerWidget {
  const StatementsPage({super.key});

  /// The last 6 calendar months relative to the mock ledger's fixed
  /// "today" ([MockBankRepository.anchor]) rather than [DateTime.now] —
  /// otherwise the summaries would drift away from the transaction data,
  /// which is always generated relative to that same anchor.
  List<_MonthSummary> _buildSummaries(List<Transaction> transactions) {
    final anchor = MockBankRepository.anchor;
    return List.generate(6, (i) {
      final month = DateTime(anchor.year, anchor.month - i, 1);
      final inMonth = transactions
          .where((t) => t.date.year == month.year && t.date.month == month.month)
          .toList()
        ..sort((a, b) => b.date.compareTo(a.date));
      final spent = inMonth
          .where((t) => !t.isIncome)
          .fold<double>(0, (sum, t) => sum + t.amount.abs());
      final income = inMonth
          .where((t) => t.isIncome)
          .fold<double>(0, (sum, t) => sum + t.amount);
      return _MonthSummary(month, spent, income, inMonth);
    });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactions = ref.watch(transactionsProvider);
    final categories = ref.watch(categoriesProvider);
    final summaries = _buildSummaries(transactions);
    final currency = NumberFormat.currency(locale: 'en_US', symbol: '\$');

    return SubPageScaffold(
      eyebrow: 'ACCOUNT ACTIVITY',
      title: 'Statements',
      subtitle: 'Monthly summaries of what you spent and earned.',
      children: [
        Text('LAST 6 MONTHS', style: AppTextStyles.overline),
        const SizedBox(height: AppSpacing.sm),
        ...summaries.map(
          (summary) => Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.xs),
            child: Material(
              color: context.colors.surface,
              borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
              child: InkWell(
                borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
                onTap: () => _showMonthDetail(context, summary, categories, currency),
                child: Container(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
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
                          Icons.calendar_month_rounded,
                          size: 18,
                          color: context.colors.primary,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              DateFormat('MMMM yyyy').format(summary.month),
                              style: AppTextStyles.titleSmall,
                            ),
                            const SizedBox(height: 2),
                            Text(
                              '${summary.transactions.length} transactions',
                              style: AppTextStyles.bodySmall,
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '-${currency.format(summary.spent)}',
                            style: AppTextStyles.titleSmall,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            '+${currency.format(summary.income)}',
                            style: AppTextStyles.bodySmall.copyWith(
                              color: context.colors.secondary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: AppSpacing.xs),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 14,
                        color: context.colors.textMuted,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showMonthDetail(
    BuildContext context,
    _MonthSummary summary,
    List<SpendCategory> categories,
    NumberFormat currency,
  ) {
    final byCategory = <String, double>{};
    for (final t in summary.transactions) {
      if (t.isIncome) continue;
      byCategory.update(
        t.categoryId,
        (v) => v + t.amount.abs(),
        ifAbsent: () => t.amount.abs(),
      );
    }
    final entries = byCategory.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (sheetContext) {
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
              color: sheetContext.colors.surface,
              borderRadius: BorderRadius.circular(AppSpacing.radiusXl),
              border: Border.all(color: sheetContext.colors.border),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 36,
                  height: 4,
                  decoration: BoxDecoration(
                    color: sheetContext.colors.border,
                    borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),
                Text(
                  DateFormat('MMMM yyyy').format(summary.month),
                  style: AppTextStyles.headlineMedium,
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  'Spent ${currency.format(summary.spent)} · Earned ${currency.format(summary.income)}',
                  style: AppTextStyles.bodyMedium,
                ),
                const SizedBox(height: AppSpacing.xl),
                if (entries.isEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
                    child: Text(
                      'No spending recorded this month.',
                      style: AppTextStyles.bodyMedium,
                    ),
                  )
                else
                  Column(
                    children: [
                      for (final entry in entries) ...[
                        _CategoryRow(
                          label: _categoryLabel(categories, entry.key),
                          colorKey: _categoryColorKey(categories, entry.key),
                          value: currency.format(entry.value),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: AppSpacing.sm),
                          child: Divider(),
                        ),
                      ],
                    ],
                  ),
                const SizedBox(height: AppSpacing.sm),
                TextButton(
                  onPressed: () => Navigator.of(sheetContext).pop(),
                  child: Text(
                    'Close',
                    style: AppTextStyles.labelLarge.copyWith(
                      color: sheetContext.colors.textSecondary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String _categoryLabel(List<SpendCategory> categories, String id) {
    for (final c in categories) {
      if (c.id == id) return c.label;
    }
    return 'Other';
  }

  String _categoryColorKey(List<SpendCategory> categories, String id) {
    for (final c in categories) {
      if (c.id == id) return c.colorKey;
    }
    return 'textMuted';
  }
}

class _CategoryRow extends StatelessWidget {
  const _CategoryRow({
    required this.label,
    required this.colorKey,
    required this.value,
  });
  final String label;
  final String colorKey;
  final String value;

  @override
  Widget build(BuildContext context) {
    final color = context.colorForKey(colorKey);
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(child: Text(label, style: AppTextStyles.bodyMedium)),
        Text(value, style: AppTextStyles.titleSmall),
      ],
    );
  }
}
