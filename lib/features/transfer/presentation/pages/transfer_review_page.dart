import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../core/widgets/network_hero_image.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../home/presentation/providers/bank_providers.dart';
import '../providers/transfer_providers.dart';

class TransferReviewPage extends ConsumerWidget {
  const TransferReviewPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final draft = ref.watch(transferDraftProvider);
    final accounts = ref.watch(accountsProvider);
    final contacts = ref.watch(contactsProvider);
    final fromAccount =
        accounts.firstWhere((a) => a.id == draft.fromAccountId, orElse: () => accounts.first);
    final contact = contacts.firstWhere(
      (c) => c.id == draft.contactId,
      orElse: () => contacts.first,
    );
    final currency = NumberFormat.currency(locale: 'en_US', symbol: '\$');
    final topInset = MediaQuery.viewPaddingOf(context).top;

    return Scaffold(
      backgroundColor: context.colors.background,
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.fromLTRB(
          AppSpacing.pageHPadding,
          topInset + AppSpacing.md,
          AppSpacing.pageHPadding,
          160,
        ),
        children: [
          Row(
            children: [
              CircleIconButton(
                icon: Icons.arrow_back_rounded,
                onPressed: () => context.pop(),
              ),
              const Spacer(),
              Text('Review transfer', style: AppTextStyles.titleMedium),
              const Spacer(),
              const SizedBox(width: 44),
            ],
          ),
          const SizedBox(height: AppSpacing.xxl),
          Center(
            child: Column(
              children: [
                ClipOval(
                  child: NetworkHeroImage(
                    url: contact.avatarUrl,
                    width: 84,
                    height: 84,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                Text(
                  'You’re sending',
                  style: AppTextStyles.bodyMedium,
                ),
                const SizedBox(height: 4),
                Text(
                  currency.format(draft.amount),
                  style: AppTextStyles.displayMedium,
                ),
                const SizedBox(height: 4),
                Text(
                  'to ${contact.name}',
                  style: AppTextStyles.titleMedium.copyWith(
                    color: context.colors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.xxl),
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: context.colors.surface,
              borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
              border: Border.all(color: context.colors.border),
            ),
            child: Column(
              children: [
                _SummaryRow(label: 'From', value: '${fromAccount.name} · ${fromAccount.maskedNumber}'),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: AppSpacing.sm),
                  child: Divider(),
                ),
                _SummaryRow(label: 'To', value: '${contact.name} · ${contact.accountNumberMasked}'),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: AppSpacing.sm),
                  child: Divider(),
                ),
                _SummaryRow(
                  label: 'Note',
                  value: draft.note.isEmpty ? 'No note added' : draft.note,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: AppSpacing.sm),
                  child: Divider(),
                ),
                _SummaryRow(
                  label: 'Transfer fee',
                  value: 'Free',
                  valueColor: context.colors.secondary,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: AppSpacing.sm),
                  child: Divider(),
                ),
                _SummaryRow(
                  label: 'Total',
                  value: currency.format(draft.amount),
                  emphasised: true,
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              Icon(
                Icons.bolt_rounded,
                size: 16,
                color: context.colors.secondary,
              ),
              const SizedBox(width: AppSpacing.xs),
              Expanded(
                child: Text(
                  'Instant — arrives in ${contact.name.split(' ').first}’s account immediately.',
                  style: AppTextStyles.bodySmall,
                ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.fromLTRB(
          AppSpacing.pageHPadding,
          AppSpacing.md,
          AppSpacing.pageHPadding,
          MediaQuery.viewPaddingOf(context).bottom + AppSpacing.md,
        ),
        child: PrimaryButton(
          label: 'Confirm & Send',
          icon: Icons.lock_outline_rounded,
          onPressed: () => context.push('/transfer/success'),
        ),
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({
    required this.label,
    required this.value,
    this.emphasised = false,
    this.valueColor,
  });

  final String label;
  final String value;
  final bool emphasised;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    final labelStyle = emphasised ? AppTextStyles.titleMedium : AppTextStyles.bodyMedium;
    final valueStyle = emphasised
        ? AppTextStyles.headlineMedium.copyWith(
            color: valueColor ?? context.colors.primary,
          )
        : AppTextStyles.titleSmall.copyWith(color: valueColor);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: labelStyle),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.right,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: valueStyle,
          ),
        ),
      ],
    );
  }
}
