import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../core/widgets/sub_page_scaffold.dart';
import '../../../home/presentation/providers/bank_providers.dart';

class ReferPage extends ConsumerWidget {
  const ReferPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    final firstName = user.name.split(' ').first;
    final code = 'NIMBUS-${firstName.toUpperCase()}24';

    return SubPageScaffold(
      eyebrow: 'INVITE FRIENDS',
      title: 'Refer a friend',
      subtitle: 'Give \$20, get \$20 — invite friends to Nimbus.',
      children: [
        Container(
          padding: const EdgeInsets.all(AppSpacing.xl),
          decoration: BoxDecoration(
            gradient: context.colors.primaryGradient,
            borderRadius: BorderRadius.circular(AppSpacing.radiusXl),
            boxShadow: [
              BoxShadow(
                color: context.colors.primary.withValues(alpha: 0.28),
                blurRadius: 30,
                offset: const Offset(0, 14),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.card_giftcard_rounded,
                color: context.colors.textInverse,
                size: 32,
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                'Give \$20, get \$20',
                style: AppTextStyles.headlineLarge.copyWith(
                  color: context.colors.textInverse,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                'When a friend joins Nimbus with your code and makes their '
                'first transfer, you both get \$20.',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: context.colors.textInverse.withValues(alpha: 0.9),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.xl),
        Text('YOUR REFERRAL CODE', style: AppTextStyles.overline),
        const SizedBox(height: AppSpacing.sm),
        Container(
          padding: const EdgeInsets.all(AppSpacing.lg),
          decoration: BoxDecoration(
            color: context.colors.surface,
            borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
            border: Border.all(color: context.colors.border),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  code,
                  style: AppTextStyles.headlineMedium.copyWith(
                    letterSpacing: 1.2,
                    color: context.colors.primary,
                  ),
                ),
              ),
              Icon(Icons.qr_code_2_rounded, color: context.colors.textMuted),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        PrimaryButton(
          label: 'Copy code',
          icon: Icons.copy_rounded,
          variant: PrimaryButtonVariant.subtle,
          onPressed: () {
            Clipboard.setData(ClipboardData(text: code));
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: context.colors.surfaceElevated,
                behavior: SnackBarBehavior.floating,
                content: Text(
                  'Copied to clipboard',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: context.colors.textPrimary,
                  ),
                ),
              ),
            );
          },
        ),
        const SizedBox(height: AppSpacing.xxl),
        Text('HOW IT WORKS', style: AppTextStyles.overline),
        const SizedBox(height: AppSpacing.sm),
        const _StepTile(
          number: '1',
          title: 'Share your code',
          subtitle: 'Send your referral code to a friend, family member, or anyone.',
        ),
        const _StepTile(
          number: '2',
          title: 'They sign up',
          subtitle: 'Your friend downloads Nimbus and enters your code when they join.',
        ),
        const _StepTile(
          number: '3',
          title: 'You both get paid',
          subtitle: 'After their first transfer, \$20 lands in each of your accounts.',
        ),
      ],
    );
  }
}

class _StepTile extends StatelessWidget {
  const _StepTile({
    required this.number,
    required this.title,
    required this.subtitle,
  });
  final String number;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 28,
            height: 28,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: context.colors.surfaceElevated,
              shape: BoxShape.circle,
            ),
            child: Text(
              number,
              style: AppTextStyles.labelMedium.copyWith(color: context.colors.primary),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.titleSmall),
                const SizedBox(height: 2),
                Text(subtitle, style: AppTextStyles.bodySmall),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
