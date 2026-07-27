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

  List<_Faq> _faqs(BuildContext context) => [
        _Faq(context.strings.helpFaq1Q, context.strings.helpFaq1A),
        _Faq(context.strings.helpFaq2Q, context.strings.helpFaq2A),
        _Faq(context.strings.helpFaq3Q, context.strings.helpFaq3A),
        _Faq(context.strings.helpFaq4Q, context.strings.helpFaq4A),
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
    final faqs = _faqs(context);
    return SubPageScaffold(
      eyebrow: context.strings.helpEyebrow,
      title: context.strings.helpSupport,
      subtitle: context.strings.helpSubtitle,
      children: [
        Text(context.strings.helpFrequentlyAsked, style: AppTextStyles.overline),
        const SizedBox(height: AppSpacing.sm),
        ...List.generate(faqs.length, (i) {
          final faq = faqs[i];
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
        Text(context.strings.helpContactSupport, style: AppTextStyles.overline),
        const SizedBox(height: AppSpacing.sm),
        _ContactTile(
          icon: Icons.chat_bubble_outline_rounded,
          label: context.strings.helpChatWithUs,
          sublabel: context.strings.helpChatSublabel,
          onTap: () => _snack(context.strings.helpConnectingSnack),
        ),
        _ContactTile(
          icon: Icons.call_outlined,
          label: context.strings.helpCallSupport,
          sublabel: context.strings.helpCallSublabel,
          onTap: () => _snack(context.strings.helpCallingSnack),
        ),
        _ContactTile(
          icon: Icons.mail_outline_rounded,
          label: context.strings.helpEmailUs,
          sublabel: 'support@nimbusmail.com',
          onTap: () => _snack(context.strings.helpEmailSnack),
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
                Transform.flip(
                  flipX: Directionality.of(context) == TextDirection.rtl,
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 14,
                    color: context.colors.textMuted,
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
