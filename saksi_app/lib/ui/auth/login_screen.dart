import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/text_styles.dart';
import '../shared/custom_button.dart';
import '../shared/custom_input.dart';
import '../resident/setup_pairing_screen.dart';
import '../official/official_layout.dart';

class LoginScreen extends StatefulWidget {
  final String role;

  const LoginScreen({super.key, required this.role});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _handleLogin() {
    // For now, just navigate based on role
    if (widget.role == 'resident') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const SetupPairingScreen()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const OfficialLayout()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 32),
            Text(
              'Welcome Back',
              style: AppTextStyles.heading1.copyWith(fontSize: 32),
            ),
            const SizedBox(height: 8),
            Text(
              'Please log in to your SAKSI account.',
              style: AppTextStyles.bodyLarge.copyWith(color: AppColors.textSecondary),
            ),
            const SizedBox(height: 48),
            // Email Field
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Email Address',
                  style: AppTextStyles.bodySmall.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                CustomInput(
                  hintText: 'juan@delacruz.com',
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                ),
              ],
            ),
            const SizedBox(height: 32),
            // Password Field
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Password',
                  style: AppTextStyles.bodySmall.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                CustomInput(
                  hintText: '••••••••',
                  controller: _passwordController,
                  obscureText: true,
                ),
              ],
            ),
            const SizedBox(height: 48),
            CustomButton(
              text: 'Sign In',
              fullWidth: true,
              size: ButtonSize.lg,
              variant: ButtonVariant.primary,
              onPressed: _handleLogin,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
