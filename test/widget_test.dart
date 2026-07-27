import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:nimbus_bank/app/app.dart';
import 'package:nimbus_bank/app/theme/theme_mode_provider.dart';

void main() {
  testWidgets('Nimbus app boots without errors', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues(const {});
    final prefs = await SharedPreferences.getInstance();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
        child: const NimbusApp(),
      ),
    );
    // Splash schedules a 2.2s timer to navigate forward — pump past it so
    // no timers are left pending when the widget tree tears down.
    await tester.pump(const Duration(seconds: 3));
    await tester.pump();
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
