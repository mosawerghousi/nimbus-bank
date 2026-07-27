import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../core/widgets/sub_page_scaffold.dart';

enum _NotifKind { transaction, security, offer, system }

class _Notification {
  const _Notification({
    required this.id,
    required this.kind,
    required this.title,
    required this.body,
    required this.timeAgo,
    this.unread = false,
  });
  final String id;
  final _NotifKind kind;
  final String title;
  final String body;
  final String timeAgo;
  final bool unread;
}

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  final Set<String> _dismissed = {};
  final Set<String> _readManually = {};

  List<_Notification> _today(BuildContext context) => [
        _Notification(
          id: 'n1',
          kind: _NotifKind.transaction,
          title: context.strings.notifPayrollTitle,
          body: context.strings.notifPayrollBody,
          timeAgo: context.strings.notifTimeAgo2h,
          unread: true,
        ),
        _Notification(
          id: 'n2',
          kind: _NotifKind.security,
          title: context.strings.notifSignInTitle,
          body: context.strings.notifSignInBody,
          timeAgo: context.strings.notifTimeAgo5h,
          unread: true,
        ),
        _Notification(
          id: 'n3',
          kind: _NotifKind.offer,
          title: context.strings.notifSavingsRateTitle,
          body: context.strings.notifSavingsRateBody,
          timeAgo: context.strings.notifTimeAgo7h,
        ),
      ];

  List<_Notification> _earlier(BuildContext context) => [
        _Notification(
          id: 'n4',
          kind: _NotifKind.transaction,
          title: context.strings.notifCardDeclinedTitle,
          body: context.strings.notifCardDeclinedBody,
          timeAgo: context.strings.commonYesterday,
        ),
        _Notification(
          id: 'n5',
          kind: _NotifKind.system,
          title: context.strings.notifStatementReadyTitle,
          body: context.strings.notifStatementReadyBody,
          timeAgo: context.strings.notifTimeAgo3d,
        ),
        _Notification(
          id: 'n6',
          kind: _NotifKind.offer,
          title: context.strings.notifReferTitle,
          body: context.strings.notifReferBody,
          timeAgo: context.strings.notifTimeAgo1w,
        ),
      ];

  bool _isUnread(_Notification n) => n.unread && !_readManually.contains(n.id);

  @override
  Widget build(BuildContext context) {
    final todayList = _today(context).where((n) => !_dismissed.contains(n.id)).toList();
    final earlierList = _earlier(context).where((n) => !_dismissed.contains(n.id)).toList();
    final unreadCount =
        todayList.where(_isUnread).length + earlierList.where(_isUnread).length;

    return SubPageScaffold(
      eyebrow: context.strings.notificationsEyebrow,
      title: context.strings.notificationsTitle,
      subtitle: unreadCount == 0
          ? context.strings.notificationsAllCaughtUp
          : context.strings.notificationsUnreadCount(unreadCount),
      trailing: GestureDetector(
        onTap: () {
          setState(() {
            for (final n in [..._today(context), ..._earlier(context)]) {
              if (n.unread) _readManually.add(n.id);
            }
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.sm,
            vertical: 8,
          ),
          decoration: BoxDecoration(
            color: context.colors.surface,
            borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
            border: Border.all(color: context.colors.border),
          ),
          child: Text(
            context.strings.notificationsMarkAllRead,
            style: AppTextStyles.labelMedium.copyWith(
              color: context.colors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      children: [
        if (todayList.isNotEmpty) ...[
          Text(context.strings.commonToday, style: AppTextStyles.overline),
          const SizedBox(height: AppSpacing.sm),
          ...todayList.map(
            (n) => Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.xs),
              child: _NotifTile(
                n: n,
                isUnread: _isUnread(n),
                onDismiss: () => setState(() => _dismissed.add(n.id)),
                onTap: () => setState(() => _readManually.add(n.id)),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
        ],
        if (earlierList.isNotEmpty) ...[
          Text(context.strings.notificationsEarlier, style: AppTextStyles.overline),
          const SizedBox(height: AppSpacing.sm),
          ...earlierList.map(
            (n) => Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.xs),
              child: _NotifTile(
                n: n,
                isUnread: _isUnread(n),
                onDismiss: () => setState(() => _dismissed.add(n.id)),
                onTap: () => setState(() => _readManually.add(n.id)),
              ),
            ),
          ),
        ],
        if (todayList.isEmpty && earlierList.isEmpty)
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: AppSpacing.xxl,
              horizontal: AppSpacing.lg,
            ),
            decoration: BoxDecoration(
              color: context.colors.surface,
              borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
              border: Border.all(color: context.colors.border),
            ),
            child: Column(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: context.colors.primary.withValues(alpha: 0.12),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.notifications_off_outlined,
                    size: 28,
                    color: context.colors.primary,
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                Text(context.strings.notificationsEmptyTitle, style: AppTextStyles.titleLarge),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  context.strings.notificationsEmptyBody,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.bodyMedium,
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class _NotifTile extends StatelessWidget {
  const _NotifTile({
    required this.n,
    required this.isUnread,
    required this.onDismiss,
    required this.onTap,
  });
  final _Notification n;
  final bool isUnread;
  final VoidCallback onDismiss;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final icon = _iconFor(n.kind);

    return Dismissible(
      key: ValueKey(n.id),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => onDismiss(),
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
        decoration: BoxDecoration(
          color: context.colors.error.withValues(alpha: 0.16),
          borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        ),
        child: Icon(Icons.delete_outline_rounded, color: context.colors.error),
      ),
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
              border: Border.all(
                color: isUnread
                    ? context.colors.primary.withValues(alpha: 0.35)
                    : context.colors.border,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: context.colors.primary.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
                  ),
                  child: Icon(icon, size: 18, color: context.colors.primary),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              n.title,
                              style: AppTextStyles.titleSmall,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (isUnread)
                            Container(
                              width: 8,
                              height: 8,
                              margin: const EdgeInsets.only(left: AppSpacing.xs),
                              decoration: BoxDecoration(
                                color: context.colors.primary,
                                shape: BoxShape.circle,
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        n.body,
                        style: AppTextStyles.bodySmall,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        n.timeAgo,
                        style: AppTextStyles.labelMedium.copyWith(
                          color: context.colors.textMuted,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  IconData _iconFor(_NotifKind k) => switch (k) {
        _NotifKind.transaction => Icons.receipt_long_rounded,
        _NotifKind.security => Icons.shield_outlined,
        _NotifKind.offer => Icons.local_offer_outlined,
        _NotifKind.system => Icons.description_outlined,
      };
}
