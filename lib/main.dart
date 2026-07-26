import 'package:flutter/material.dart';

import 'package:fruit/core/app_theme.dart';
import 'package:fruit/features/splash/views/splash_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Grabber – Grocery Store',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: AppColors.surfaceWhite,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.surfaceWhite,
          elevation: 0,
          scrolledUnderElevation: 0,
        ),
      ),
      home: const SplashPage(),
    );
  }
}
