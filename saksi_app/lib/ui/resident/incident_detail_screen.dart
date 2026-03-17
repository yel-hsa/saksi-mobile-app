import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/text_styles.dart';

class IncidentDetailScreen extends StatelessWidget {
  final String date;
  final String time;
  final int peakDb;
  final String duration;
  final String status;

  const IncidentDetailScreen({
    super.key,
    required this.date,
    required this.time,
    required this.peakDb,
    required this.duration,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final isResolved = status == 'Resolved';
    final isViolation = peakDb >= 85;

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
          'Incident Detail',
          style: AppTextStyles.heading2.copyWith(fontWeight: FontWeight.w900),
        ),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    children: [
                      Container(
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  date.toUpperCase(),
                                  style: AppTextStyles.bodySmall.copyWith(
                                    color: Colors.grey[400],
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1,
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: isResolved ? AppColors.successBg : AppColors.warningBg,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: isResolved ? AppColors.successBorder : AppColors.warningBorder),
                                  ),
                                  child: Text(
                                    status.toUpperCase(),
                                    style: AppTextStyles.bodySmall.copyWith(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1,
                                      color: isResolved ? AppColors.successText : AppColors.warningText,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Text(time, style: AppTextStyles.heading3.copyWith(fontWeight: FontWeight.w900)),
                            const SizedBox(height: 20),
                            const Divider(height: 1),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _detailTile('Peak dB', '$peakDb dB', highlight: isViolation),
                                _detailTile('Duration', duration, highlight: false),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.grey[100]!),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              isViolation ? Icons.warning_amber_rounded : Icons.check_circle,
                              color: isViolation ? AppColors.alertRed : AppColors.successText,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                isViolation
                                    ? 'This incident exceeded the 85dB limit and is recorded for accountability.'
                                    : 'This log is within compliant levels and recorded for audit purposes.',
                                style: AppTextStyles.bodySmall.copyWith(color: Colors.grey[600]),
                              ),
                            ),
                          ],
                        ),
                      ),
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

  Widget _detailTile(String label, String value, {required bool highlight}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: AppTextStyles.bodySmall.copyWith(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
            color: Colors.grey[400],
          ),
        ),
        const SizedBox(height: 6),
        Text(
          value,
          style: AppTextStyles.bodyLarge.copyWith(
            fontWeight: FontWeight.bold,
            color: highlight ? AppColors.alertRed : AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}

