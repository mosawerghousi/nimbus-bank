import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../home/domain/entities/bank_card.dart';

/// A reusable bank-card visual — parameterized by gradient, network,
/// masked number, holder and frozen state. Used both as a compact tile in
/// the Cards list and as the hero visual on the card-detail screen.
class BankCardTile extends StatelessWidget {
  const BankCardTile({
    super.key,
    required this.card,
    this.revealNumber = false,
    this.onTap,
  });

  final BankCard card;

  /// When true, shows the full (mock) card number instead of masked dots.
  final bool revealNumber;

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final onCard = context.colors.textInverse;
    final numberText = revealNumber
        ? '4000  1234  5678  ${card.last4}'
        : '••••  ••••  ••••  ${card.last4}';

    return GestureDetector(
      onTap: onTap,
      child: AspectRatio(
        aspectRatio: 1.6,
        child: Container(
          clipBehavior: Clip.antiAlias,
          padding: const EdgeInsets.all(AppSpacing.lg),
          decoration: BoxDecoration(
            gradient: context.gradientForKey(card.gradientKey),
            borderRadius: BorderRadius.circular(AppSpacing.radiusXl),
            boxShadow: [
              BoxShadow(
                color: context.colors.scrim.withValues(alpha: 0.3),
                blurRadius: 26,
                offset: const Offset(0, 16),
              ),
            ],
          ),
          child: Stack(
            children: [
              Positioned(
                right: -40,
                top: -40,
                child: Container(
                  width: 170,
                  height: 170,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: onCard.withValues(alpha: 0.06),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        card.label.toUpperCase(),
                        style: AppTextStyles.overline.copyWith(
                          color: onCard.withValues(alpha: 0.85),
                        ),
                      ),
                      const Spacer(),
                      _NetworkMark(network: card.network, color: onCard),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Container(
                    width: 38,
                    height: 28,
                    decoration: BoxDecoration(
                      color: onCard.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: onCard.withValues(alpha: 0.4)),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    numberText,
                    style: AppTextStyles.titleLarge.copyWith(
                      color: onCard,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: _CardDetail(
                          label: context.strings.cardCardholder,
                          value: card.holderName,
                          color: onCard,
                        ),
                      ),
                      _CardDetail(
                        label: context.strings.cardExpires,
                        value: card.expiry,
                        color: onCard,
                      ),
                    ],
                  ),
                ],
              ),
              if (card.isFrozen)
                Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: context.colors.scrim.withValues(alpha: 0.45),
                      borderRadius: BorderRadius.circular(AppSpacing.radiusXl),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.ac_unit_rounded, color: onCard, size: 26),
                          const SizedBox(height: 4),
                          Text(
                            context.strings.cardFrozenBadge,
                            style: AppTextStyles.overline.copyWith(
                              color: onCard,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CardDetail extends StatelessWidget {
  const _CardDetail({
    required this.label,
    required this.value,
    required this.color,
  });
  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.overline.copyWith(
            color: color.withValues(alpha: 0.65),
            fontSize: 9,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: AppTextStyles.labelLarge.copyWith(
            color: color,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _NetworkMark extends StatelessWidget {
  const _NetworkMark({required this.network, required this.color});
  final CardNetwork network;
  final Color color;

  @override
  Widget build(BuildContext context) {
    if (network == CardNetwork.visa) {
      return Text(
        'VISA',
        style: TextStyle(
          color: color,
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.w900,
          fontSize: 18,
          letterSpacing: 1,
        ),
      );
    }
    return SizedBox(
      width: 40,
      height: 24,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            child: Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.85),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            left: 14,
            child: Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.45),
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
