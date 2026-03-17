import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/mock_data.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/text_styles.dart';
import 'evidence_detail_screen.dart';
import '../shared/custom_card.dart';

class AnalyticsScreen extends StatelessWidget {
  final VoidCallback? onBack;

  const AnalyticsScreen({super.key, this.onBack});

  @override
  Widget build(BuildContext context) {
    final chartData = MockData.hotspots
        .map(
          (h) => {'name': h.zoneLabel, 'db': h.peakDb, 'color': h.peakDb >= MockData.violationThresholdDb ? AppColors.alertRed : AppColors.textPrimary},
        )
        .toList();

    final offenders = [
      {
        'name': 'Household 104',
        'zone': 'Zone 4',
        'violations': 3,
        'color': AppColors.alertRed,
        'bgColor': const Color(0xFFFEF2F2),
        'risk': 'High Risk',
      },
      {
        'name': 'Household 052',
        'zone': 'Zone 2',
        'violations': 2,
        'color': Colors.amber[600],
        'bgColor': const Color(0xFFFFFBEB),
        'risk': 'Elevated Risk',
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.appBackground,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        shadowColor: Colors.black12,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => (onBack ?? () => Navigator.pop(context))(),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Analytics Dashboard', style: AppTextStyles.heading2.copyWith(fontWeight: FontWeight.w900)),
            Text(
              'COMMUNITY OVERVIEW',
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Risk Score Summary
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.textPrimary,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.12),
                    blurRadius: 30,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              clipBehavior: Clip.antiAlias,
              child: Stack(
                children: [
                  Positioned(
                    right: -60,
                    top: -60,
                    child: Container(
                      width: 160,
                      height: 160,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.alertRed.withOpacity(0.1),
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.show_chart, color: Colors.grey[400], size: 16),
                          const SizedBox(width: 8),
                          Text(
                            'COMMUNITY RISK SCORE',
                            style: AppTextStyles.bodySmall.copyWith(
                              color: Colors.grey[400],
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.5,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              Text(
                                '72',
                                style: AppTextStyles.heading1.copyWith(
                                  fontSize: 48,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                '/ 100',
                                style: AppTextStyles.bodyMedium.copyWith(
                                  color: Colors.grey[400],
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.red[500]!.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.red[500]!.withOpacity(0.3)),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.trending_up, color: Colors.red[300], size: 14),
                                const SizedBox(width: 4),
                                Text(
                                  '+12% vs last week',
                                  style: AppTextStyles.bodySmall.copyWith(
                                    color: Colors.red[300],
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
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

            // Data Viz Section (Simplified custom bar chart)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Escalation Trends', style: AppTextStyles.heading3.copyWith(fontWeight: FontWeight.w900)),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    'THIS WEEK',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: Colors.grey[600],
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
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
                children: [
                  // Simplified Bar Chart UI
                  ...chartData.map((data) => Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 60,
                              child: Text(
                                data['name'] as String,
                                style: AppTextStyles.bodySmall.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Expanded(
                              child: LayoutBuilder(
                                builder: (context, constraints) {
                                  // Max width represents 100dB
                                  final db = (data['db'] as num).toDouble();
                                  final double barWidth = (db / 100) * constraints.maxWidth;
                                  return Row(
                                    children: [
                                      Container(
                                        height: 24,
                                        width: barWidth.clamp(0.0, constraints.maxWidth),
                                        decoration: BoxDecoration(
                                          color: data['color'] as Color,
                                          borderRadius: const BorderRadius.only(
                                            topRight: Radius.circular(12),
                                            bottomRight: Radius.circular(12),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      )),
                  const SizedBox(height: 8),
                  const Divider(height: 1),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildLegendItem('Violation', AppColors.alertRed),
                      const SizedBox(width: 16),
                      _buildLegendItem('Warning', AppColors.warningRedSoft),
                      const SizedBox(width: 16),
                      _buildLegendItem('Normal', AppColors.textPrimary),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Repeat Offenders
            Text('Enforcement Activity', style: AppTextStyles.heading3.copyWith(fontWeight: FontWeight.w900)),
            const SizedBox(height: 16),
            ...offenders.asMap().entries.map((entry) {
              final index = entry.key;
              final offender = entry.value;
              final name = offender['name'] as String;
              final zone = offender['zone'] as String;
              final risk = offender['risk'] as String;
              final violations = offender['violations'] as int;
              final bgColor = offender['bgColor'] as Color;
              final color = offender['color'] as Color;

              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: CustomCard(
                  padding: CardPadding.none,
                  borderRadius: BorderRadius.circular(20),
                  interactive: true,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const EvidenceDetailScreen()),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: bgColor,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Colors.grey[100]!),
                          ),
                          child: Icon(Icons.person, color: color),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                name,
                                style: AppTextStyles.bodyLarge.copyWith(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Flexible(
                                    child: Text(
                                      zone,
                                      style: AppTextStyles.bodySmall.copyWith(fontWeight: FontWeight.w500),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.symmetric(horizontal: 8),
                                    width: 4,
                                    height: 4,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  Flexible(
                                    child: Text(
                                      risk.toUpperCase(),
                                      style: AppTextStyles.bodySmall.copyWith(
                                        color: color,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 1,
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
                            color: const Color(0xFFFEF2F2),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: const Color(0xFFFECACA)),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.warning_amber_rounded, color: AppColors.alertRed, size: 14),
                              const SizedBox(width: 6),
                              Text(
                                violations.toString(),
                                style: AppTextStyles.bodySmall.copyWith(
                                  color: AppColors.alertRed,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Icon(Icons.chevron_right, color: Colors.grey[300]),
                      ],
                    ),
                  ),
                ),
              )
                  .animate(delay: (index * 60).ms)
                  .fadeIn(duration: 220.ms, curve: Curves.easeOut)
                  .slideY(begin: 0.06, end: 0, duration: 240.ms, curve: Curves.easeOutCubic);
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label.toUpperCase(),
          style: AppTextStyles.bodySmall.copyWith(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
      ],
    );
  }
}
