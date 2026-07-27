import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../home/domain/entities/bank_card.dart';
import '../../../home/presentation/providers/bank_providers.dart';

const _designKeys = ['midnight', 'violet', 'mint'];

class AddCardPage extends ConsumerStatefulWidget {
  const AddCardPage({super.key});

  @override
  ConsumerState<AddCardPage> createState() => _AddCardPageState();
}

class _AddCardPageState extends ConsumerState<AddCardPage> {
  CardType _type = CardType.debit;
  String _designKey = _designKeys.first;

  void _create() {
    final cards = ref.read(cardsProvider);
    final accounts = ref.read(accountsProvider);
    final user = ref.read(userProvider);
    final index = cards.length;
    final newCard = BankCard(
      id: 'c${index + 1}',
      holderName: user.name,
      last4: (((2000 + index * 137) % 9000) + 1000).toString(),
      expiry: '11/29',
      network: index.isEven ? CardNetwork.visa : CardNetwork.mastercard,
      type: _type,
      gradientKey: _designKey,
      linkedAccountId: accounts.isNotEmpty ? accounts.first.id : 'acc1',
    );
    ref.read(cardsProvider.notifier).addCard(newCard);
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
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
              Text(context.strings.cardsAddNewCard, style: AppTextStyles.titleMedium),
              const Spacer(),
              const SizedBox(width: 44),
            ],
          ),
          const SizedBox(height: AppSpacing.xl),
          Text(context.strings.cardsCardType, style: AppTextStyles.overline),
          const SizedBox(height: AppSpacing.sm),
          ...CardType.values.map((type) {
            final active = type == _type;
            return Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.xs),
              child: Material(
                color: active ? context.colors.textPrimary : context.colors.surface,
                borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
                child: InkWell(
                  borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
                  onTap: () => setState(() => _type = type),
                  child: Container(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
                      border: Border.all(
                        color: active ? context.colors.textPrimary : context.colors.border,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          _iconFor(type),
                          size: 20,
                          color: active
                              ? context.colors.background
                              : context.colors.primary,
                        ),
                        const SizedBox(width: AppSpacing.md),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                context.strings.cardTypeLabel(type),
                                style: AppTextStyles.titleSmall.copyWith(
                                  color: active
                                      ? context.colors.background
                                      : context.colors.textPrimary,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                _descriptionFor(context, type),
                                style: AppTextStyles.bodySmall.copyWith(
                                  color: active
                                      ? context.colors.background.withValues(alpha: 0.75)
                                      : context.colors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (active)
                          Icon(Icons.check_circle_rounded, size: 20, color: context.colors.background)
                        else
                          Icon(Icons.radio_button_unchecked_rounded, size: 20, color: context.colors.textMuted),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
          const SizedBox(height: AppSpacing.xl),
          Text(context.strings.cardsDesign, style: AppTextStyles.overline),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: _designKeys.map((key) {
              final active = key == _designKey;
              return Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    right: key == _designKeys.last ? 0 : AppSpacing.sm,
                  ),
                  child: GestureDetector(
                    onTap: () => setState(() => _designKey = key),
                    child: Column(
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          height: 56,
                          decoration: BoxDecoration(
                            gradient: context.gradientForKey(key),
                            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                            border: Border.all(
                              color: active ? context.colors.primary : Colors.transparent,
                              width: 2.5,
                            ),
                          ),
                          child: active
                              ? Icon(
                                  Icons.check_rounded,
                                  color: context.colors.textInverse,
                                  size: 20,
                                )
                              : null,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          _designLabel(key),
                          style: AppTextStyles.labelMedium.copyWith(
                            color: active
                                ? context.colors.textPrimary
                                : context.colors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: AppSpacing.xl),
          PrimaryButton(
            label: context.strings.cardsCreateCard,
            icon: Icons.add_rounded,
            onPressed: _create,
          ),
        ],
      ),
    );
  }

  IconData _iconFor(CardType type) => switch (type) {
        CardType.debit => Icons.credit_card_rounded,
        CardType.credit => Icons.credit_score_rounded,
        CardType.virtual => Icons.qr_code_2_rounded,
      };

  String _descriptionFor(BuildContext context, CardType type) => switch (type) {
        CardType.debit => context.strings.cardTypeDebitDescription,
        CardType.credit => context.strings.cardTypeCreditDescription,
        CardType.virtual => context.strings.cardTypeVirtualDescription,
      };

  String _designLabel(String key) => switch (key) {
        'midnight' => 'Midnight',
        'violet' => 'Violet',
        'mint' => 'Mint',
        _ => 'Card',
      };
}
