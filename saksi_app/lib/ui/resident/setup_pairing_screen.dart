import 'dart:async';
import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/text_styles.dart';
import '../shared/custom_button.dart';
import 'resident_layout.dart';

class SetupPairingScreen extends StatefulWidget {
  const SetupPairingScreen({super.key});

  @override
  State<SetupPairingScreen> createState() => _SetupPairingScreenState();
}

class _SetupPairingScreenState extends State<SetupPairingScreen> with SingleTickerProviderStateMixin {
  bool _isScanning = true;
  bool _gpsLocked = false;
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    // Simulate scanning
    Timer(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _isScanning = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
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
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Connect Your SAKSI Device',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.heading1.copyWith(
                          fontSize: 32,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 32),

                      SizedBox(
                        height: 160,
                        width: 160,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            if (_isScanning)
                              AnimatedBuilder(
                                animation: _pulseAnimation,
                                builder: (context, child) {
                                  return Transform.scale(
                                    scale: _pulseAnimation.value,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.blue.withOpacity(0.1),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            Container(
                              width: 160,
                              height: 160,
                              decoration: BoxDecoration(
                                color: Colors.grey[50],
                                borderRadius: BorderRadius.circular(32),
                                border: Border.all(color: AppColors.textPrimary, width: 4),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 15,
                                    offset: const Offset(0, 8),
                                  ),
                                ],
                              ),
                              child: const Icon(Icons.developer_board, size: 80, color: AppColors.textPrimary),
                            ),
                            if (_isScanning)
                              const Positioned(
                                top: -16,
                                right: -16,
                                child: Icon(Icons.wifi, size: 40, color: AppColors.alertRed),
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: AppColors.appBackground,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.grey[200]!),
                        ),
                        child: Row(
                          children: [
                            if (_isScanning)
                              const SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  strokeWidth: 3,
                                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.alertRed),
                                ),
                              )
                            else
                              const Icon(Icons.check_circle, color: Color(0xFF15803D), size: 24),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Text(
                                _isScanning
                                    ? 'Scanning for nearby SAKSI ESP32 monitors...'
                                    : 'SAKSI-ESP32-94A2 Found & Connected',
                                style: AppTextStyles.bodyMedium.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.grey[200]!, width: 2),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: const BoxDecoration(
                                color: Color(0xFFFEF2F2),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.location_on, color: AppColors.alertRed, size: 20),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Text(
                                'Lock Home Zone (GPS)',
                                style: AppTextStyles.bodyLarge.copyWith(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Switch(
                              value: _gpsLocked,
                              onChanged: (value) {
                                setState(() {
                                  _gpsLocked = value;
                                });
                              },
                              activeColor: Colors.white,
                              activeTrackColor: AppColors.alertRed,
                              inactiveThumbColor: Colors.white,
                              inactiveTrackColor: Colors.grey[300],
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),

                      SizedBox(
                        width: double.infinity,
                        child: CustomButton(
                          text: 'Complete Setup',
                          size: ButtonSize.lg,
                          variant: ButtonVariant.secondary,
                          onPressed: (_isScanning || !_gpsLocked)
                              ? null
                              : () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(builder: (context) => const ResidentLayout()),
                                  );
                                },
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
