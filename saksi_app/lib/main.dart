import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'core/constants/app_colors.dart';
import 'core/constants/app_layout.dart';
import 'ui/auth/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // TODO: Initialize Firebase here when ready
  runApp(const SaksiApp());
}

class SaksiApp extends StatelessWidget {
  const SaksiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SAKSI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.appBackground,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.alertRed,
          primary: AppColors.alertRed,
          secondary: AppColors.textPrimary,
          surface: AppColors.background,
        ),
        textTheme: GoogleFonts.interTextTheme().apply(
          bodyColor: AppColors.textPrimary,
          displayColor: AppColors.textPrimary,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: AppColors.textPrimary,
          elevation: 1,
          centerTitle: false,
        ),
        snackBarTheme: SnackBarThemeData(
          backgroundColor: AppColors.textPrimary,
          contentTextStyle: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.w600),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppLayout.radiusLg)),
        ),
        dialogTheme: DialogThemeData(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppLayout.radiusXl)),
        ),
        bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(AppLayout.radiusXl)),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.alertRed,
            foregroundColor: Colors.white,
            elevation: 0,
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppLayout.radiusSm)),
            textStyle: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 14),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: AppColors.textPrimary,
            side: BorderSide(color: AppColors.borderLight),
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppLayout.radiusSm)),
            textStyle: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 14),
          ),
        ),
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: <TargetPlatform, PageTransitionsBuilder>{
            TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
            TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
            TargetPlatform.windows: FadeUpwardsPageTransitionsBuilder(),
            TargetPlatform.linux: FadeUpwardsPageTransitionsBuilder(),
          },
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
