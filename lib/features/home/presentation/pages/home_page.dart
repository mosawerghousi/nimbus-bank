import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../core/widgets/network_hero_image.dart';
import '../../../../core/widgets/section_header.dart';
import '../providers/bank_providers.dart';
import '../widgets/account_carousel_card.dart';
import '../widgets/more_actions_sheet.dart';
import '../widgets/quick_action_button.dart';
import '../widgets/spend_chart.dart';
import '../widgets/transaction_detail_sheet.dart';
import '../widgets/transaction_tile.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final _carouselController = PageController(viewportFraction: 0.88);

  @override
  void dispose() {
    _carouselController.dispose();
    super.dispose();
  }

  String _greeting(BuildContext context) {
    final hour = DateTime.now().hour;
    if (hour < 12) return context.strings.homeGoodMorning;
    if (hour < 18) return context.strings.homeGoodAfternoon;
    return context.strings.homeGoodEvening;
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    final accounts = ref.watch(accountsProvider);
    final recent = ref.watch(recentTransactionsProvider);
    final selectedIndex = ref.watch(selectedAccountIndexProvider);
    final topInset = MediaQuery.viewPaddingOf(context).top;

    return Scaffold(
      backgroundColor: context.colors.background,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                AppSpacing.pageHPadding,
                topInset + AppSpacing.md,
                AppSpacing.pageHPadding,
                AppSpacing.lg,
              ),
              child: Row(
                children: [
                  ClipOval(
                    child: NetworkHeroImage(
                      url: user.avatarUrl,
                      width: 48,
                      height: 48,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${_greeting(context)},', style: AppTextStyles.bodyMedium),
                        Text(
                          user.name.split(' ').first,
                          style: AppTextStyles.headlineMedium,
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () => context.push('/profile/notifications'),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          width: 46,
                          height: 46,
                          decoration: BoxDecoration(
                            color: context.colors.surface,
                            borderRadius:
                                BorderRadius.circular(AppSpacing.radiusFull),
                            border: Border.all(color: context.colors.border),
                          ),
                          child: Icon(
                            Icons.notifications_outlined,
                            size: 20,
                            color: context.colors.textPrimary,
                          ),
                        ),
                        Positioned(
                          top: -2,
                          right: -2,
                          child: Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              color: context.colors.secondary,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: context.colors.background,
                                width: 2,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 200,
              child: PageView.builder(
                controller: _carouselController,
                itemCount: accounts.length,
                onPageChanged: (i) =>
                    ref.read(selectedAccountIndexProvider.notifier).select(i),
                itemBuilder: (context, i) {
                  return Padding(
                    padding: EdgeInsets.only(
                      left: i == 0 ? AppSpacing.pageHPadding : AppSpacing.xs,
                      right: i == accounts.length - 1
                          ? AppSpacing.pageHPadding
                          : AppSpacing.xs,
                    ),
                    child: AccountCarouselCard(account: accounts[i]),
                  );
                },
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(accounts.length, (i) {
                  final active = i == selectedIndex;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 220),
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    width: active ? 18 : 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: active
                          ? context.colors.primary
                          : context.colors.surfaceMuted,
                      borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
                    ),
                  );
                }),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.pageHPadding,
                AppSpacing.sm,
                AppSpacing.pageHPadding,
                AppSpacing.xxl,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  QuickActionButton(
                    icon: Icons.north_east_rounded,
                    label: context.strings.quickActionSend,
                    filled: true,
                    onTap: () => context.push('/transfer'),
                  ),
                  QuickActionButton(
                    icon: Icons.south_west_rounded,
                    label: context.strings.quickActionRequest,
                    onTap: () => context.push('/request'),
                  ),
                  QuickActionButton(
                    icon: Icons.add_rounded,
                    label: context.strings.quickActionTopUp,
                    onTap: () => context.push('/topup'),
                  ),
                  QuickActionButton(
                    icon: Icons.grid_view_rounded,
                    label: context.strings.quickActionMore,
                    onTap: () => MoreActionsSheet.show(context),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.pageHPadding,
              ),
              child: SectionHeader(
                eyebrow: context.strings.homeThisMonthEyebrow,
                title: context.strings.homeSpendingOverview,
                actionLabel: context.strings.homeDetails,
                onAction: () => context.push('/transactions'),
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.lg)),
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSpacing.pageHPadding),
              child: SpendChart(),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.xxl)),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.pageHPadding,
              ),
              child: SectionHeader(
                eyebrow: context.strings.homeLatestActivityEyebrow,
                title: context.strings.homeRecentTransactions,
                actionLabel: context.strings.homeSeeAll,
                onAction: () => context.push('/transactions'),
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.md)),
          SliverList.separated(
            itemCount: recent.length,
            separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.xs),
            itemBuilder: (context, i) => Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.pageHPadding,
              ),
              child: TransactionTile(
                transaction: recent[i],
                onTap: () => TransactionDetailSheet.show(context, recent[i]),
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.huge)),
        ],
      ),
    );
  }
}
