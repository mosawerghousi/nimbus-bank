import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../core/widgets/network_hero_image.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../home/presentation/providers/bank_providers.dart';
import '../providers/transfer_providers.dart';

class TransferPage extends ConsumerStatefulWidget {
  const TransferPage({super.key});

  @override
  ConsumerState<TransferPage> createState() => _TransferPageState();
}

class _TransferPageState extends ConsumerState<TransferPage> {
  late final _amountController = TextEditingController();
  late final _noteController = TextEditingController();
  String? _error;

  @override
  void initState() {
    super.initState();
    // Entering the flow always starts a clean draft, so a completed
    // transfer never bleeds its recipient/amount into the next one.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      ref.read(transferDraftProvider.notifier).reset();
    });
  }

  @override
  void dispose() {
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  void _continue() {
    final draft = ref.read(transferDraftProvider);
    if (draft.contactId == null) {
      setState(() => _error = 'Choose who you’re sending to.');
      return;
    }
    final amount = double.tryParse(_amountController.text) ?? 0;
    if (amount <= 0) {
      setState(() => _error = 'Enter an amount greater than \$0.');
      return;
    }
    ref.read(transferDraftProvider.notifier)
      ..setAmount(amount)
      ..setNote(_noteController.text.trim());
    setState(() => _error = null);
    context.push('/transfer/review');
  }

  @override
  Widget build(BuildContext context) {
    final accounts = ref.watch(accountsProvider);
    final contacts = ref.watch(contactsProvider);
    final draft = ref.watch(transferDraftProvider);
    final fromAccount =
        accounts.firstWhere((a) => a.id == draft.fromAccountId, orElse: () => accounts.first);
    final topInset = MediaQuery.viewPaddingOf(context).top;

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
              Text('Send money', style: AppTextStyles.titleMedium),
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
                  'from ${fromAccount.name} · ${fromAccount.maskedNumber}',
                  style: AppTextStyles.bodySmall,
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.xxl),
          Text('SEND FROM', style: AppTextStyles.overline),
          const SizedBox(height: AppSpacing.sm),
          SizedBox(
            height: 44,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: accounts.length,
              separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.xs),
              itemBuilder: (context, i) {
                final account = accounts[i];
                final active = account.id == draft.fromAccountId;
                return GestureDetector(
                  onTap: () => ref
                      .read(transferDraftProvider.notifier)
                      .setFromAccount(account.id),
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
                            ? context.colors.textInverse
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
          Text('SEND TO', style: AppTextStyles.overline),
          const SizedBox(height: AppSpacing.sm),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: contacts.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: AppSpacing.md,
              crossAxisSpacing: AppSpacing.sm,
              childAspectRatio: 0.78,
            ),
            itemBuilder: (context, i) {
              final contact = contacts[i];
              final active = contact.id == draft.contactId;
              return GestureDetector(
                onTap: () =>
                    ref.read(transferDraftProvider.notifier).setContact(contact.id),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: active ? context.colors.primaryGradient : null,
                        border: active
                            ? null
                            : Border.all(color: context.colors.border),
                      ),
                      child: ClipOval(
                        child: NetworkHeroImage(
                          url: contact.avatarUrl,
                          width: 56,
                          height: 56,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      contact.name.split(' ').first,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.labelMedium.copyWith(
                        color: active
                            ? context.colors.textPrimary
                            : context.colors.textSecondary,
                        fontWeight: active ? FontWeight.w700 : FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: AppSpacing.xl),
          Text('NOTE (OPTIONAL)', style: AppTextStyles.overline),
          const SizedBox(height: AppSpacing.sm),
          TextField(
            controller: _noteController,
            style: AppTextStyles.bodyMedium.copyWith(
              color: context.colors.textPrimary,
            ),
            decoration: InputDecoration(
              filled: true,
              fillColor: context.colors.surface,
              hintText: 'What’s it for?',
              hintStyle: AppTextStyles.bodyMedium.copyWith(
                color: context.colors.textMuted,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.md,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                borderSide: BorderSide(color: context.colors.border),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                borderSide: BorderSide(color: context.colors.border),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                borderSide: BorderSide(color: context.colors.primary, width: 1.4),
              ),
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
            label: 'Continue',
            icon: Icons.arrow_forward_rounded,
            onPressed: _continue,
          ),
        ],
      ),
    );
  }
}
