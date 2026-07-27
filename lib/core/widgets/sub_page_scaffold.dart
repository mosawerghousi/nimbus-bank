import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../extensions/context_extensions.dart';
import '../../app/theme/app_spacing.dart';
import '../../app/theme/app_text_styles.dart';
import 'primary_button.dart';

/// Shared scaffold for secondary screens reached from the profile menu —
/// keeps an editorial header (eyebrow + display title) and consistent
/// back-arrow + optional trailing action.
class SubPageScaffold extends StatelessWidget {
  const SubPageScaffold({
    super.key,
    required this.eyebrow,
    required this.title,
    this.subtitle,
    required this.children,
    this.trailing,
    this.bottom,
  });

  final String eyebrow;
  final String title;
  final String? subtitle;
  final List<Widget> children;
  final Widget? trailing;
  final Widget? bottom;

  @override
  Widget build(BuildContext context) {
    final topInset = MediaQuery.viewPaddingOf(context).top;
    return Scaffold(
      backgroundColor: context.colors.background,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(
                AppSpacing.pageHPadding,
                topInset > 0 ? AppSpacing.sm : AppSpacing.md,
                AppSpacing.pageHPadding,
                AppSpacing.lg,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleIconButton(
                        icon: Icons.arrow_back_rounded,
                        onPressed: () =>
                            context.canPop() ? context.pop() : context.go('/profile'),
                      ),
                      const Spacer(),
                      ?trailing,
                    ],
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Text(eyebrow, style: AppTextStyles.overline),
                  const SizedBox(height: AppSpacing.xs),
                  Text(title, style: AppTextStyles.displayMedium),
                  if (subtitle != null) ...[
                    const SizedBox(height: AppSpacing.xs),
                    Text(subtitle!, style: AppTextStyles.bodyMedium),
                  ],
                ],
              ),
            ),
            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.fromLTRB(
                  AppSpacing.pageHPadding,
                  0,
                  AppSpacing.pageHPadding,
                  bottom != null ? 120 : AppSpacing.huge,
                ),
                children: children,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: bottom == null
          ? null
          : Padding(
              padding: EdgeInsets.fromLTRB(
                AppSpacing.pageHPadding,
                AppSpacing.md,
                AppSpacing.pageHPadding,
                MediaQuery.viewPaddingOf(context).bottom + AppSpacing.md,
              ),
              child: bottom,
            ),
    );
  }
}
