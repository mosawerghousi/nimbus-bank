import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../home/presentation/providers/bank_providers.dart';
import '../providers/topup_providers.dart';

/// Mock outside funding sources a member can pull money from — plain
/// display strings, since there's no real entity behind money coming in
/// from outside Nimbus.
const _fundingSources = [
  'Chase Total Checking',
  'Ally Online Savings',
  'Nimbus Midnight Debit',
];

class TopUpPage extends ConsumerStatefulWidget {
  const TopUpPage({super.key});

  @override
  ConsumerState<TopUpPage> createState() => _TopUpPageState();
}

class _TopUpPageState extends ConsumerState<TopUpPage> {
  late final _amountController = TextEditingController();
  String? _error;

  @override
  void initState() {
    super.initState();
    // Entering the flow always starts a clean draft, so a completed top-up
    // never bleeds its source/destination/amount into the next one.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      ref.read(topUpDraftProvider.notifier).reset();
      final accounts = ref.read(accountsProvider);
      if (accounts.isNotEmpty) {
        ref.read(topUpDraftProvider.notifier).setToAccount(accounts.first.id);
      }
    });
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  void _addFunds() {
    final draft = ref.read(topUpDraftProvider);
    if (draft.toAccountId == null) {
      setState(() => _error = 'Choose which account to add money to.');
      return;
    }
    final amount = double.tryParse(_amountController.text) ?? 0;
    if (amount <= 0) {
      setState(() => _error = 'Enter an amount greater than \$0.');
      return;
    }
    ref.read(topUpDraftProvider.notifier).setAmount(amount);
    ref.read(accountsProvider.notifier).topUp(draft.toAccountId!, amount);
    setState(() => _error = null);
    context.push('/topup/success');
  }

  @override
  Widget build(BuildContext context) {
    final accounts = ref.watch(accountsProvider);
    final draft = ref.watch(topUpDraftProvider);
    final topInset = MediaQuery.viewPaddingOf(context).top;
    final toAccount = accounts.firstWhere(
      (a) => a.id == draft.toAccountId,
      orElse: () => accounts.first,
    );

    return Scaffold(
      backgroundColor: context.colors.background,
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.fromLTRB(
          AppSpacing.pageHPadding,
          topInset + AppSpacing.md,
          AppSpacing.pageHPadding,
          AppSpacing.huge,
        ),
        children: [
          Row(
            children: [
              CircleIconButton(
                icon: Icons.close_rounded,
                onPressed: () => context.pop(),
              ),
              const Spacer(),
              Text('Add money', style: AppTextStyles.titleMedium),
              const Spacer(),
              const SizedBox(width: 44),
            ],
          ),
          const SizedBox(height: AppSpacing.xl),
          Center(
            child: Column(
              children: [
                Text(
                  'Amount',
                  style: AppTextStyles.bodyMedium,
                ),
                const SizedBox(height: AppSpacing.xs),
                IntrinsicWidth(
                  child: TextField(
                    controller: _amountController,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                    ],
                    textAlign: TextAlign.center,
                    cursorColor: context.colors.primary,
                    style: AppTextStyles.displayLarge.copyWith(
                      color: context.colors.textPrimary,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixText: '\$',
                      prefixStyle: AppTextStyles.displayLarge.copyWith(
                        color: context.colors.textMuted,
                      ),
                      hintText: '0.00',
                      hintStyle: AppTextStyles.displayLarge.copyWith(
                        color: context.colors.textMuted,
                      ),
                    ),
                  ),
                ),
                Text(
                  'into ${toAccount.name} · ${toAccount.maskedNumber}',
                  style: AppTextStyles.bodySmall,
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.xxl),
          Text('FROM', style: AppTextStyles.overline),
          const SizedBox(height: AppSpacing.sm),
          SizedBox(
            height: 44,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: _fundingSources.length,
              separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.xs),
              itemBuilder: (context, i) {
                final source = _fundingSources[i];
                final active = source == draft.sourceLabel;
                return GestureDetector(
                  onTap: () =>
                      ref.read(topUpDraftProvider.notifier).setSource(source),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding:
                        const EdgeInsets.symmetric(horizontal: AppSpacing.md),
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
                      source,
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
          const SizedBox(height: AppSpacing.xxl),
          Text('TO', style: AppTextStyles.overline),
          const SizedBox(height: AppSpacing.sm),
          SizedBox(
            height: 44,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: accounts.length,
              separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.xs),
              itemBuilder: (context, i) {
                final account = accounts[i];
                final active = account.id == draft.toAccountId;
                return GestureDetector(
                  onTap: () => ref
                      .read(topUpDraftProvider.notifier)
                      .setToAccount(account.id),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding:
                        const EdgeInsets.symmetric(horizontal: AppSpacing.md),
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
                      account.name,
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
          if (_error != null) ...[
            const SizedBox(height: AppSpacing.md),
            Text(
              _error!,
              style: AppTextStyles.labelMedium.copyWith(
                color: context.colors.error,
              ),
            ),
          ],
          const SizedBox(height: AppSpacing.xl),
          PrimaryButton(
            label: 'Add funds',
            icon: Icons.add_rounded,
            onPressed: _addFunds,
          ),
        ],
      ),
    );
  }
}
