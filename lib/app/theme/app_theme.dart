import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_colors.dart';
import 'app_text_styles.dart';
import 'color_tokens.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get dark => _build(
        base: ThemeData.dark(useMaterial3: true),
        tokens: ColorTokens.dark(),
        colorScheme: const ColorScheme.dark(
          surface: AppColors.background,
          primary: AppColors.primary,
          onPrimary: AppColors.textInverse,
          secondary: AppColors.secondary,
          onSecondary: AppColors.textInverse,
          onSurface: AppColors.textPrimary,
          error: AppColors.error,
        ),
        overlay: SystemUiOverlayStyle.light,
      );

  static ThemeData get light => _build(
        base: ThemeData.light(useMaterial3: true),
        tokens: ColorTokens.light(),
        colorScheme: const ColorScheme.light(
          surface: AppColorsLight.background,
          primary: AppColorsLight.primary,
          onPrimary: AppColorsLight.textInverse,
          secondary: AppColorsLight.secondary,
          onSecondary: AppColorsLight.textInverse,
          onSurface: AppColorsLight.textPrimary,
          error: AppColorsLight.error,
        ),
        overlay: SystemUiOverlayStyle.dark,
      );

  static ThemeData _build({
    required ThemeData base,
    required ColorTokens tokens,
    required ColorScheme colorScheme,
    required SystemUiOverlayStyle overlay,
  }) {
    return base.copyWith(
      scaffoldBackgroundColor: tokens.background,
      colorScheme: colorScheme,
      extensions: <ThemeExtension<dynamic>>[tokens],
      textTheme: TextTheme(
        displayLarge: AppTextStyles.displayLarge.copyWith(color: tokens.textPrimary),
        displayMedium: AppTextStyles.displayMedium.copyWith(color: tokens.textPrimary),
        displaySmall: AppTextStyles.displaySmall.copyWith(color: tokens.textPrimary),
        headlineLarge: AppTextStyles.headlineLarge.copyWith(color: tokens.textPrimary),
        headlineMedium: AppTextStyles.headlineMedium.copyWith(color: tokens.textPrimary),
        titleLarge: AppTextStyles.titleLarge.copyWith(color: tokens.textPrimary),
        titleMedium: AppTextStyles.titleMedium.copyWith(color: tokens.textPrimary),
        titleSmall: AppTextStyles.titleSmall.copyWith(color: tokens.textPrimary),
        bodyLarge: AppTextStyles.bodyLarge.copyWith(color: tokens.textPrimary),
        bodyMedium: AppTextStyles.bodyMedium.copyWith(color: tokens.textSecondary),
        bodySmall: AppTextStyles.bodySmall.copyWith(color: tokens.textSecondary),
        labelLarge: AppTextStyles.labelLarge.copyWith(color: tokens.textPrimary),
        labelMedium: AppTextStyles.labelMedium.copyWith(color: tokens.textSecondary),
        labelSmall: AppTextStyles.overline.copyWith(color: tokens.textMuted),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        systemOverlayStyle: overlay,
        iconTheme: IconThemeData(color: tokens.textPrimary),
        titleTextStyle: AppTextStyles.titleMedium.copyWith(color: tokens.textPrimary),
      ),
      iconTheme: IconThemeData(color: tokens.textPrimary, size: 22),
      dividerTheme: DividerThemeData(
        color: tokens.divider,
        thickness: 1,
        space: 1,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: tokens.surface,
        selectedItemColor: tokens.primary,
        unselectedItemColor: tokens.textMuted,
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
        elevation: 0,
      ),
    );
  }
}
