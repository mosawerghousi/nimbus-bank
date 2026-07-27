import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/app.dart';
import 'app/theme/theme_mode_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  final prefs = await SharedPreferences.getInstance();
  runApp(
    DevicePreview(
      // Show the device frame + controls only on the hosted web demo; a
      // native mobile build never wraps itself in its own device frame.
      enabled: kIsWeb,
      // Always open as a clean iPhone: ignore any saved device choice and
      // limit the picker to phones so the demo never opens as a tablet.
      defaultDevice: Devices.ios.iPhone13,
      storage: DevicePreviewStorage.none(),
      devices: [
        Devices.ios.iPhoneSE,
        Devices.ios.iPhone13,
        Devices.ios.iPhone15Pro,
        Devices.ios.iPhone13ProMax,
        Devices.android.samsungGalaxyS20,
        Devices.android.googlePixel9,
      ],
      builder: (context) => ProviderScope(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(prefs),
        ],
        child: const NimbusApp(),
      ),
    ),
  );
}
