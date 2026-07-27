import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../core/widgets/network_hero_image.dart';
import '../../../../core/widgets/sub_page_scaffold.dart';
import '../../../home/presentation/providers/bank_providers.dart';

class PersonalInfoPage extends ConsumerWidget {
  const PersonalInfoPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);

    return SubPageScaffold(
      eyebrow: 'ACCOUNT',
      title: 'Personal info',
      subtitle: 'Keep your details up to date for statements and support.',
      children: [
        Center(
          child: Stack(
            children: [
              Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  gradient: context.colors.primaryGradient,
                  shape: BoxShape.circle,
                ),
                child: ClipOval(
                  child: NetworkHeroImage(
                    url: user.avatarUrl,
                    width: 88,
                    height: 88,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: context.colors.surfaceElevated,
                    shape: BoxShape.circle,
                    border: Border.all(color: context.colors.background, width: 3),
                  ),
                  child: Icon(
                    Icons.edit_rounded,
                    size: 14,
                    color: context.colors.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.xxl),
        _InfoTile(icon: Icons.badge_outlined, label: 'Full name', value: user.name),
        _InfoTile(icon: Icons.mail_outline_rounded, label: 'Email', value: user.email),
        _InfoTile(icon: Icons.phone_outlined, label: 'Phone', value: user.phone),
        _InfoTile(
          icon: Icons.location_on_outlined,
          label: 'Address',
          value: '148 Market Street, San Francisco, CA',
        ),
        _InfoTile(
          icon: Icons.cake_outlined,
          label: 'Date of birth',
          value: 'March 14, 1994',
        ),
      ],
    );
  }
}

class _InfoTile extends StatelessWidget {
  const _InfoTile({required this.icon, required this.label, required this.value});
  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.xs),
      child: Material(
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        child: InkWell(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: context.colors.surfaceElevated,
                behavior: SnackBarBehavior.floating,
                content: Text(
                  'Editing $label is coming soon.',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: context.colors.textPrimary,
                  ),
                ),
              ),
            );
          },
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
                    color: context.colors.surfaceElevated,
                    borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
                  ),
                  child: Icon(icon, size: 16, color: context.colors.primary),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(label, style: AppTextStyles.labelMedium),
                      const SizedBox(height: 2),
                      Text(value, style: AppTextStyles.titleSmall),
                    ],
                  ),
                ),
                Icon(
                  Icons.edit_outlined,
                  size: 16,
                  color: context.colors.textMuted,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
