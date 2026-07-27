import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../core/widgets/language_selector.dart';
import '../../../../core/widgets/network_hero_image.dart';
import '../../../../core/widgets/theme_mode_selector.dart';
import '../../../home/presentation/providers/bank_providers.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    final accounts = ref.watch(accountsProvider);
    final cards = ref.watch(cardsProvider);
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
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  gradient: context.colors.primaryGradient,
                  shape: BoxShape.circle,
                ),
                child: ClipOval(
                  child: NetworkHeroImage(
                    url: user.avatarUrl,
                    width: 64,
                    height: 64,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(user.name, style: AppTextStyles.headlineMedium),
                    const SizedBox(height: 2),
                    Text(
                      user.email,
                      style: AppTextStyles.bodySmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.sm,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        gradient: context.colors.primaryGradient,
                        borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
                      ),
                      child: Text(
                        context.strings.profileVerifiedMember,
                        style: AppTextStyles.overline.copyWith(
                          color: context.colors.textInverse,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xl),
          Row(
            children: [
              Expanded(
                child: _StatTile(
                  label: context.strings.profileAccountsStat,
                  value: '${accounts.length}',
                  icon: Icons.account_balance_rounded,
                  onTap: () => context.push('/profile/linked-accounts'),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: _StatTile(
                  label: context.strings.navCards,
                  value: '${cards.length}',
                  icon: Icons.credit_card_rounded,
                  onTap: () => context.go('/cards'),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: _StatTile(
                  label: context.strings.profileSinceStat,
                  value: '2024',
                  icon: Icons.workspace_premium_rounded,
                  onTap: () => _snack(
                    context,
                    context.strings.profileMemberSince,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xxl),
          Text(context.strings.profileAppearance, style: AppTextStyles.overline),
          const SizedBox(height: AppSpacing.xs),
          Text(context.strings.profileTheme, style: AppTextStyles.headlineMedium),
          const SizedBox(height: AppSpacing.md),
          const ThemeModeSelector(),
          const SizedBox(height: AppSpacing.xxl),
          Text(context.strings.profileLanguageEyebrow, style: AppTextStyles.overline),
          const SizedBox(height: AppSpacing.xs),
          Text(context.strings.profileLanguage, style: AppTextStyles.headlineMedium),
          const SizedBox(height: AppSpacing.md),
          const LanguageSelector(),
          const SizedBox(height: AppSpacing.xxl),
          Text(context.strings.profileAccountEyebrow, style: AppTextStyles.overline),
          const SizedBox(height: AppSpacing.xs),
          Text(context.strings.profileSettingsHeadline, style: AppTextStyles.headlineMedium),
          const SizedBox(height: AppSpacing.md),
          _MenuItem(
            icon: Icons.person_outline_rounded,
            label: context.strings.personalInfoTitle,
            onTap: () => context.push('/profile/personal-info'),
          ),
          _MenuItem(
            icon: Icons.shield_outlined,
            label: context.strings.securityTitle,
            onTap: () => context.push('/profile/security'),
          ),
          _MenuItem(
            icon: Icons.notifications_outlined,
            label: context.strings.notificationsTitle,
            onTap: () => context.push('/profile/notifications'),
          ),
          _MenuItem(
            icon: Icons.account_balance_outlined,
            label: context.strings.linkedAccountsTitle,
            onTap: () => context.push('/profile/linked-accounts'),
          ),
          _MenuItem(
            icon: Icons.help_outline_rounded,
            label: context.strings.helpSupport,
            onTap: () => context.push('/profile/help'),
          ),
          const SizedBox(height: AppSpacing.md),
          _MenuItem(
            icon: Icons.logout_rounded,
            label: context.strings.menuLogOut,
            tinted: true,
            onTap: () => _confirmSignOut(context),
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

  Future<void> _confirmSignOut(BuildContext context) async {
    await showModalBottomSheet<void>(
      context: context,
      backgroundColor: context.colors.surface,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppSpacing.radiusXl)),
      ),
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.pageHPadding,
              AppSpacing.md,
              AppSpacing.pageHPadding,
              AppSpacing.md,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 36,
                  height: 4,
                  decoration: BoxDecoration(
                    color: context.colors.border,
                    borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: context.colors.error.withValues(alpha: 0.12),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.logout_rounded,
                    size: 28,
                    color: context.colors.error,
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                Text(context.strings.logOutConfirmTitle, style: AppTextStyles.headlineLarge),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  context.strings.logOutConfirmBody,
                  style: AppTextStyles.bodyMedium,
                ),
                const SizedBox(height: AppSpacing.xl),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            vertical: AppSpacing.md,
                          ),
                          side: BorderSide(color: context.colors.border),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(AppSpacing.radiusFull),
                          ),
                        ),
                        onPressed: () => Navigator.of(sheetContext).pop(),
                        child: Text(context.strings.commonCancel, style: AppTextStyles.labelLarge),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: context.colors.error,
                          padding: const EdgeInsets.symmetric(
                            vertical: AppSpacing.md,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(AppSpacing.radiusFull),
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(sheetContext).pop();
                          context.go('/login');
                        },
                        child: Text(
                          context.strings.menuLogOut,
                          style: AppTextStyles.labelLarge.copyWith(
                            color: context.colors.textInverse,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({
    required this.label,
    required this.value,
    required this.icon,
    this.onTap,
  });
  final String label;
  final String value;
  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.colors.surface,
      borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.md,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
            border: Border.all(color: context.colors.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, size: 18, color: context.colors.primary),
              const SizedBox(height: AppSpacing.sm),
              Text(value, style: AppTextStyles.headlineMedium),
              const SizedBox(height: 2),
              Text(label, style: AppTextStyles.labelMedium),
            ],
          ),
        ),
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  const _MenuItem({
    required this.icon,
    required this.label,
    this.tinted = false,
    this.onTap,
  });
  final IconData icon;
  final String label;
  final bool tinted;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
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
                    style: AppTextStyles.titleSmall.copyWith(
                      color: tinted ? context.colors.error : context.colors.textPrimary,
                    ),
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
