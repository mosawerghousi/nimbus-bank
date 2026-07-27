import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../core/widgets/sub_page_scaffold.dart';

class SecurityPage extends StatefulWidget {
  const SecurityPage({super.key});

  @override
  State<SecurityPage> createState() => _SecurityPageState();
}

class _SecurityPageState extends State<SecurityPage> {
  bool _biometrics = true;
  bool _twoFactor = true;
  bool _loginAlerts = true;

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
      eyebrow: 'PROTECT YOUR ACCOUNT',
      title: 'Security & PIN',
      subtitle: 'Manage how you sign in and keep your money safe.',
      children: [
        Material(
          color: context.colors.surface,
          borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
          child: InkWell(
            borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
            onTap: () => _snack('PIN change request sent to your device.'),
            child: Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                border: Border.all(color: context.colors.border),
                borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
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
                    child: Icon(
                      Icons.pin_outlined,
                      size: 16,
                      color: context.colors.primary,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('App PIN', style: AppTextStyles.titleSmall),
                        const SizedBox(height: 2),
                        Text('Last changed 4 months ago', style: AppTextStyles.bodySmall),
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
        const SizedBox(height: AppSpacing.md),
        Material(
          color: context.colors.surface,
          borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
          child: Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              border: Border.all(color: context.colors.border),
              borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
            ),
            child: Column(
              children: [
                _ToggleRow(
                  icon: Icons.fingerprint_rounded,
                  label: 'Face ID & Touch ID',
                  sublabel: 'Unlock Nimbus without your PIN',
                  value: _biometrics,
                  onChanged: (v) => setState(() => _biometrics = v),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: AppSpacing.sm),
                  child: Divider(),
                ),
                _ToggleRow(
                  icon: Icons.verified_user_outlined,
                  label: 'Two-factor authentication',
                  sublabel: 'Require a code for new devices',
                  value: _twoFactor,
                  onChanged: (v) => setState(() => _twoFactor = v),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: AppSpacing.sm),
                  child: Divider(),
                ),
                _ToggleRow(
                  icon: Icons.notifications_active_outlined,
                  label: 'Sign-in alerts',
                  sublabel: 'Get notified of new device sign-ins',
                  value: _loginAlerts,
                  onChanged: (v) => setState(() => _loginAlerts = v),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.xxl),
        Text('ACTIVE SESSIONS', style: AppTextStyles.overline),
        const SizedBox(height: AppSpacing.sm),
        _SessionTile(
          device: 'iPhone 15 Pro · San Francisco, CA',
          isCurrent: true,
        ),
        _SessionTile(
          device: 'MacBook Pro · San Francisco, CA',
          lastActive: '2 days ago',
          onRevoke: () => _snack('Session on MacBook Pro has been signed out.'),
        ),
      ],
    );
  }
}

class _ToggleRow extends StatelessWidget {
  const _ToggleRow({
    required this.icon,
    required this.label,
    required this.sublabel,
    required this.value,
    required this.onChanged,
  });
  final IconData icon;
  final String label;
  final String sublabel;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
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
        Switch(
          value: value,
          onChanged: onChanged,
          activeTrackColor: context.colors.primary,
        ),
      ],
    );
  }
}

class _SessionTile extends StatelessWidget {
  const _SessionTile({
    required this.device,
    this.isCurrent = false,
    this.lastActive,
    this.onRevoke,
  });
  final String device;
  final bool isCurrent;
  final String? lastActive;
  final VoidCallback? onRevoke;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.xs),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: context.colors.surface,
          borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
          border: Border.all(color: context.colors.border),
        ),
        child: Row(
          children: [
            Icon(
              Icons.devices_other_rounded,
              size: 20,
              color: context.colors.textSecondary,
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(device, style: AppTextStyles.titleSmall),
                  const SizedBox(height: 2),
                  Text(
                    isCurrent ? 'This device · Active now' : 'Last active $lastActive',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: isCurrent ? context.colors.secondary : context.colors.textMuted,
                    ),
                  ),
                ],
              ),
            ),
            if (!isCurrent)
              TextButton(
                onPressed: onRevoke,
                child: Text(
                  'Revoke',
                  style: AppTextStyles.labelMedium.copyWith(
                    color: context.colors.error,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
