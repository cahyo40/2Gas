import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:twogass/apps/bindings/initial_bindings.dart';
import 'package:twogass/apps/controller/auth_controller.dart';
import 'package:twogass/apps/controller/locale_controller.dart';
import 'package:twogass/apps/controller/theme_controller.dart';
import 'package:twogass/apps/routes/route_app.dart';
import 'package:twogass/apps/routes/route_names.dart';
import 'package:twogass/firebase_options.dart';
import 'package:twogass/l10n/generated/app_localizations.dart';
import 'package:yo_ui/yo_ui.dart';
// import 'apps/routes/route_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await YoConnectivity.initialize();
  await GetStorage.init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final tc = Get.put(ThemeController(), permanent: true);
    final lc = Get.put(LocaleController(), permanent: true);
    Get.put(AuthController(), permanent: true);
    return GetMaterialApp(
      title: '2Gas',
      initialBinding: InitialBindings(),
      localizationsDelegates: const [
        AppLocalizations.delegate, // utama
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      locale: lc.locale,
      // fallback supaya tidak merah saja
      localeListResolutionCallback: (locales, supported) {
        for (final l in locales ?? []) {
          if (supported.contains(l)) return l;
        }
        return const Locale('en');
      },
      initialRoute: RouteNames.ONBOARD,
      themeMode: tc.themeMode,
      // themeMode: ThemeMode.system,
      theme: YoTheme.lightTheme(context, YoColorScheme.codingDark).copyWith(
        datePickerTheme: DatePickerThemeData().copyWith(
          dayForegroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return context.backgroundColor;
            }

            return context.textColor;
          }),
        ),
        timePickerTheme: TimePickerThemeData().copyWith(
          hourMinuteTextColor: WidgetStateColor.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return context.backgroundColor; // font saat terpilih
            }
            return context.textColor; // font saat tidak terpilih
          }),

          dayPeriodColor: context.accentColor,
        ),
      ),
      darkTheme: YoTheme.darkTheme(context, YoColorScheme.codingDark),
      getPages: RouteApp.routes,
    );
  }
}
