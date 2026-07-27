import 'package:flutter/material.dart';

import '../../app/theme/color_tokens.dart';

extension ContextX on BuildContext {
  Size get screenSize => MediaQuery.sizeOf(this);
  double get screenWidth => screenSize.width;
  double get screenHeight => screenSize.height;
  EdgeInsets get viewPadding => MediaQuery.viewPaddingOf(this);
  double get topPadding => MediaQuery.viewPaddingOf(this).top;
  double get bottomPadding => MediaQuery.viewPaddingOf(this).bottom;
  TextTheme get textTheme => Theme.of(this).textTheme;
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  ColorTokens get colors =>
      Theme.of(this).extension<ColorTokens>() ?? ColorTokens.dark();

  /// Resolves a [SpendCategory.colorKey] (or any semantic token name) to its
  /// themed [Color]. Keeps mock domain data free of raw [Color] literals —
  /// data stores a key, widgets resolve it through the active theme.
  Color colorForKey(String key) => switch (key) {
        'primary' => colors.primary,
        'primarySoft' => colors.primarySoft,
        'primaryDeep' => colors.primaryDeep,
        'secondary' => colors.secondary,
        'warning' => colors.warning,
        'error' => colors.error,
        'textPrimary' => colors.textPrimary,
        'textSecondary' => colors.textSecondary,
        _ => colors.textMuted,
      };

  /// Resolves a [BankCard.gradientKey]/[Account.colorKey] to its themed
  /// [LinearGradient] card finish.
  LinearGradient gradientForKey(String key) => switch (key) {
        'midnight' => colors.cardMidnight,
        'violet' => colors.cardViolet,
        'mint' => colors.cardMint,
        _ => colors.primaryGradient,
      };
}
