import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../home/presentation/providers/bank_providers.dart';
import '../widgets/bank_card_tile.dart';

class CardDetailPage extends ConsumerStatefulWidget {
  const CardDetailPage({super.key, required this.cardId});

  final String cardId;

  @override
  ConsumerState<CardDetailPage> createState() => _CardDetailPageState();
}

class _CardDetailPageState extends ConsumerState<CardDetailPage> {
  bool _revealed = false;

  @override
  Widget build(BuildContext context) {
    final cards = ref.watch(cardsProvider);
    final frozenIds = ref.watch(cardFreezeProvider);
    final card = cards.firstWhere((c) => c.id == widget.cardId);
    final isFrozen = frozenIds.contains(card.id);
    final displayCard = card.copyWithFrozen(isFrozen);
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
                icon: Icons.arrow_back_rounded,
                onPressed: () => Navigator.of(context).pop(),
              ),
              const Spacer(),
              Text(displayCard.label, style: AppTextStyles.titleMedium),
              const Spacer(),
              const SizedBox(width: 44),
            ],
          ),
          const SizedBox(height: AppSpacing.xl),
          BankCardTile(card: displayCard, revealNumber: _revealed),
          const SizedBox(height: AppSpacing.lg),
          Row(
            children: [
              Expanded(
                child: PrimaryButton(
                  label: isFrozen ? context.strings.cardsUnfreezeCard : context.strings.cardsFreezeCard,
                  icon: isFrozen
                      ? Icons.play_circle_outline_rounded
                      : Icons.ac_unit_rounded,
                  variant: isFrozen
                      ? PrimaryButtonVariant.primary
                      : PrimaryButtonVariant.subtle,
                  onPressed: () =>
                      ref.read(cardFreezeProvider.notifier).toggle(card.id),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: PrimaryButton(
                  label: _revealed ? context.strings.cardsHideNumber : context.strings.cardsRevealNumber,
                  icon: _revealed
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  variant: PrimaryButtonVariant.ghost,
                  onPressed: () => setState(() => _revealed = !_revealed),
                ),
              ),
            ],
          ),
          if (isFrozen) ...[
            const SizedBox(height: AppSpacing.md),
            Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: context.colors.warning.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
                border: Border.all(
                  color: context.colors.warning.withValues(alpha: 0.3),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline_rounded,
                    size: 18,
                    color: context.colors.warning,
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Text(
                      context.strings.cardsFrozenNotice,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: context.colors.textPrimary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
          const SizedBox(height: AppSpacing.xxl),
          Text(context.strings.cardsManage, style: AppTextStyles.overline),
          const SizedBox(height: AppSpacing.xs),
          Text(context.strings.cardsSettings, style: AppTextStyles.headlineMedium),
          const SizedBox(height: AppSpacing.md),
          _SettingsTile(
            icon: Icons.pin_outlined,
            label: context.strings.cardsChangePin,
            onTap: () => _snack(context, context.strings.pinChangeRequestSnack),
          ),
          _SettingsTile(
            icon: Icons.speed_rounded,
            label: context.strings.cardsSpendingLimit,
            onTap: () =>
                _snack(context, context.strings.cardsSpendingLimitSnack),
          ),
          _SettingsTile(
            icon: Icons.report_gmailerrorred_rounded,
            label: context.strings.cardsReportLostStolen,
            tinted: true,
            onTap: () => _snack(
              context,
              context.strings.cardsReportLostStolenSnack,
            ),
          ),
        ],
      ),
    );
  }

  void _snack(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: context.colors.surfaceElevated,
        behavior: SnackBarBehavior.floating,
        content: Text(
          message,
          style: AppTextStyles.bodyMedium.copyWith(
            color: context.colors.textPrimary,
          ),
        ),
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({
    required this.icon,
    required this.label,
    required this.onTap,
    this.tinted = false,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool tinted;

  @override
  Widget build(BuildContext context) {
    final color = tinted ? context.colors.error : context.colors.textPrimary;
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.xs),
      child: Material(
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        child: InkWell(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.md,
            ),
            decoration: BoxDecoration(
              border: Border.all(color: context.colors.border),
              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            ),
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: tinted
                        ? context.colors.error.withValues(alpha: 0.12)
                        : context.colors.surfaceElevated,
                    borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
                  ),
                  child: Icon(
                    icon,
                    size: 16,
                    color: tinted ? context.colors.error : context.colors.primary,
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Text(
                    label,
                    style: AppTextStyles.titleSmall.copyWith(color: color),
                  ),
                ),
                Transform.flip(
                  flipX: Directionality.of(context) == TextDirection.rtl,
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 14,
                    color: tinted ? context.colors.error : context.colors.textMuted,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
