import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../core/widgets/network_hero_image.dart';
import '../../../../core/widgets/primary_button.dart';

class _Slide {
  const _Slide({
    required this.image,
    required this.eyebrow,
    required this.title,
    required this.body,
  });
  final String image;
  final String eyebrow;
  final String title;
  final String body;
}

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final _controller = PageController();
  int _index = 0;

  List<_Slide> _slides(BuildContext context) => [
        _Slide(
          image:
              'https://images.unsplash.com/photo-1454165804606-c3d57bc86b40?auto=format&fit=crop&w=1600&q=80',
          eyebrow: context.strings.onboardingSlide1Eyebrow,
          title: context.strings.onboardingSlide1Title,
          body: context.strings.onboardingSlide1Body,
        ),
        _Slide(
          image:
              'https://images.unsplash.com/photo-1419242902214-272b3f66ee7a?auto=format&fit=crop&w=1600&q=80',
          eyebrow: context.strings.onboardingSlide2Eyebrow,
          title: context.strings.onboardingSlide2Title,
          body: context.strings.onboardingSlide2Body,
        ),
        _Slide(
          image:
              'https://images.unsplash.com/photo-1556742049-0cfed4f6a45d?auto=format&fit=crop&w=1600&q=80',
          eyebrow: context.strings.onboardingSlide3Eyebrow,
          title: context.strings.onboardingSlide3Title,
          body: context.strings.onboardingSlide3Body,
        ),
      ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _next() {
    if (_index == _slides(context).length - 1) {
      context.go('/login');
    } else {
      _controller.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final topInset = MediaQuery.viewPaddingOf(context).top;
    final bottomInset = MediaQuery.viewPaddingOf(context).bottom;
    final slides = _slides(context);

    return Scaffold(
      backgroundColor: context.colors.background,
      body: Stack(
        children: [
          PageView.builder(
            controller: _controller,
            itemCount: slides.length,
            onPageChanged: (i) => setState(() => _index = i),
            itemBuilder: (context, i) {
              final slide = slides[i];
              return Stack(
                fit: StackFit.expand,
                children: [
                  NetworkHeroImage(url: slide.image, fit: BoxFit.cover),
                  Container(
                    decoration: BoxDecoration(gradient: context.colors.heroScrim),
                  ),
                ],
              );
            },
          ),
          Positioned(
            top: topInset + AppSpacing.md,
            left: AppSpacing.pageHPadding,
            right: AppSpacing.pageHPadding,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        gradient: context.colors.primaryGradient,
                        borderRadius: BorderRadius.circular(AppSpacing.radiusXs),
                      ),
                      child: Icon(
                        Icons.blur_on_rounded,
                        size: 18,
                        color: context.colors.textInverse,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Text(
                      'Nimbus',
                      style: AppTextStyles.headlineMedium.copyWith(
                        letterSpacing: 3,
                      ),
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () => context.go('/login'),
                  child: Text(
                    context.strings.onboardingSkip,
                    style: AppTextStyles.labelMedium.copyWith(
                      color: context.colors.textPrimary,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                AppSpacing.pageHPadding,
                AppSpacing.xl,
                AppSpacing.pageHPadding,
                bottomInset + AppSpacing.xl,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 400),
                    child: Column(
                      key: ValueKey(_index),
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          slides[_index].eyebrow,
                          style: AppTextStyles.overline,
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        Text(
                          slides[_index].title,
                          style: AppTextStyles.displayLarge,
                        ),
                        const SizedBox(height: AppSpacing.md),
                        Text(
                          slides[_index].body,
                          style: AppTextStyles.bodyLarge,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xxl),
                  Row(
                    children: [
                      Row(
                        children: List.generate(slides.length, (i) {
                          final active = i == _index;
                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeOut,
                            margin: const EdgeInsets.only(right: 6),
                            width: active ? 22 : 6,
                            height: 6,
                            decoration: BoxDecoration(
                              color: active
                                  ? context.colors.primary
                                  : context.colors.textMuted,
                              borderRadius:
                                  BorderRadius.circular(AppSpacing.radiusFull),
                            ),
                          );
                        }),
                      ),
                      const Spacer(),
                      PrimaryButton(
                        label: _index == slides.length - 1
                            ? context.strings.onboardingGetStarted
                            : context.strings.commonContinue,
                        icon: Icons.arrow_forward_rounded,
                        onPressed: _next,
                        expanded: false,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
