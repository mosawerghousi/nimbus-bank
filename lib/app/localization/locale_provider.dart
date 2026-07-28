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
    // Dari needs its country subtag persisted too (fa vs fa-AF), so store
    // the full BCP-47 tag rather than just the language code.
    await prefs.setString(_prefsKey, locale.toLanguageTag());
  }

  static Locale _decode(String? value) => switch (value) {
        'ar' => const Locale('ar'),
        'fa' || 'fa-AF' || 'fa_AF' => const Locale('fa', 'AF'),
        _ => const Locale('en'),
      };
}
