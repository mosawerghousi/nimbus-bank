import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../theme/theme_mode_provider.dart' show sharedPreferencesProvider;

/// App-wide language selection, persisted to disk. Mirrors
/// [ThemeModeNotifier]'s shape exactly — same persistence pattern, just a
/// [Locale] instead of a [ThemeMode].
final localeProvider =
    NotifierProvider<LocaleNotifier, Locale>(LocaleNotifier.new);

class LocaleNotifier extends Notifier<Locale> {
  static const _prefsKey = 'locale';

  @override
  Locale build() {
    final prefs = ref.watch(sharedPreferencesProvider);
    return _decode(prefs.getString(_prefsKey));
  }

  /// Update the active locale and persist the choice.
  Future<void> set(Locale locale) async {
    if (locale == state) return;
    state = locale;
    final prefs = ref.read(sharedPreferencesProvider);
    await prefs.setString(_prefsKey, locale.languageCode);
  }

  static Locale _decode(String? value) => switch (value) {
        'ar' => const Locale('ar'),
        _ => const Locale('en'),
      };
}
