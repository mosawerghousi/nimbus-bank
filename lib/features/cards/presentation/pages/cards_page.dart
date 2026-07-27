import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../home/presentation/providers/bank_providers.dart';
import '../widgets/bank_card_tile.dart';

class CardsPage extends ConsumerWidget {
  const CardsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cards = ref.watch(cardsProvider);
    final frozen = ref.watch(cardFreezeProvider);
    final topInset = MediaQuery.viewPaddingOf(context).top;

    return Scaffold(
      backgroundColor: context.colors.background,
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.fromLTRB(
          AppSpacing.pageHPadding,
          topInset + AppSpacing.md,
          AppSpacing.pageHPadding,
          120,
        ),
        children: [
          Text('WALLET', style: AppTextStyles.overline),
          const SizedBox(height: AppSpacing.xs),
          Text('Your cards', style: AppTextStyles.displayMedium),
          const SizedBox(height: AppSpacing.sm),
          Text(
            '${cards.length} cards linked to your accounts.',
            style: AppTextStyles.bodyMedium,
          ),
          const SizedBox(height: AppSpacing.xl),
          ...cards.map((card) {
            final withFreezeState =
                card.copyWithFrozen(frozen.contains(card.id));
            return Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.lg),
              child: BankCardTile(
                card: withFreezeState,
                onTap: () => context.push('/card/${card.id}'),
              ),
            );
          }),
          const SizedBox(height: AppSpacing.md),
          PrimaryButton(
            label: 'Add a new card',
            icon: Icons.add_rounded,
            variant: PrimaryButtonVariant.ghost,
            onPressed: () => context.push('/cards/new'),
          ),
        ],
      ),
    );
  }
}
