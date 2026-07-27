import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../home/data/mock_bank_repository.dart';
import '../../../home/domain/entities/transaction.dart';
import '../../../home/presentation/providers/bank_providers.dart';
import '../../../home/presentation/widgets/spend_chart.dart';
import '../../../home/presentation/widgets/transaction_detail_sheet.dart';
import '../../../home/presentation/widgets/transaction_tile.dart';

class TransactionsPage extends ConsumerStatefulWidget {
  const TransactionsPage({super.key});

  @override
  ConsumerState<TransactionsPage> createState() => _TransactionsPageState();
}

class _TransactionsPageState extends ConsumerState<TransactionsPage> {
  String _query = '';
  String _categoryFilter = 'all';

  List<Transaction> _apply(List<Transaction> source) {
    final q = _query.trim().toLowerCase();
    return source.where((t) {
      if (_categoryFilter != 'all' && t.categoryId != _categoryFilter) {
        return false;
      }
      if (q.isNotEmpty && !t.merchant.toLowerCase().contains(q)) {
        return false;
      }
      return true;
    }).toList();
  }

  String _dayLabel(DateTime date) {
    final anchor = MockBankRepository.anchor;
    final day = DateTime(date.year, date.month, date.day);
    final today = DateTime(anchor.year, anchor.month, anchor.day);
    final diff = today.difference(day).inDays;
    if (diff == 0) return 'Today';
    if (diff == 1) return 'Yesterday';
    return DateFormat('EEEE, MMM d').format(date);
  }

  @override
  Widget build(BuildContext context) {
    final all = ref.watch(sortedTransactionsProvider);
    final categories = ref.watch(categoriesProvider);
    final results = _apply(all);
    final topInset = MediaQuery.viewPaddingOf(context).top;

    final grouped = <String, List<Transaction>>{};
    for (final t in results) {
      final key = _dayLabel(t.date);
      grouped.putIfAbsent(key, () => []).add(t);
    }

    return Scaffold(
      backgroundColor: context.colors.background,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                AppSpacing.pageHPadding,
                topInset + AppSpacing.md,
                AppSpacing.pageHPadding,
                AppSpacing.lg,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('ACTIVITY', style: AppTextStyles.overline),
                  const SizedBox(height: AppSpacing.xs),
                  Text('Transactions', style: AppTextStyles.displayMedium),
                  const SizedBox(height: AppSpacing.lg),
                  Container(
                    height: 52,
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                    ),
                    decoration: BoxDecoration(
                      color: context.colors.surface,
                      borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
                      border: Border.all(color: context.colors.border),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.search_rounded,
                          size: 20,
                          color: context.colors.textMuted,
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        Expanded(
                          child: TextField(
                            cursorColor: context.colors.primary,
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: context.colors.textPrimary,
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Search transactions…',
                              hintStyle: AppTextStyles.bodyMedium.copyWith(
                                color: context.colors.textMuted,
                              ),
                            ),
                            onChanged: (v) => setState(() => _query = v),
                          ),
                        ),
                        if (_query.isNotEmpty)
                          GestureDetector(
                            onTap: () => setState(() => _query = ''),
                            child: Icon(
                              Icons.close_rounded,
                              size: 18,
                              color: context.colors.textMuted,
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 40,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.pageHPadding,
                ),
                itemCount: categories.length + 1,
                separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.xs),
                itemBuilder: (context, i) {
                  final id = i == 0 ? 'all' : categories[i - 1].id;
                  final label = i == 0 ? 'All' : categories[i - 1].label;
                  final active = id == _categoryFilter;
                  return GestureDetector(
                    onTap: () => setState(() => _categoryFilter = id),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.md,
                      ),
                      decoration: BoxDecoration(
                        color: active
                            ? context.colors.textPrimary
                            : context.colors.surface,
                        borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
                        border: Border.all(
                          color: active
                              ? context.colors.textPrimary
                              : context.colors.border,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        label,
                        style: AppTextStyles.labelMedium.copyWith(
                          color: active
                              ? context.colors.background
                              : context.colors.textSecondary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.xl)),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.pageHPadding,
              ),
              child: Text('This month', style: AppTextStyles.headlineMedium),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.md)),
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSpacing.pageHPadding),
              child: SpendChart(),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.xxl)),
          if (results.isEmpty)
            SliverFillRemaining(
              hasScrollBody: false,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.xxl),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 72,
                        height: 72,
                        decoration: BoxDecoration(
                          color: context.colors.surface,
                          shape: BoxShape.circle,
                          border: Border.all(color: context.colors.border),
                        ),
                        child: Icon(
                          Icons.search_off_rounded,
                          size: 32,
                          color: context.colors.textMuted,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      Text('No transactions found', style: AppTextStyles.titleLarge),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        'Try a different search term or category.',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ),
            )
          else
            for (final entry in grouped.entries) ...[
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.pageHPadding,
                    AppSpacing.md,
                    AppSpacing.pageHPadding,
                    AppSpacing.sm,
                  ),
                  child: Text(entry.key, style: AppTextStyles.overline),
                ),
              ),
              SliverList.separated(
                itemCount: entry.value.length,
                separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.xs),
                itemBuilder: (context, i) => Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.pageHPadding,
                  ),
                  child: TransactionTile(
                    transaction: entry.value[i],
                    onTap: () =>
                        TransactionDetailSheet.show(context, entry.value[i]),
                  ),
                ),
              ),
            ],
          const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.huge)),
        ],
      ),
    );
  }
}
