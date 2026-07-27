import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Modern fintech typography — Space Grotesk (a geometric, slightly
/// technical display face) for display, headline & title styles pairs with
/// Inter (a highly legible UI workhorse) for body, label & overline. This
/// pairing is unique to the Nimbus kit and distinct from the serif/warm-sans
/// pairing used elsewhere in this workspace.
///
/// These tokens are intentionally COLOR-AGNOSTIC: color is supplied by the
/// active theme (via the app-level `DefaultTextStyle` and the [AppTheme]
/// `textTheme`, both resolved from `context.colors`). Call sites that need a
/// specific tone use `.copyWith(color: context.colors.x)`. Baking a fixed
/// color here would break light/dark theming.
class AppTextStyles {
  AppTextStyles._();

  static TextStyle get displayLarge => GoogleFonts.spaceGrotesk(
        fontSize: 40,
        fontWeight: FontWeight.w600,
        height: 1.08,
        letterSpacing: -0.6,
      );

  static TextStyle get displayMedium => GoogleFonts.spaceGrotesk(
        fontSize: 32,
        fontWeight: FontWeight.w600,
        height: 1.12,
        letterSpacing: -0.4,
      );

  static TextStyle get displaySmall => GoogleFonts.spaceGrotesk(
        fontSize: 26,
        fontWeight: FontWeight.w600,
        height: 1.16,
        letterSpacing: -0.3,
      );

  static TextStyle get headlineLarge => GoogleFonts.spaceGrotesk(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        height: 1.2,
      );

  static TextStyle get headlineMedium => GoogleFonts.spaceGrotesk(
        fontSize: 19,
        fontWeight: FontWeight.w600,
        height: 1.25,
      );

  static TextStyle get titleLarge => GoogleFonts.spaceGrotesk(
        fontSize: 17,
        fontWeight: FontWeight.w600,
        height: 1.3,
      );

  static TextStyle get titleMedium => GoogleFonts.spaceGrotesk(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        height: 1.35,
      );

  static TextStyle get titleSmall => GoogleFonts.spaceGrotesk(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        height: 1.35,
      );

  static TextStyle get bodyLarge => GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 1.5,
      );

  static TextStyle get bodyMedium => GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 1.5,
      );

  static TextStyle get bodySmall => GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        height: 1.4,
      );

  static TextStyle get labelLarge => GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        height: 1.2,
        letterSpacing: 0.2,
      );

  static TextStyle get labelMedium => GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        height: 1.2,
        letterSpacing: 0.3,
      );

  static TextStyle get overline => GoogleFonts.inter(
        fontSize: 11,
        fontWeight: FontWeight.w700,
        height: 1.2,
        letterSpacing: 1.8,
      );
}
