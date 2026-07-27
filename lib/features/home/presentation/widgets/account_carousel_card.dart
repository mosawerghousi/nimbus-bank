import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../domain/entities/account.dart';

/// A big gradient "account card" — rendered as the swipeable balance
/// carousel on the home dashboard. Visually modelled on a physical bank
/// card so switching accounts feels like flipping through a wallet.
class AccountCarouselCard extends StatelessWidget {
  const AccountCarouselCard({super.key, required this.account});

  final Account account;

  @override
  Widget build(BuildContext context) {
    final currency = NumberFormat.currency(
      locale: 'en_US',
      symbol: account.currency == 'USD' ? '\$' : '${account.currency} ',
    );
    final onCard = context.colors.textInverse;

    return Container(
      clipBehavior: Clip.antiAlias,
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        gradient: context.gradientForKey(account.colorKey),
        borderRadius: BorderRadius.circular(AppSpacing.radiusXl),
        boxShadow: [
          BoxShadow(
            color: context.colors.scrim.withValues(alpha: 0.28),
            blurRadius: 24,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -36,
            top: -36,
            child: Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: onCard.withValues(alpha: 0.06),
              ),
            ),
          ),
          Positioned(
            left: -24,
            bottom: -56,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: onCard.withValues(alpha: 0.05),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'NIMBUS · ${context.strings.accountTypeLabel(account.type).toUpperCase()}',
                    style: AppTextStyles.overline.copyWith(
                      color: onCard.withValues(alpha: 0.85),
                    ),
                  ),
                  const Spacer(),
                  Icon(
                    Icons.wifi_rounded,
                    size: 20,
                    color: onCard.withValues(alpha: 0.85),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.xl),
              Text(
                context.strings.homeAvailableBalance,
                style: AppTextStyles.bodySmall.copyWith(
                  color: onCard.withValues(alpha: 0.75),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                currency.format(account.balance),
                style: AppTextStyles.displaySmall.copyWith(color: onCard),
              ),
              const Spacer(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          account.name,
                          style: AppTextStyles.titleMedium.copyWith(
                            color: onCard,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          account.maskedNumber,
                          style: AppTextStyles.bodySmall.copyWith(
                            color: onCard.withValues(alpha: 0.75),
                            letterSpacing: 1.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.account_balance_rounded,
                    size: 22,
                    color: onCard.withValues(alpha: 0.85),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
