import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../core/widgets/network_hero_image.dart';
import '../../../../core/widgets/primary_button.dart';
import '../widgets/auth_text_field.dart';
import '../widgets/social_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController(text: 'alex.morgan@nimbusmail.com');
  final _password = TextEditingController();
  bool _remember = true;
  bool _loading = false;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);
    await Future.delayed(const Duration(milliseconds: 700));
    if (!mounted) return;
    setState(() => _loading = false);
    context.go('/home');
  }

  void _forgot() {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: context.colors.surface,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius:
            BorderRadius.vertical(top: Radius.circular(AppSpacing.radiusXl)),
      ),
      builder: (sheetContext) => _ForgotSheet(prefillEmail: _email.text),
    );
  }

  @override
  Widget build(BuildContext context) {
    final topInset = MediaQuery.viewPaddingOf(context).top;
    return Scaffold(
      backgroundColor: context.colors.background,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(
              height: 260,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  const NetworkHeroImage(
                    url:
                        'https://images.unsplash.com/photo-1499951360447-b19be8fe80f5?auto=format&fit=crop&w=1600&q=80',
                    fit: BoxFit.cover,
                  ),
                  Container(
                    decoration: BoxDecoration(gradient: context.colors.heroScrim),
                  ),
                  Positioned(
                    top: topInset + AppSpacing.sm,
                    left: AppSpacing.pageHPadding,
                    child: CircleIconButton(
                      icon: Icons.arrow_back_rounded,
                      onPressed: () => context.canPop()
                          ? context.pop()
                          : context.go('/onboarding'),
                    ),
                  ),
                  Positioned(
                    left: AppSpacing.pageHPadding,
                    right: AppSpacing.pageHPadding,
                    bottom: AppSpacing.lg,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('WELCOME BACK', style: AppTextStyles.overline),
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          'Sign in to your\nNimbus account.',
                          style: AppTextStyles.displayLarge,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.pageHPadding,
                AppSpacing.xl,
                AppSpacing.pageHPadding,
                AppSpacing.xl,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AuthTextField(
                      label: 'Email',
                      hint: 'you@example.com',
                      icon: Icons.mail_outline_rounded,
                      controller: _email,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      validator: (v) {
                        if (v == null || v.isEmpty) return 'Email is required';
                        if (!v.contains('@')) return 'Enter a valid email';
                        return null;
                      },
                    ),
                    const SizedBox(height: AppSpacing.md),
                    AuthTextField(
                      label: 'Password',
                      hint: '•••••••••',
                      icon: Icons.lock_outline_rounded,
                      controller: _password,
                      obscure: true,
                      textInputAction: TextInputAction.done,
                      onSubmitted: (_) => _submit(),
                      validator: (v) {
                        if (v == null || v.isEmpty) {
                          return 'Password is required';
                        }
                        if (v.length < 6) return 'At least 6 characters';
                        return null;
                      },
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Row(
                      children: [
                        _Checkbox(
                          value: _remember,
                          onChanged: (v) => setState(() => _remember = v),
                        ),
                        const SizedBox(width: AppSpacing.xs),
                        Text(
                          'Remember me',
                          style: AppTextStyles.labelMedium.copyWith(
                            color: context.colors.textPrimary,
                          ),
                        ),
                        const Spacer(),
                        TextButton(
                          onPressed: _forgot,
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: const Size(0, 0),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: Text(
                            'Forgot password?',
                            style: AppTextStyles.labelMedium.copyWith(
                              color: context.colors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    _loading
                        ? Container(
                            height: 58,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              gradient: context.colors.primaryGradient,
                              borderRadius:
                                  BorderRadius.circular(AppSpacing.radiusFull),
                            ),
                            child: SizedBox(
                              width: 22,
                              height: 22,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: context.colors.textInverse,
                              ),
                            ),
                          )
                        : PrimaryButton(
                            label: 'Sign in',
                            icon: Icons.arrow_forward_rounded,
                            onPressed: _submit,
                          ),
                    const SizedBox(height: AppSpacing.xl),
                    Row(
                      children: [
                        const Expanded(child: Divider()),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.sm,
                          ),
                          child: Text(
                            'or continue with',
                            style: AppTextStyles.labelMedium,
                          ),
                        ),
                        const Expanded(child: Divider()),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    Row(
                      children: [
                        SocialButton(
                          icon: Icons.apple,
                          label: 'Apple',
                          onPressed: () => _socialSignIn('Apple'),
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        SocialButton(
                          icon: Icons.g_mobiledata_rounded,
                          label: 'Google',
                          onPressed: () => _socialSignIn('Google'),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.xxl),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'New to Nimbus? ',
                          style: AppTextStyles.bodyMedium,
                        ),
                        GestureDetector(
                          onTap: () => context.go('/register'),
                          child: Text(
                            'Create account',
                            style: AppTextStyles.labelLarge.copyWith(
                              color: context.colors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _socialSignIn(String provider) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: context.colors.surfaceElevated,
        content: Text(
          'Continuing with $provider…',
          style: AppTextStyles.bodyMedium.copyWith(
            color: context.colors.textPrimary,
          ),
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
    Future.delayed(const Duration(milliseconds: 600), () {
      if (!mounted) return;
      context.go('/home');
    });
  }
}

class _Checkbox extends StatelessWidget {
  const _Checkbox({required this.value, required this.onChanged});
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          gradient: value ? context.colors.primaryGradient : null,
          color: value ? null : context.colors.surface,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: value ? context.colors.primary : context.colors.border,
            width: 1.4,
          ),
        ),
        child: value
            ? Icon(
                Icons.check_rounded,
                size: 14,
                color: context.colors.textInverse,
              )
            : null,
      ),
    );
  }
}

class _ForgotSheet extends StatefulWidget {
  const _ForgotSheet({required this.prefillEmail});
  final String prefillEmail;

  @override
  State<_ForgotSheet> createState() => _ForgotSheetState();
}

class _ForgotSheetState extends State<_ForgotSheet> {
  late final _controller = TextEditingController(text: widget.prefillEmail);
  bool _sent = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        AppSpacing.pageHPadding,
        AppSpacing.md,
        AppSpacing.pageHPadding,
        MediaQuery.viewInsetsOf(context).bottom + AppSpacing.lg,
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
          const SizedBox(height: AppSpacing.lg),
          Text('Forgot password?', style: AppTextStyles.headlineLarge),
          const SizedBox(height: AppSpacing.xs),
          Text(
            _sent
                ? 'We’ve sent a reset link to ${_controller.text}. Check your inbox.'
                : 'Enter the email tied to your Nimbus account and we’ll send a reset link.',
            style: AppTextStyles.bodyMedium,
          ),
          const SizedBox(height: AppSpacing.lg),
          if (!_sent)
            AuthTextField(
              label: 'Email',
              hint: 'you@example.com',
              icon: Icons.mail_outline_rounded,
              controller: _controller,
              keyboardType: TextInputType.emailAddress,
            ),
          const SizedBox(height: AppSpacing.lg),
          PrimaryButton(
            label: _sent ? 'Close' : 'Send reset link',
            icon: _sent ? Icons.check_rounded : Icons.arrow_forward_rounded,
            onPressed: () {
              if (_sent) {
                Navigator.of(context).pop();
              } else {
                setState(() => _sent = true);
              }
            },
          ),
        ],
      ),
    );
  }
}
