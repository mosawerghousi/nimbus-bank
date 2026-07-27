import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../core/widgets/network_hero_image.dart';
import '../../../../core/widgets/primary_button.dart';
import '../widgets/auth_text_field.dart';
import '../widgets/social_button.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _acceptTerms = false;
  bool _loading = false;

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (!_acceptTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: context.colors.surfaceElevated,
          content: Text(
            context.strings.authAcceptTermsError,
            style: AppTextStyles.bodyMedium.copyWith(
              color: context.colors.textPrimary,
            ),
          ),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }
    setState(() => _loading = true);
    await Future.delayed(const Duration(milliseconds: 700));
    if (!mounted) return;
    setState(() => _loading = false);
    context.go('/home');
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
              height: 220,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  const NetworkHeroImage(
                    url:
                        'https://images.unsplash.com/photo-1419242902214-272b3f66ee7a?auto=format&fit=crop&w=1600&q=80',
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
                          : context.go('/login'),
                    ),
                  ),
                  Positioned(
                    left: AppSpacing.pageHPadding,
                    right: AppSpacing.pageHPadding,
                    bottom: AppSpacing.lg,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(context.strings.authJoinNimbus, style: AppTextStyles.overline),
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          context.strings.authCreateAccountTitle,
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
                      label: context.strings.authFullNameLabel,
                      hint: 'Alex Morgan',
                      icon: Icons.person_outline_rounded,
                      controller: _name,
                      textInputAction: TextInputAction.next,
                      validator: (v) {
                        if (v == null || v.trim().isEmpty) {
                          return context.strings.authFullNameRequired;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: AppSpacing.md),
                    AuthTextField(
                      label: context.strings.authEmailLabel,
                      hint: 'you@example.com',
                      icon: Icons.mail_outline_rounded,
                      controller: _email,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      validator: (v) {
                        if (v == null || v.isEmpty) return context.strings.authEmailRequired;
                        if (!v.contains('@')) return context.strings.authEmailInvalid;
                        return null;
                      },
                    ),
                    const SizedBox(height: AppSpacing.md),
                    AuthTextField(
                      label: context.strings.authPasswordLabel,
                      hint: context.strings.authPasswordMinLength(8),
                      icon: Icons.lock_outline_rounded,
                      controller: _password,
                      obscure: true,
                      textInputAction: TextInputAction.done,
                      onSubmitted: (_) => _submit(),
                      validator: (v) {
                        if (v == null || v.isEmpty) {
                          return context.strings.authPasswordRequired;
                        }
                        if (v.length < 8) return context.strings.authPasswordMinLength(8);
                        return null;
                      },
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: GestureDetector(
                            onTap: () =>
                                setState(() => _acceptTerms = !_acceptTerms),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 180),
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                gradient: _acceptTerms
                                    ? context.colors.primaryGradient
                                    : null,
                                color:
                                    _acceptTerms ? null : context.colors.surface,
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                  color: _acceptTerms
                                      ? context.colors.primary
                                      : context.colors.border,
                                  width: 1.4,
                                ),
                              ),
                              child: _acceptTerms
                                  ? Icon(
                                      Icons.check_rounded,
                                      size: 14,
                                      color: context.colors.textInverse,
                                    )
                                  : null,
                            ),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        Expanded(
                          child: Text.rich(
                            TextSpan(
                              style: AppTextStyles.bodySmall,
                              children: [
                                TextSpan(text: context.strings.authAgreeToTermsPrefix),
                                TextSpan(
                                  text: context.strings.authTermsOfService,
                                  style: AppTextStyles.bodySmall.copyWith(
                                    color: context.colors.primary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                TextSpan(text: context.strings.authAgreeToTermsAnd),
                                TextSpan(
                                  text: context.strings.authPrivacyPolicy,
                                  style: AppTextStyles.bodySmall.copyWith(
                                    color: context.colors.primary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                TextSpan(text: context.strings.authAgreeToTermsSuffix),
                              ],
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
                            label: context.strings.authCreateAccount,
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
                            context.strings.authOrSignUpWith,
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
                          onPressed: () => context.go('/home'),
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        SocialButton(
                          icon: Icons.g_mobiledata_rounded,
                          label: 'Google',
                          onPressed: () => context.go('/home'),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.xxl),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          context.strings.authAlreadyMember,
                          style: AppTextStyles.bodyMedium,
                        ),
                        GestureDetector(
                          onTap: () => context.go('/login'),
                          child: Text(
                            context.strings.authSignIn,
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
}
