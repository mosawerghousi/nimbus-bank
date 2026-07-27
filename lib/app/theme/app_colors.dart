import 'package:flutter/material.dart';

/// Nimbus palette — a modern neobank identity built on deep indigo-violet
/// and a mint-positive accent (distinct from the antique-gold hospitality
/// world and the coastal terracotta jewellery world). The dark variant is
/// the primary/default surface: near-black slate with a vivid indigo brand
/// accent; the light variant is a crisp near-white paper with the same
/// accent hues deepened for contrast.
///
/// Prefer reading colors via `context.colors` (a [ColorTokens] extension)
/// in widgets so they automatically switch with the active theme. These
/// raw classes are kept for the few static const sites that need
/// compile-time values and for use inside [AppTheme] / [ColorTokens] only.
///
/// Bank-card gradients ([cardMidnight]/[cardViolet]/[cardMint]) are kept
/// identical between [AppColors] and [AppColorsLight] on purpose — a
/// physical card's finish doesn't change when the phone switches to dark
/// mode, so the card visuals stay constant while every surrounding surface
/// still themes correctly.
class AppColors {
  AppColors._();

  // Backgrounds — near-black indigo-tinted slate
  static const Color background = Color(0xFF0B0E14);
  static const Color surface = Color(0xFF141822);
  static const Color surfaceElevated = Color(0xFF1C212E);
  static const Color surfaceMuted = Color(0xFF232838);

  // Brand — indigo / violet
  static const Color primary = Color(0xFF6C5CE7);
  static const Color primarySoft = Color(0xFF8E7FF2);
  static const Color primaryDeep = Color(0xFF4B3FB0);

  // Secondary accent — mint (positive / income)
  static const Color secondary = Color(0xFF00D9A3);

  // Text — cool near-white & slate greys
  static const Color textPrimary = Color(0xFFF4F5F7);
  static const Color textSecondary = Color(0xFFA6ACBB);
  static const Color textMuted = Color(0xFF6B7280);
  // Foreground for elements filled with [primaryGradient] (buttons, active
  // nav pill). The gradient is a dark-ish indigo in both themes, so this
  // stays a fixed near-white rather than flipping with [background].
  static const Color textInverse = Color(0xFFFFFFFF);

  // Status
  static const Color warning = Color(0xFFFFB020);
  static const Color error = Color(0xFFFF5C5C);

  // Borders & dividers
  static const Color border = Color(0x14FFFFFF);
  static const Color divider = Color(0x0DFFFFFF);

  // Overlays
  static const Color scrim = Color(0x99000000);
  static const Color glass = Color(0x14FFFFFF);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF8E7FF2), Color(0xFF6C5CE7), Color(0xFF4B3FB0)],
  );

  static const LinearGradient cardMidnight = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF3A3F4E), Color(0xFF1B1E27), Color(0xFF0A0B0F)],
  );

  static const LinearGradient cardViolet = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF7C6FF0), Color(0xFF5B4BD6), Color(0xFF2E2570)],
  );

  static const LinearGradient cardMint = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF1FE6B8), Color(0xFF00C48C), Color(0xFF00785A)],
  );

  static const LinearGradient heroScrim = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0x000B0E14),
      Color(0x330B0E14),
      Color(0xCC0B0E14),
      Color(0xFF0B0E14),
    ],
    stops: [0.0, 0.45, 0.85, 1.0],
  );

  static const LinearGradient topScrim = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0x99000000), Color(0x00000000)],
  );
}

/// Light counterpart to [AppColors]. Backgrounds become a crisp near-white
/// paper with a faint indigo cast; text inverts to near-black ink; the
/// indigo/mint accents deepen slightly for legibility against the pale
/// ground.
class AppColorsLight {
  AppColorsLight._();

  // Backgrounds
  static const Color background = Color(0xFFF5F6FA);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceElevated = Color(0xFFFFFFFF);
  static const Color surfaceMuted = Color(0xFFEAEBF3);

  // Brand
  static const Color primary = Color(0xFF5B4BD6);
  static const Color primarySoft = Color(0xFF8E7FF2);
  static const Color primaryDeep = Color(0xFF3D3299);

  // Secondary accent — mint (positive / income)
  static const Color secondary = Color(0xFF00B389);

  // Text
  static const Color textPrimary = Color(0xFF12141C);
  static const Color textSecondary = Color(0xFF565C6D);
  static const Color textMuted = Color(0xFF8A90A0);
  static const Color textInverse = Color(0xFFFFFFFF);

  // Status
  static const Color warning = Color(0xFFB5730E);
  static const Color error = Color(0xFFD63C3C);

  // Borders & dividers
  static const Color border = Color(0x1412141C);
  static const Color divider = Color(0x0D12141C);

  // Overlays
  static const Color scrim = Color(0x66000000);
  static const Color glass = Color(0x70FFFFFF);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF8E7FF2), Color(0xFF5B4BD6), Color(0xFF3D3299)],
  );

  // Card finishes stay identical to the dark theme — see class doc.
  static const LinearGradient cardMidnight = AppColors.cardMidnight;
  static const LinearGradient cardViolet = AppColors.cardViolet;
  static const LinearGradient cardMint = AppColors.cardMint;

  // The hero scrim has to fade to the page background, so it differs per
  // mode. In light mode we tint toward paper rather than ink.
  static const LinearGradient heroScrim = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0x00F5F6FA),
      Color(0x22F5F6FA),
      Color(0xCCF5F6FA),
      Color(0xFFF5F6FA),
    ],
    stops: [0.0, 0.45, 0.85, 1.0],
  );

  static const LinearGradient topScrim = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0x66000000), Color(0x00000000)],
  );
}
