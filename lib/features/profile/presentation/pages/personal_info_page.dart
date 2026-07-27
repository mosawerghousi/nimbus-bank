import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../core/widgets/network_hero_image.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../core/widgets/sub_page_scaffold.dart';
import '../../../home/presentation/providers/bank_providers.dart';

class PersonalInfoPage extends ConsumerWidget {
  const PersonalInfoPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);

    return SubPageScaffold(
      eyebrow: 'ACCOUNT',
      title: 'Personal info',
      subtitle: 'Keep your details up to date for statements and support.',
      children: [
        Center(
          child: Stack(
            children: [
              Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  gradient: context.colors.primaryGradient,
                  shape: BoxShape.circle,
                ),
                child: ClipOval(
                  child: NetworkHeroImage(
                    url: user.avatarUrl,
                    width: 88,
                    height: 88,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: context.colors.surfaceElevated,
                    shape: BoxShape.circle,
                    border: Border.all(color: context.colors.background, width: 3),
                  ),
                  child: Icon(
                    Icons.edit_rounded,
                    size: 14,
                    color: context.colors.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.xxl),
        _InfoTile(
          icon: Icons.badge_outlined,
          label: 'Full name',
          value: user.name,
          onTap: () => _editField(
            context: context,
            ref: ref,
            label: 'Full name',
            initialValue: user.name,
            onSave: (value) => ref.read(userProvider.notifier).updateField(name: value),
          ),
        ),
        _InfoTile(
          icon: Icons.mail_outline_rounded,
          label: 'Email',
          value: user.email,
          onTap: () => _editField(
            context: context,
            ref: ref,
            label: 'Email',
            initialValue: user.email,
            keyboardType: TextInputType.emailAddress,
            onSave: (value) => ref.read(userProvider.notifier).updateField(email: value),
          ),
        ),
        _InfoTile(
          icon: Icons.phone_outlined,
          label: 'Phone',
          value: user.phone,
          onTap: () => _editField(
            context: context,
            ref: ref,
            label: 'Phone',
            initialValue: user.phone,
            keyboardType: TextInputType.phone,
            onSave: (value) => ref.read(userProvider.notifier).updateField(phone: value),
          ),
        ),
        _InfoTile(
          icon: Icons.location_on_outlined,
          label: 'Address',
          value: user.address,
          onTap: () => _editField(
            context: context,
            ref: ref,
            label: 'Address',
            initialValue: user.address,
            onSave: (value) => ref.read(userProvider.notifier).updateField(address: value),
          ),
        ),
        _InfoTile(
          icon: Icons.cake_outlined,
          label: 'Date of birth',
          value: user.dateOfBirth,
          onTap: () => _editField(
            context: context,
            ref: ref,
            label: 'Date of birth',
            initialValue: user.dateOfBirth,
            onSave: (value) => ref.read(userProvider.notifier).updateField(dateOfBirth: value),
          ),
        ),
      ],
    );
  }

  /// Opens the shared single-field edit sheet for one Personal-info row,
  /// parameterized by label/initial value so every field reuses the same
  /// bottom sheet instead of five near-identical ones.
  void _editField({
    required BuildContext context,
    required WidgetRef ref,
    required String label,
    required String initialValue,
    required ValueChanged<String> onSave,
    TextInputType? keyboardType,
  }) {
    _EditFieldSheet.show(
      context,
      label: label,
      initialValue: initialValue,
      keyboardType: keyboardType,
      onSave: onSave,
    );
  }
}

/// Shared bottom sheet used by every editable row on Personal info — a
/// single pre-filled [TextField] plus a Save button, parameterized by
/// label/initial value/save callback so the five fields don't each need
/// their own near-identical sheet.
class _EditFieldSheet extends StatefulWidget {
  const _EditFieldSheet({
    required this.label,
    required this.initialValue,
    required this.onSave,
    this.keyboardType,
  });

  final String label;
  final String initialValue;
  final ValueChanged<String> onSave;
  final TextInputType? keyboardType;

  static Future<void> show(
    BuildContext context, {
    required String label,
    required String initialValue,
    required ValueChanged<String> onSave,
    TextInputType? keyboardType,
  }) {
    return showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => _EditFieldSheet(
        label: label,
        initialValue: initialValue,
        onSave: onSave,
        keyboardType: keyboardType,
      ),
    );
  }

  @override
  State<_EditFieldSheet> createState() => _EditFieldSheetState();
}

class _EditFieldSheetState extends State<_EditFieldSheet> {
  late final _controller = TextEditingController(text: widget.initialValue);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _save() {
    final value = _controller.text.trim();
    if (value.isEmpty) return;
    widget.onSave(value);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: SafeArea(
        top: false,
        child: Container(
          margin: const EdgeInsets.all(AppSpacing.sm),
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.pageHPadding,
            AppSpacing.md,
            AppSpacing.pageHPadding,
            AppSpacing.lg,
          ),
          decoration: BoxDecoration(
            color: context.colors.surface,
            borderRadius: BorderRadius.circular(AppSpacing.radiusXl),
            border: Border.all(color: context.colors.border),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 36,
                  height: 4,
                  decoration: BoxDecoration(
                    color: context.colors.border,
                    borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              Text('Edit ${widget.label.toLowerCase()}', style: AppTextStyles.headlineMedium),
              const SizedBox(height: AppSpacing.lg),
              TextField(
                controller: _controller,
                autofocus: true,
                keyboardType: widget.keyboardType,
                onSubmitted: (_) => _save(),
                style: AppTextStyles.bodyMedium.copyWith(color: context.colors.textPrimary),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: context.colors.surfaceElevated,
                  hintText: widget.label,
                  hintStyle: AppTextStyles.bodyMedium.copyWith(color: context.colors.textMuted),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: AppSpacing.md,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                    borderSide: BorderSide(color: context.colors.border),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                    borderSide: BorderSide(color: context.colors.border),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                    borderSide: BorderSide(color: context.colors.primary, width: 1.4),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              PrimaryButton(
                label: 'Save',
                icon: Icons.check_rounded,
                onPressed: _save,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  const _InfoTile({
    required this.icon,
    required this.label,
    required this.value,
    required this.onTap,
  });
  final IconData icon;
  final String label;
  final String value;
  final VoidCallback onTap;

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
                      Text(label, style: AppTextStyles.labelMedium),
                      const SizedBox(height: 2),
                      Text(value, style: AppTextStyles.titleSmall),
                    ],
                  ),
                ),
                Icon(
                  Icons.edit_outlined,
                  size: 16,
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
