import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../core/widgets/sub_page_scaffold.dart';

class _Faq {
  const _Faq(this.question, this.answer);
  final String question;
  final String answer;
}

class HelpPage extends StatefulWidget {
  const HelpPage({super.key});

  @override
  State<HelpPage> createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  int? _expanded;

  static const _faqs = <_Faq>[
    _Faq(
      'How long do transfers take?',
      'Transfers between Nimbus accounts and to other Nimbus members are '
          'instant. Transfers to outside banks usually arrive within one '
          'business day.',
    ),
    _Faq(
      'How do I freeze a lost card?',
      'Open Cards, tap the card, then tap Freeze card. Purchases and '
          'withdrawals are blocked immediately — unfreeze it any time if you '
          'find it again.',
    ),
    _Faq(
      'Is my money insured?',
      'Yes — balances held with our partner bank are FDIC-insured up to the '
          'standard coverage limit, the same as a traditional bank account.',
    ),
    _Faq(
      'How do I dispute a transaction?',
      'Open the transaction from your history and tap Report an issue, or '
          'contact support below. We’ll investigate and follow up within 2 '
          'business days.',
    ),
  ];

  void _snack(String message) {
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

  @override
  Widget build(BuildContext context) {
    return SubPageScaffold(
      eyebrow: 'WE’RE HERE TO HELP',
      title: 'Help & support',
      subtitle: 'Answers to common questions, or reach a real person.',
      children: [
        Text('FREQUENTLY ASKED', style: AppTextStyles.overline),
        const SizedBox(height: AppSpacing.sm),
        ...List.generate(_faqs.length, (i) {
          final faq = _faqs[i];
          final open = _expanded == i;
          return Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.xs),
            child: Material(
              color: context.colors.surface,
              borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
              child: InkWell(
                borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
                onTap: () => setState(() => _expanded = open ? null : i),
                child: Container(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
                    border: Border.all(color: context.colors.border),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(faq.question, style: AppTextStyles.titleSmall),
                          ),
                          Icon(
                            open ? Icons.remove_rounded : Icons.add_rounded,
                            size: 18,
                            color: context.colors.primary,
                          ),
                        ],
                      ),
                      AnimatedSize(
                        duration: const Duration(milliseconds: 220),
                        curve: Curves.easeOutCubic,
                        alignment: Alignment.topLeft,
                        child: open
                            ? Padding(
                                padding: const EdgeInsets.only(top: AppSpacing.sm),
                                child: Text(faq.answer, style: AppTextStyles.bodyMedium),
                              )
                            : const SizedBox(width: double.infinity),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
        const SizedBox(height: AppSpacing.xl),
        Text('CONTACT SUPPORT', style: AppTextStyles.overline),
        const SizedBox(height: AppSpacing.sm),
        _ContactTile(
          icon: Icons.chat_bubble_outline_rounded,
          label: 'Chat with us',
          sublabel: 'Typically replies in a few minutes',
          onTap: () => _snack('Connecting you to a support specialist…'),
        ),
        _ContactTile(
          icon: Icons.call_outlined,
          label: 'Call support',
          sublabel: '1-800-555-0199 · 24/7',
          onTap: () => _snack('Calling 1-800-555-0199…'),
        ),
        _ContactTile(
          icon: Icons.mail_outline_rounded,
          label: 'Email us',
          sublabel: 'support@nimbusmail.com',
          onTap: () => _snack('Opening your email client…'),
        ),
      ],
    );
  }
}

class _ContactTile extends StatelessWidget {
  const _ContactTile({
    required this.icon,
    required this.label,
    required this.sublabel,
    required this.onTap,
  });
  final IconData icon;
  final String label;
  final String sublabel;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.xs),
      child: Material(
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        child: InkWell(
          borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
              border: Border.all(color: context.colors.border),
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
                      Text(label, style: AppTextStyles.titleSmall),
                      const SizedBox(height: 2),
                      Text(sublabel, style: AppTextStyles.bodySmall),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 14,
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
