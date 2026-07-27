import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../home/presentation/providers/bank_providers.dart';
import '../providers/request_providers.dart';

class RequestSuccessPage extends ConsumerWidget {
  const RequestSuccessPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final draft = ref.watch(requestDraftProvider);
    final contacts = ref.watch(contactsProvider);
    final contact = contacts.firstWhere(
      (c) => c.id == draft.contactId,
      orElse: () => contacts.first,
    );
    final currency = NumberFormat.currency(locale: 'en_US', symbol: '\$');

    return Scaffold(
      backgroundColor: context.colors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.pageHPadding,
            AppSpacing.md,
            AppSpacing.pageHPadding,
            AppSpacing.md,
          ),
          child: Column(
            children: [
              const Spacer(),
              Container(
                width: 96,
                height: 96,
                decoration: BoxDecoration(
                  gradient: context.colors.primaryGradient,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: context.colors.primary.withValues(alpha: 0.28),
                      blurRadius: 30,
                      offset: const Offset(0, 12),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.check_rounded,
                  size: 48,
                  color: context.colors.textInverse,
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              Text(
                'Request sent.',
                textAlign: TextAlign.center,
                style: AppTextStyles.displayLarge,
              ),
              const SizedBox(height: AppSpacing.sm),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
                child: Text(
                  '${currency.format(draft.amount)} requested from ${contact.name}. '
                  'We’ll notify you when they pay.',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.bodyLarge,
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Amount', style: AppTextStyles.labelMedium),
                        const SizedBox(height: 2),
                        Text(
                          currency.format(draft.amount),
                          style: AppTextStyles.titleMedium,
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('Status', style: AppTextStyles.labelMedium),
                        const SizedBox(height: 2),
                        Text(
                          'Pending',
                          style: AppTextStyles.titleMedium.copyWith(
                            color: context.colors.warning,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Spacer(),
              PrimaryButton(
                label: 'Done',
                icon: Icons.check_rounded,
                onPressed: () => context.go('/home'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
