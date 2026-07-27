import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../core/widgets/primary_button.dart';
import '../providers/external_accounts_providers.dart';

class _MockBank {
  const _MockBank(this.name, this.masked);
  final String name;
  final String masked;
}

/// Banks not already present in the "EXTERNAL BANKS" seed data — a purely
/// mock picker list, never a real bank directory.
const _availableBanks = [
  _MockBank('Wells Fargo', '•••• 7742'),
  _MockBank('Bank of America', '•••• 3390'),
  _MockBank('Citi', '•••• 6624'),
  _MockBank('Capital One', '•••• 1187'),
  _MockBank('US Bank', '•••• 9053'),
];

enum _Stage { pick, connecting, connected }

/// A mock bank-picker + fake spinner + success flow — intentionally never
/// asks for a username/password so it can't be mistaken for a real bank
/// login, even fictionally.
class ConnectBankPage extends ConsumerStatefulWidget {
  const ConnectBankPage({super.key});

  @override
  ConsumerState<ConnectBankPage> createState() => _ConnectBankPageState();
}

class _ConnectBankPageState extends ConsumerState<ConnectBankPage> {
  _Stage _stage = _Stage.pick;
  _MockBank? _selected;

  Future<void> _connect(_MockBank bank) async {
    setState(() {
      _selected = bank;
      _stage = _Stage.connecting;
    });
    await Future.delayed(const Duration(milliseconds: 1200));
    if (!mounted) return;
    setState(() => _stage = _Stage.connected);
  }

  void _finish() {
    final bank = _selected;
    if (bank != null) {
      ref
          .read(externalAccountsProvider.notifier)
          .add(ExternalAccount(bank.name, bank.masked));
    }
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final topInset = MediaQuery.viewPaddingOf(context).top;

    return Scaffold(
      backgroundColor: context.colors.background,
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            AppSpacing.pageHPadding,
            topInset > 0 ? AppSpacing.sm : AppSpacing.md,
            AppSpacing.pageHPadding,
            AppSpacing.md,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleIconButton(
                    icon: Icons.close_rounded,
                    onPressed: () => context.pop(),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(context.strings.connectBankLinkAccount, style: AppTextStyles.overline),
              const SizedBox(height: AppSpacing.xs),
              Text(context.strings.connectBankTitle, style: AppTextStyles.displayMedium),
              const SizedBox(height: AppSpacing.xs),
              Text(
                context.strings.connectBankSubtitle,
                style: AppTextStyles.bodyMedium,
              ),
              const SizedBox(height: AppSpacing.xl),
              Expanded(child: _buildStage(context)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStage(BuildContext context) {
    switch (_stage) {
      case _Stage.pick:
        return ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemCount: _availableBanks.length,
          separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.xs),
          itemBuilder: (context, i) {
            final bank = _availableBanks[i];
            return Material(
              color: context.colors.surface,
              borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
              child: InkWell(
                borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
                onTap: () => _connect(bank),
                child: Container(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
                    border: Border.all(color: context.colors.border),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: context.colors.surfaceElevated,
                          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                        ),
                        child: Icon(
                          Icons.account_balance_rounded,
                          size: 18,
                          color: context.colors.primary,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: Text(bank.name, style: AppTextStyles.titleSmall),
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
            );
          },
        );
      case _Stage.connecting:
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(color: context.colors.primary),
              const SizedBox(height: AppSpacing.xl),
              Text(
                context.strings.connectBankConnecting(_selected?.name ?? ''),
                style: AppTextStyles.titleMedium,
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                context.strings.connectBankTakesMoment,
                style: AppTextStyles.bodyMedium,
              ),
            ],
          ),
        );
      case _Stage.connected:
        return Column(
          children: [
            const Spacer(),
            Container(
              width: 88,
              height: 88,
              decoration: BoxDecoration(
                gradient: context.colors.primaryGradient,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: context.colors.primary.withValues(alpha: 0.28),
                    blurRadius: 28,
                    offset: const Offset(0, 12),
                  ),
                ],
              ),
              child: Icon(
                Icons.check_rounded,
                size: 42,
                color: context.colors.textInverse,
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            Text(
              context.strings.connectBankConnected(_selected?.name ?? ''),
              textAlign: TextAlign.center,
              style: AppTextStyles.headlineLarge,
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              context.strings.connectBankSeeUnderExternal,
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyMedium,
            ),
            const Spacer(),
            PrimaryButton(
              label: context.strings.commonDone,
              icon: Icons.check_rounded,
              onPressed: _finish,
            ),
          ],
        );
    }
  }
}
