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

  static const _today = <_Notification>[
    _Notification(
      id: 'n1',
      kind: _NotifKind.transaction,
      title: 'Payroll deposit received',
      body: '\$5,200.00 from Acme Corp Payroll landed in Everyday.',
      timeAgo: '2h ago',
      unread: true,
    ),
    _Notification(
      id: 'n2',
      kind: _NotifKind.security,
      title: 'New sign-in detected',
      body: 'Your account was accessed from a new device in San Francisco.',
      timeAgo: '5h ago',
      unread: true,
    ),
    _Notification(
      id: 'n3',
      kind: _NotifKind.offer,
      title: 'Savings rate increased to 4.2%',
      body: 'Your Savings account now earns more, automatically.',
      timeAgo: '7h ago',
    ),
  ];

  static const _earlier = <_Notification>[
    _Notification(
      id: 'n4',
      kind: _NotifKind.transaction,
      title: 'Card payment declined',
      body: 'Nimbus Violet Credit ••2290 was declined at Amazon — limit reached.',
      timeAgo: 'Yesterday',
    ),
    _Notification(
      id: 'n5',
      kind: _NotifKind.system,
      title: 'Statement ready',
      body: 'Your July statement for Everyday is ready to view.',
      timeAgo: '3 days ago',
    ),
    _Notification(
      id: 'n6',
      kind: _NotifKind.offer,
      title: 'Refer a friend, get \$25',
      body: 'Invite a friend to Nimbus — you both get \$25 when they sign up.',
      timeAgo: '1 week ago',
    ),
  ];

  bool _isUnread(_Notification n) => n.unread && !_readManually.contains(n.id);

  @override
  Widget build(BuildContext context) {
    final today = _today.where((n) => !_dismissed.contains(n.id)).toList();
    final earlier = _earlier.where((n) => !_dismissed.contains(n.id)).toList();
    final unreadCount =
        today.where(_isUnread).length + earlier.where(_isUnread).length;

    return SubPageScaffold(
      eyebrow: 'INBOX',
      title: 'Notifications',
      subtitle: unreadCount == 0
          ? 'You’re all caught up.'
          : '$unreadCount unread message${unreadCount == 1 ? '' : 's'}.',
      trailing: GestureDetector(
        onTap: () {
          setState(() {
            for (final n in [..._today, ..._earlier]) {
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
            'Mark all read',
            style: AppTextStyles.labelMedium.copyWith(
              color: context.colors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      children: [
        if (today.isNotEmpty) ...[
          Text('Today', style: AppTextStyles.overline),
          const SizedBox(height: AppSpacing.sm),
          ...today.map(
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
        if (earlier.isNotEmpty) ...[
          Text('Earlier', style: AppTextStyles.overline),
          const SizedBox(height: AppSpacing.sm),
          ...earlier.map(
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
        if (today.isEmpty && earlier.isEmpty)
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
                Text('Nothing in the inbox', style: AppTextStyles.titleLarge),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  'We’ll let you know when something needs your attention.',
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
