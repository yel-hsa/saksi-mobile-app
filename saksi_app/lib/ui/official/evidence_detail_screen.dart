import 'package:flutter/material.dart';
import '../../core/mock_data.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/text_styles.dart';
import '../shared/mapbox_placeholder.dart';
import '../shared/custom_card.dart';
import '../shared/status_badge.dart';

class EvidenceDetailScreen extends StatelessWidget {
  final MockCaseFile? caseFile;

  const EvidenceDetailScreen({super.key, this.caseFile});

  @override
  Widget build(BuildContext context) {
    final data = caseFile ?? MockData.caseFiles.first;
    final zoneText = '${MockData.hotspots.first.zoneLabel}, ${MockData.hotspots.first.locationLabel}';

    return Scaffold(
      backgroundColor: AppColors.appBackground,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        shadowColor: Colors.black12,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Mediation Report', style: AppTextStyles.heading2.copyWith(fontWeight: FontWeight.w900)),
            Text(
              'CASE #${data.id}',
              style: AppTextStyles.bodySmall.copyWith(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            // Verification Seal
            Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.only(bottom: 24),
              decoration: BoxDecoration(
                color: const Color(0xFFF0FDF4),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFBBF7D0)),
              ),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: const Color(0xFFDCFCE7),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.verified, color: Color(0xFF16A34A), size: 24),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Evidence Verified',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: const Color(0xFF14532D),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Hardware authenticated at source',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: const Color(0xFF15803D),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: OutlinedButton.icon(
                    onPressed: () {
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
                                width: 64,
                                height: 64,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFFEF2F2),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(Icons.download, color: AppColors.alertRed, size: 28),
                              ),
                              const SizedBox(height: 16),
                              Text('Export Queued', style: AppTextStyles.heading2),
                              const SizedBox(height: 8),
                              Text(
                                'A PDF export will be generated in a later milestone. This action is recorded for audit purposes.',
                                textAlign: TextAlign.center,
                                style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary),
                              ),
                              const SizedBox(height: 16),
                              SizedBox(
                                width: double.infinity,
                                child: OutlinedButton(
                                  onPressed: () => Navigator.pop(context),
                                  style: OutlinedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    side: BorderSide(color: Colors.grey[200]!),
                                    padding: const EdgeInsets.symmetric(vertical: 14),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                  ),
                                  child: Text(
                                    'Dismiss',
                                    style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.download, color: AppColors.alertRed, size: 16),
                    label: Text(
                      'Export PDF',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.alertRed,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: BorderSide(color: AppColors.alertRed.withOpacity(0.2)),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 1,
                  child: ElevatedButton.icon(
                    onPressed: () {
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
                                width: 64,
                                height: 64,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFF0FDF4),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(Icons.check_circle_rounded, color: Color(0xFF15803D), size: 30),
                              ),
                              const SizedBox(height: 16),
                              Text('Case Updated', style: AppTextStyles.heading2),
                              const SizedBox(height: 8),
                              Text(
                                'This case is marked as resolved (mock). Backend updates will be added later.',
                                textAlign: TextAlign.center,
                                style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary),
                              ),
                              const SizedBox(height: 16),
                              SizedBox(
                                width: double.infinity,
                                child: OutlinedButton(
                                  onPressed: () => Navigator.pop(context),
                                  style: OutlinedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    side: BorderSide(color: Colors.grey[200]!),
                                    padding: const EdgeInsets.symmetric(vertical: 14),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                  ),
                                  child: Text(
                                    'Dismiss',
                                    style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.check_circle, color: Colors.white, size: 16),
                    label: Text(
                      'Mark Resolved',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.textPrimary,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      elevation: 4,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            SizedBox(
              height: 200,
              width: double.infinity,
              child: MapboxPlaceholder(
                markers: const [
                  HeatMarker(
                    x: 0.5,
                    y: 0.5,
                    severity: HeatMarkerSeverity.critical,
                  ),
                ],
                bottomLeftLabel: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.location_on, size: 14, color: AppColors.alertRed),
                    const SizedBox(width: 8),
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 240),
                      child: Text(
                        zoneText,
                        style: AppTextStyles.bodySmall.copyWith(fontWeight: FontWeight.bold),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Data Readout
            CustomCard(
              padding: CardPadding.none,
              child: Column(
                children: [
                  // Header
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                      border: Border(bottom: BorderSide(color: Colors.grey[100]!)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.warning_amber_rounded, size: 16, color: AppColors.textPrimary),
                            const SizedBox(width: 8),
                            Text(
                              'INCIDENT SUMMARY',
                              style: AppTextStyles.bodySmall.copyWith(
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1,
                              ),
                            ),
                          ],
                        ),
                        StatusBadge(
                          text: data.status,
                          size: BadgeSize.sm,
                          variant: data.status == 'Resolved' ? BadgeVariant.success : BadgeVariant.warning,
                        ),
                      ],
                    ),
                  ),

                  // Content
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        // Peak Noise Box
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFEF2F2),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: const Color(0xFFFECACA)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'PEAK NOISE LEVEL',
                                    style: AppTextStyles.bodySmall.copyWith(
                                      color: Colors.grey[500],
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.baseline,
                                    textBaseline: TextBaseline.alphabetic,
                                    children: [
                                      Text(
                                        data.peakDb.toString(),
                                        style: AppTextStyles.heading1.copyWith(
                                          fontSize: 36,
                                          color: AppColors.alertRed,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        'dB',
                                        style: AppTextStyles.bodyMedium.copyWith(
                                          color: AppColors.alertRed.withOpacity(0.7),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: AppColors.alertRed,
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Text(
                                      'VIOLATION',
                                      style: AppTextStyles.bodySmall.copyWith(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 1,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Limit: 85dB',
                                    style: AppTextStyles.bodySmall.copyWith(
                                      color: Colors.grey[500],
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Details Grid
                        Row(
                          children: [
                            Expanded(
                              child: _buildDetailItem(Icons.calendar_today, 'Date Logged', data.date),
                            ),
                            Expanded(
                                  child: _buildDetailItem(Icons.access_time, 'Time Block', '11:45 PM - 12:00 AM'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        Row(
                          children: [
                            Expanded(
                                  child: _buildDetailItem(Icons.timer, 'Duration', data.duration),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.developer_board, size: 12, color: Colors.grey[400]),
                                      const SizedBox(width: 6),
                                      Text(
                                        'HARDWARE ID',
                                        style: AppTextStyles.bodySmall.copyWith(
                                          fontSize: 10,
                                          color: Colors.grey[400],
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 6),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[100],
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Text(
                                      data.hardwareId,
                                      style: AppTextStyles.bodySmall.copyWith(
                                        color: Colors.grey[600],
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
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
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(IconData icon, String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 12, color: Colors.grey[400]),
            const SizedBox(width: 6),
            Text(
              label.toUpperCase(),
              style: AppTextStyles.bodySmall.copyWith(
                fontSize: 10,
                color: Colors.grey[400],
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          value,
          style: AppTextStyles.bodyMedium.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
