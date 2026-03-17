import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/text_styles.dart';
import '../shared/custom_button.dart';
import '../shared/custom_card.dart';
import '../shared/status_badge.dart';

class ResidentDashboard extends StatefulWidget {
  final VoidCallback? onNotificationsTap;
  final VoidCallback? onProfileTap;

  const ResidentDashboard({super.key, this.onNotificationsTap, this.onProfileTap});

  @override
  State<ResidentDashboard> createState() => _ResidentDashboardState();
}

class _ResidentDashboardState extends State<ResidentDashboard> {
  double _decibels = 45.0;
  bool _isOffline = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startSimulation();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startSimulation() {
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      if (_isOffline) return;
      setState(() {
        final variance = Random().nextInt(15) - 7;
        _decibels = (_decibels + variance).clamp(30.0, 120.0);
      });
    });
  }

  Color _getStatusColor() {
    if (_isOffline) return Colors.grey;
    if (_decibels > 100) return AppColors.dangerDark;
    if (_decibels > 85) return AppColors.alertRed;
    return AppColors.success;
  }

  String _getStatusText() {
    if (_isOffline) return "Monitoring Paused";
    if (_decibels > 100) return "Violation Level";
    if (_decibels > 85) return "Elevated Noise";
    return "Normal Levels";
  }

  void _showConfirmationModal() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        contentPadding: const EdgeInsets.all(24),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: const BoxDecoration(
                color: Color(0xFFFEF2F2),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.warning_amber_rounded, color: AppColors.alertRed),
            ),
            const SizedBox(height: 16),
            Text('Request Mediation?', style: AppTextStyles.heading2),
            const SizedBox(height: 8),
            Text(
              'This will officially notify your barangay to dispatch an officer for peaceful mediation. This action is logged for accountability.',
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    text: 'Cancel',
                    variant: ButtonVariant.ghost,
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: CustomButton(
                    text: 'Yes, Request',
                    variant: ButtonVariant.primary,
                    onPressed: () {
                      Navigator.pop(context);
                      _showSuccessModal();
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showSuccessModal() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        contentPadding: const EdgeInsets.all(24),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(color: AppColors.successBg, shape: BoxShape.circle),
              child: Icon(Icons.check_circle_rounded, color: AppColors.successText, size: 40),
            ),
            const SizedBox(height: 16),
            Text('Alert Confirmed', style: AppTextStyles.heading1),
            const SizedBox(height: 8),
            Text(
              'Barangay officials have been securely notified. Help is on the way. Please remain in a safe location.',
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary),
            ),
            const SizedBox(height: 24),
            CustomButton(
              text: 'Dismiss',
              fullWidth: true,
              variant: ButtonVariant.outline,
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackground,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        shadowColor: Colors.black12,
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: AppColors.alertRed,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.shield, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 8),
            Text(
              'SAKSI',
              style: AppTextStyles.heading2.copyWith(fontWeight: FontWeight.w900),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: AppColors.textPrimary),
            onPressed: widget.onNotificationsTap,
          ),
          IconButton(
            icon: const Icon(Icons.person_outline, color: AppColors.textPrimary),
            onPressed: widget.onProfileTap,
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Status Bar
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.successBg,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.successBorder),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.location_on, size: 14, color: AppColors.successText),
                        const SizedBox(width: 4),
                        Text(
                          'VERIFIED HOME ZONE',
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.successText,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Icon(Icons.check_circle, size: 14, color: AppColors.successText),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: _isOffline ? AppColors.warningBg : AppColors.infoBg,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: _isOffline ? AppColors.warningBorder : AppColors.infoBorder,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          _isOffline ? Icons.cloud_off : Icons.cloud,
                          size: 14,
                          color: _isOffline ? AppColors.warningText : AppColors.infoText,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          _isOffline ? 'SYNC OFFLINE' : 'CLOUD SYNC ACTIVE',
                          style: AppTextStyles.bodySmall.copyWith(
                            color: _isOffline ? AppColors.warningText : AppColors.infoText,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Main Content
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 380),
                    child: CustomCard(
                      padding: CardPadding.lg,
                      child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'LIVE ENVIRONMENT MONITOR',
                          style: AppTextStyles.bodySmall.copyWith(
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                          ),
                        ),
                        const SizedBox(height: 32),
                        
                        // Gauge Placeholder (Using CircularProgressIndicator for now)
                        SizedBox(
                          height: 200,
                          width: 200,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              SizedBox(
                                height: 200,
                                width: 200,
                                child: CircularProgressIndicator(
                                  value: _isOffline ? 0 : (_decibels / 120),
                                  strokeWidth: 20,
                                  backgroundColor: Colors.grey.shade100,
                                  valueColor: AlwaysStoppedAnimation<Color>(_getStatusColor()),
                                ),
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.baseline,
                                    textBaseline: TextBaseline.alphabetic,
                                    children: [
                                      Text(
                                        _isOffline ? '--' : _decibels.round().toString(),
                                        style: AppTextStyles.decibelDisplay.copyWith(
                                          color: _isOffline ? Colors.grey : AppColors.textPrimary,
                                        ),
                                      ),
                                      Text(
                                        'dB',
                                        style: AppTextStyles.bodyLarge.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        
                        const SizedBox(height: 32),
                        StatusBadge(
                          text: _getStatusText(),
                          variant: _isOffline
                              ? BadgeVariant.warning
                              : (_decibels > 100 ? BadgeVariant.danger : _decibels > 85 ? BadgeVariant.warning : BadgeVariant.success),
                          size: BadgeSize.md,
                        ),
                      ],
                    ),
                    ),
                  ).animate().fadeIn(duration: 220.ms, curve: Curves.easeOut).slideY(begin: 0.05, end: 0, duration: 240.ms, curve: Curves.easeOutCubic),
                ),
              ),
            ),

            // Action Area
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  CustomButton(
                    text: 'REQUEST BARANGAY MEDIATION',
                    fullWidth: true,
                    size: ButtonSize.lg,
                    variant: ButtonVariant.primary,
                    icon: const Icon(Icons.shield, color: Colors.white),
                    onPressed: _showConfirmationModal,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.lock, size: 12, color: Colors.grey),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Privacy secured. Only your data is visible to you and authorized barangay officials.',
                          style: AppTextStyles.bodySmall.copyWith(color: Colors.grey),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
