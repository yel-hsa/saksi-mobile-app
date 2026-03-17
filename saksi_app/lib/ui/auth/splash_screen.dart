import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/text_styles.dart';
import '../shared/custom_button.dart';
import 'login_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const Spacer(),
              // Branding
              Column(
                children: [
                  Text(
                    'SAKSI',
                    style: AppTextStyles.heading1.copyWith(
                      fontSize: 48,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -2,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Community Mediation &\nAccountability System',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.bodyLarge.copyWith(
                      fontWeight: FontWeight.w500,
                      height: 1.2,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              // Role Selection
              Column(
                children: [
                  CustomButton(
                    text: 'Continue as Resident',
                    fullWidth: true,
                    size: ButtonSize.lg,
                    variant: ButtonVariant.secondary,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(role: 'resident'),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  CustomButton(
                    text: 'Barangay Official Portal',
                    fullWidth: true,
                    size: ButtonSize.lg,
                    variant: ButtonVariant.outline,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(role: 'official'),
                        ),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
