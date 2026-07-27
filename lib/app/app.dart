import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/extensions/context_extensions.dart';
import 'localization/app_strings.dart';
import 'localization/locale_provider.dart';
import 'router/app_router.dart';
import 'theme/app_theme.dart';
import 'theme/theme_mode_provider.dart';

class NimbusApp extends ConsumerWidget {
  const NimbusApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final locale = ref.watch(localeProvider);

    return MaterialApp.router(
      title: 'Nimbus',
      debugShowCheckedModeBanner: false,
      // Not `DevicePreview.locale(context) ?? locale`: device_preview's own
      // locale simulator is basically never null once active (it defaults
      // to en-US), so that ordering would permanently override the app's
      // own language switcher on the hosted web demo. Our locale wins.
      locale: locale,
      supportedLocales: const [Locale('en'), Locale('ar')],
      localizationsDelegates: [
        AppStrings.delegate,
        ...GlobalMaterialLocalizations.delegates,
      ],
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeMode,
      routerConfig: appRouter,
      // The typography tokens in [AppTextStyles] are color-agnostic, so this
      // supplies the theme-aware default color (any bare or styled `Text`
      // resolves to the correct tone in both light and dark mode). Composed
      // with [DevicePreview.appBuilder] so the hosted web demo keeps its
      // device frame.
      builder: (context, child) {
        return DevicePreview.appBuilder(
          context,
          DefaultTextStyle.merge(
            style: TextStyle(color: context.colors.textPrimary),
            child: child ?? const SizedBox.shrink(),
          ),
        );
      },
    );
  }
}
