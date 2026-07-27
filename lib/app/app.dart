import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/extensions/context_extensions.dart';
import 'router/app_router.dart';
import 'theme/app_theme.dart';
import 'theme/theme_mode_provider.dart';

class NimbusApp extends ConsumerWidget {
  const NimbusApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);

    return MaterialApp.router(
      title: 'Nimbus',
      debugShowCheckedModeBanner: false,
      locale: DevicePreview.locale(context),
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
