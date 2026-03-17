import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/text_styles.dart';

class PrivacyOverviewScreen extends StatelessWidget {
  const PrivacyOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackground,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Privacy Overview',
          style: AppTextStyles.heading2.copyWith(fontWeight: FontWeight.w900),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.grey[100]!),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 30,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'NO AUDIO RECORDING',
                style: AppTextStyles.bodySmall.copyWith(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                  color: Colors.grey[400],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'SAKSI transmits numerical decibel readings only. It never records or uploads raw audio.',
                style: AppTextStyles.bodyMedium.copyWith(color: Colors.grey[600]),
              ),
              const SizedBox(height: 20),
              Text(
                'ROLE-BASED ACCESS',
                style: AppTextStyles.bodySmall.copyWith(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                  color: Colors.grey[400],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Residents can only view their own device readings and their own violation history. Barangay officials can view incidents needed for mediation.',
                style: AppTextStyles.bodyMedium.copyWith(color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

