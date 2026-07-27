import 'package:flutter/material.dart';

import 'app_colors.dart';

/// Theme-aware color tokens for Nimbus. Resolved off the active [ThemeData]
/// via [Theme.of]. Prefer `context.colors` in widget code.
@immutable
class ColorTokens extends ThemeExtension<ColorTokens> {
  const ColorTokens({
    required this.background,
    required this.surface,
    required this.surfaceElevated,
    required this.surfaceMuted,
    required this.primary,
    required this.primarySoft,
    required this.primaryDeep,
    required this.secondary,
    required this.textPrimary,
    required this.textSecondary,
    required this.textMuted,
    required this.textInverse,
    required this.warning,
    required this.error,
    required this.border,
    required this.divider,
    required this.scrim,
    required this.glass,
    required this.primaryGradient,
    required this.cardMidnight,
    required this.cardViolet,
    required this.cardMint,
    required this.heroScrim,
    required this.topScrim,
  });

  factory ColorTokens.dark() => const ColorTokens(
        background: AppColors.background,
        surface: AppColors.surface,
        surfaceElevated: AppColors.surfaceElevated,
        surfaceMuted: AppColors.surfaceMuted,
        primary: AppColors.primary,
        primarySoft: AppColors.primarySoft,
        primaryDeep: AppColors.primaryDeep,
        secondary: AppColors.secondary,
        textPrimary: AppColors.textPrimary,
        textSecondary: AppColors.textSecondary,
        textMuted: AppColors.textMuted,
        textInverse: AppColors.textInverse,
        warning: AppColors.warning,
        error: AppColors.error,
        border: AppColors.border,
        divider: AppColors.divider,
        scrim: AppColors.scrim,
        glass: AppColors.glass,
        primaryGradient: AppColors.primaryGradient,
        cardMidnight: AppColors.cardMidnight,
        cardViolet: AppColors.cardViolet,
        cardMint: AppColors.cardMint,
        heroScrim: AppColors.heroScrim,
        topScrim: AppColors.topScrim,
      );

  factory ColorTokens.light() => const ColorTokens(
        background: AppColorsLight.background,
        surface: AppColorsLight.surface,
        surfaceElevated: AppColorsLight.surfaceElevated,
        surfaceMuted: AppColorsLight.surfaceMuted,
        primary: AppColorsLight.primary,
        primarySoft: AppColorsLight.primarySoft,
        primaryDeep: AppColorsLight.primaryDeep,
        secondary: AppColorsLight.secondary,
        textPrimary: AppColorsLight.textPrimary,
        textSecondary: AppColorsLight.textSecondary,
        textMuted: AppColorsLight.textMuted,
        textInverse: AppColorsLight.textInverse,
        warning: AppColorsLight.warning,
        error: AppColorsLight.error,
        border: AppColorsLight.border,
        divider: AppColorsLight.divider,
        scrim: AppColorsLight.scrim,
        glass: AppColorsLight.glass,
        primaryGradient: AppColorsLight.primaryGradient,
        cardMidnight: AppColorsLight.cardMidnight,
        cardViolet: AppColorsLight.cardViolet,
        cardMint: AppColorsLight.cardMint,
        heroScrim: AppColorsLight.heroScrim,
        topScrim: AppColorsLight.topScrim,
      );

  final Color background;
  final Color surface;
  final Color surfaceElevated;
  final Color surfaceMuted;
  final Color primary;
  final Color primarySoft;
  final Color primaryDeep;
  final Color secondary;
  final Color textPrimary;
  final Color textSecondary;
  final Color textMuted;
  final Color textInverse;
  final Color warning;
  final Color error;
  final Color border;
  final Color divider;
  final Color scrim;
  final Color glass;
  final LinearGradient primaryGradient;
  final LinearGradient cardMidnight;
  final LinearGradient cardViolet;
  final LinearGradient cardMint;
  final LinearGradient heroScrim;
  final LinearGradient topScrim;

  @override
  ColorTokens copyWith({
    Color? background,
    Color? surface,
    Color? surfaceElevated,
    Color? surfaceMuted,
    Color? primary,
    Color? primarySoft,
    Color? primaryDeep,
    Color? secondary,
    Color? textPrimary,
    Color? textSecondary,
    Color? textMuted,
    Color? textInverse,
    Color? warning,
    Color? error,
    Color? border,
    Color? divider,
    Color? scrim,
    Color? glass,
    LinearGradient? primaryGradient,
    LinearGradient? cardMidnight,
    LinearGradient? cardViolet,
    LinearGradient? cardMint,
    LinearGradient? heroScrim,
    LinearGradient? topScrim,
  }) {
    return ColorTokens(
      background: background ?? this.background,
      surface: surface ?? this.surface,
      surfaceElevated: surfaceElevated ?? this.surfaceElevated,
      surfaceMuted: surfaceMuted ?? this.surfaceMuted,
      primary: primary ?? this.primary,
      primarySoft: primarySoft ?? this.primarySoft,
      primaryDeep: primaryDeep ?? this.primaryDeep,
      secondary: secondary ?? this.secondary,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      textMuted: textMuted ?? this.textMuted,
      textInverse: textInverse ?? this.textInverse,
      warning: warning ?? this.warning,
      error: error ?? this.error,
      border: border ?? this.border,
      divider: divider ?? this.divider,
      scrim: scrim ?? this.scrim,
      glass: glass ?? this.glass,
      primaryGradient: primaryGradient ?? this.primaryGradient,
      cardMidnight: cardMidnight ?? this.cardMidnight,
      cardViolet: cardViolet ?? this.cardViolet,
      cardMint: cardMint ?? this.cardMint,
      heroScrim: heroScrim ?? this.heroScrim,
      topScrim: topScrim ?? this.topScrim,
    );
  }

  @override
  ColorTokens lerp(ThemeExtension<ColorTokens>? other, double t) {
    if (other is! ColorTokens) return this;
    return ColorTokens(
      background: Color.lerp(background, other.background, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      surfaceElevated: Color.lerp(surfaceElevated, other.surfaceElevated, t)!,
      surfaceMuted: Color.lerp(surfaceMuted, other.surfaceMuted, t)!,
      primary: Color.lerp(primary, other.primary, t)!,
      primarySoft: Color.lerp(primarySoft, other.primarySoft, t)!,
      primaryDeep: Color.lerp(primaryDeep, other.primaryDeep, t)!,
      secondary: Color.lerp(secondary, other.secondary, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      textMuted: Color.lerp(textMuted, other.textMuted, t)!,
      textInverse: Color.lerp(textInverse, other.textInverse, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      error: Color.lerp(error, other.error, t)!,
      border: Color.lerp(border, other.border, t)!,
      divider: Color.lerp(divider, other.divider, t)!,
      scrim: Color.lerp(scrim, other.scrim, t)!,
      glass: Color.lerp(glass, other.glass, t)!,
      primaryGradient:
          LinearGradient.lerp(primaryGradient, other.primaryGradient, t)!,
      cardMidnight: LinearGradient.lerp(cardMidnight, other.cardMidnight, t)!,
      cardViolet: LinearGradient.lerp(cardViolet, other.cardViolet, t)!,
      cardMint: LinearGradient.lerp(cardMint, other.cardMint, t)!,
      heroScrim: LinearGradient.lerp(heroScrim, other.heroScrim, t)!,
      topScrim: LinearGradient.lerp(topScrim, other.topScrim, t)!,
    );
  }
}
