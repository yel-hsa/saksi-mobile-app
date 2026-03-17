import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/mock_data.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/text_styles.dart';
import 'create_report_screen.dart';
import 'evidence_detail_screen.dart';
import '../shared/custom_card.dart';
import '../shared/filter_pill.dart';

class ReportsListScreen extends StatelessWidget {
  final VoidCallback? onBack;

  const ReportsListScreen({super.key, this.onBack});

  @override
  Widget build(BuildContext context) {
    final reports = MockData.caseFiles;

    return Scaffold(
      backgroundColor: AppColors.appBackground,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => (onBack ?? () => Navigator.pop(context))(),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Mediation Logs', style: AppTextStyles.heading2.copyWith(fontWeight: FontWeight.w900)),
            Text(
              'OFFICIAL RECORDS',
              style: AppTextStyles.bodySmall.copyWith(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
          ],
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey[100]!),
            ),
            child: IconButton(
              icon: const Icon(Icons.search, color: AppColors.textPrimary, size: 20),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  backgroundColor: Colors.white,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                  ),
                  builder: (context) {
                    return Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Search', style: AppTextStyles.heading2),
                          const SizedBox(height: 8),
                          Text(
                            'Search is a UI-only placeholder. It will be wired to Firestore queries in a later milestone.',
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
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Trust Banner
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.infoBg,
              border: const Border(bottom: BorderSide(color: AppColors.infoBorder)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.security, color: AppColors.infoText, size: 20),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Secure Evidence Vault',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'All records are cryptographically timestamped and verified for barangay mediation purposes.',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.infoText,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Filters
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Row(
              children: [
                const FilterPill(label: 'Active Cases', selected: true),
                const SizedBox(width: 8),
                const FilterPill(label: 'Archived', selected: false),
                const SizedBox(width: 8),
                FilterPill(
                  label: 'Filter',
                  selected: false,
                  icon: Icons.filter_list,
                  onTap: () {},
                ),
              ],
            ),
          ),

          // Reports List
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              itemCount: reports.length,
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final report = reports[index];
                final isResolved = report.status == 'Resolved';

                return CustomCard(
                  padding: CardPadding.md,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: Colors.grey[100],
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: Text(
                                        'CASE ${report.id}',
                                        style: AppTextStyles.bodySmall.copyWith(
                                          color: Colors.grey[500],
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1,
                                          fontSize: 10,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      '• ${report.date}',
                                      style: AppTextStyles.bodySmall.copyWith(
                                        color: Colors.grey[400],
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  report.parties,
                                  style: AppTextStyles.heading3.copyWith(fontWeight: FontWeight.w900),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    Icon(Icons.location_on, size: 14, color: Colors.grey[500]),
                                    const SizedBox(width: 4),
                                    Expanded(
                                      child: Text(
                                        report.location,
                                        style: AppTextStyles.bodySmall.copyWith(
                                          color: Colors.grey[500],
                                          fontWeight: FontWeight.w600,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: isResolved ? const Color(0xFFF0FDF4) : const Color(0xFFFFFBEB),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: isResolved ? const Color(0xFFBBF7D0) : const Color(0xFFFEF3C7),
                              ),
                            ),
                            child: Text(
                              report.status.toUpperCase(),
                              style: AppTextStyles.bodySmall.copyWith(
                                color: isResolved ? const Color(0xFF15803D) : const Color(0xFFB45309),
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      const Divider(height: 1),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: ElevatedButton.icon(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => EvidenceDetailScreen(caseFile: report)),
                                );
                              },
                              icon: const Icon(Icons.description_outlined, color: AppColors.textPrimary, size: 16),
                              label: Text(
                                'Case File',
                                style: AppTextStyles.bodyMedium.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFF5F5F5),
                                foregroundColor: AppColors.textPrimary,
                                elevation: 0,
                                padding: const EdgeInsets.symmetric(vertical: 12),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            flex: 2,
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
                                'Export',
                                style: AppTextStyles.bodyMedium.copyWith(
                                  color: AppColors.alertRed,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              style: OutlinedButton.styleFrom(
                                backgroundColor: Colors.white,
                                side: BorderSide(color: AppColors.alertRed.withOpacity(0.2)),
                                padding: const EdgeInsets.symmetric(vertical: 12),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
                    .animate(delay: (index * 50).ms)
                    .fadeIn(duration: 220.ms, curve: Curves.easeOut)
                    .slideY(begin: 0.05, end: 0, duration: 240.ms, curve: Curves.easeOutCubic);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CreateReportScreen()),
          );
        },
        backgroundColor: AppColors.alertRed,
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
    );
  }
}
