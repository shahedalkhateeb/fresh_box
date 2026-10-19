import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';

import 'app_strings.dart';
import 'splash_screen.dart';
import 'onboarding_screen.dart';
import 'home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  // نقرأ اللغة المحفوظة (الافتراضي إنجليزي)
  appLocale.value = Locale(GetStorage().read('lang') ?? 'en');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        // بيعيد بناء التطبيق كل ما تغيرت اللغة
        return ValueListenableBuilder<Locale>(
          valueListenable: appLocale,
          builder: (context, locale, _) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'FreshBOX',
              theme: ThemeData(scaffoldBackgroundColor: Colors.white),
              locale: locale,
              supportedLocales: const [Locale('en'), Locale('ar')],
              localizationsDelegates: const [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              initialRoute: '/splash',
              routes: {
                '/splash': (context) => const SplashScreen(),
                '/onboarding': (context) => const OnboardingScreen(),
                '/home': (context) => const HomeScreen(),
              },
            );
          },
        );
      },
    );
  }
}