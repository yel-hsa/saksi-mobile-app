import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/mock_data.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_layout.dart';
import '../../core/constants/text_styles.dart';
import 'incident_detail_screen.dart';
import '../shared/filter_pill.dart';
import '../shared/custom_card.dart';

class HistoryScreen extends StatefulWidget {
  final VoidCallback? onBack;

  const HistoryScreen({super.key, this.onBack});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  String _activeFilter = 'Month';
  final List<String> _filters = ['Today', 'Week', 'Month'];

  List<Map<String, dynamic>> get _incidents => MockData.incidents
      .map(
        (i) => {
          'id': i.id,
          'date': i.date,
          'time': i.time,
          'peakDb': i.peakDb,
          'duration': i.duration,
          'status': i.status,
          'isViolation': i.peakDb >= MockData.violationThresholdDb,
        },
      )
      .toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackground,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        shadowColor: Colors.black12,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => (widget.onBack ?? () => Navigator.pop(context))(),
        ),
        title: Text(
          'Audit Log',
          style: AppTextStyles.heading2.copyWith(fontWeight: FontWeight.w900),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Summary Banner
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 24, 24, 8),
                  child: Container(
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
                        // Decorative gradients (simplified for Flutter)
                        Positioned(
                          right: -40,
                          top: -40,
                          child: Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.alertRed.withOpacity(0.2),
                            ),
                          ),
                        ),
                        Positioned(
                          left: -30,
                          bottom: -30,
                          child: Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.blue.withOpacity(0.2),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(24),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'TOTAL VIOLATIONS',
                                    style: AppTextStyles.bodySmall.copyWith(
                                      color: Colors.grey[400],
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1.5,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.baseline,
                                    textBaseline: TextBaseline.alphabetic,
                                    children: [
                                      Text(
                                        _incidents.length.toString(),
                                        style: AppTextStyles.heading1.copyWith(
                                          fontSize: 36,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        'Recorded',
                                        style: AppTextStyles.bodyMedium.copyWith(
                                          color: Colors.grey[400],
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Container(
                                width: 56,
                                height: 56,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.1),
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.white.withOpacity(0.2)),
                                ),
                                child: const Icon(Icons.verified_user, color: Colors.white, size: 28),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Filter Chips
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: FilterPill(
                          label: 'Filter',
                          selected: false,
                          icon: Icons.filter_list,
                          onTap: () {},
                        ),
                      ),
                      ..._filters.map((filter) => Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: FilterPill(
                              label: filter,
                              selected: _activeFilter == filter,
                              onTap: () => setState(() => _activeFilter = filter),
                            ),
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Timeline View
          if (_incidents.isEmpty)
            SliverFillRemaining(
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 96,
                      height: 96,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: Colors.grey[100]!),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: Icon(Icons.verified_user_outlined, size: 48, color: Colors.grey[300]),
                    ),
                    const SizedBox(height: 24),
                    Text('All Clear', style: AppTextStyles.heading1),
                    const SizedBox(height: 8),
                    Text(
                      'No recorded noise incidents in this time frame. Keep up the good work!',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary),
                    ),
                  ],
                ),
              ),
            )
          else
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final incident = _incidents[index];
                    final isViolation = incident['isViolation'] as bool;
                    final isResolved = incident['status'] == 'Resolved';

                    return IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Timeline Node
                          SizedBox(
                            width: 30,
                            child: Stack(
                              alignment: Alignment.topCenter,
                              children: [
                                if (index != _incidents.length - 1)
                                  Positioned(
                                    top: 24,
                                    bottom: 0,
                                    child: Container(width: 2, color: Colors.grey[200]),
                                  ),
                                Positioned(
                                  top: 20,
                                  child: Container(
                                    width: 16,
                                    height: 16,
                                    decoration: BoxDecoration(
                                      color: isViolation ? AppColors.alertRed : AppColors.success,
                                      shape: BoxShape.circle,
                                      border: Border.all(color: AppColors.appBackground, width: 4),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
                          
                          // Event Card
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 24),
                              child: CustomCard(
                                padding: CardPadding.none,
                                borderRadius: BorderRadius.circular(AppLayout.radiusMd),
                                interactive: true,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => IncidentDetailScreen(
                                        date: incident['date'],
                                        time: incident['time'],
                                        peakDb: incident['peakDb'],
                                        duration: incident['duration'],
                                        status: incident['status'],
                                      ),
                                    ),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(Icons.calendar_today, size: 14, color: Colors.grey[400]),
                                                const SizedBox(width: 6),
                                                Text(
                                                  incident['date'].toString().toUpperCase(),
                                                  style: AppTextStyles.bodySmall.copyWith(
                                                    color: Colors.grey[400],
                                                    fontWeight: FontWeight.bold,
                                                    letterSpacing: 1,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 8),
                                            Row(
                                              children: [
                                                Icon(Icons.access_time, size: 16, color: Colors.grey[400]),
                                                const SizedBox(width: 6),
                                                Text(
                                                  incident['time'],
                                                  style: AppTextStyles.bodyLarge.copyWith(fontWeight: FontWeight.bold),
                                                ),
                                                const SizedBox(width: 8),
                                                Container(
                                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                                  decoration: BoxDecoration(
                                                    color: Colors.grey[100],
                                                    borderRadius: BorderRadius.circular(6),
                                                  ),
                                                  child: Text(
                                                    incident['duration'],
                                                    style: AppTextStyles.bodySmall.copyWith(
                                                      color: Colors.grey[500],
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.baseline,
                                              textBaseline: TextBaseline.alphabetic,
                                              children: [
                                                Text(
                                                  incident['peakDb'].toString(),
                                                  style: AppTextStyles.heading1.copyWith(
                                                    color: isViolation ? AppColors.alertRed : AppColors.textPrimary,
                                                  ),
                                                ),
                                                const SizedBox(width: 2),
                                                Text(
                                                  'dB',
                                                  style: AppTextStyles.bodySmall.copyWith(
                                                    color: Colors.grey[400],
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Text(
                                              'PEAK NOISE',
                                              style: AppTextStyles.bodySmall.copyWith(
                                                fontSize: 10,
                                                color: Colors.grey[400],
                                                fontWeight: FontWeight.bold,
                                                letterSpacing: 1,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 16),
                                    const Divider(height: 1),
                                    const SizedBox(height: 16),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                          decoration: BoxDecoration(
                                            color: isViolation
                                                ? (isResolved ? const Color(0xFFFFFBEB) : const Color(0xFFFEF2F2))
                                                : const Color(0xFFF0FDF4),
                                            borderRadius: BorderRadius.circular(6),
                                            border: Border.all(
                                              color: isViolation
                                                  ? (isResolved ? const Color(0xFFFEF3C7) : const Color(0xFFFECACA))
                                                  : const Color(0xFFBBF7D0),
                                            ),
                                          ),
                                          child: Row(
                                            children: [
                                              Icon(
                                                isViolation ? Icons.warning_amber_rounded : Icons.check_circle_outline,
                                                size: 14,
                                                color: isViolation
                                                    ? (isResolved ? const Color(0xFFB45309) : AppColors.alertRed)
                                                    : const Color(0xFF15803D),
                                              ),
                                              const SizedBox(width: 6),
                                              Text(
                                                isViolation
                                                    ? (isResolved ? 'Violation Logged' : 'Pending Action')
                                                    : 'Compliant Log',
                                                style: AppTextStyles.bodySmall.copyWith(
                                                  color: isViolation
                                                      ? (isResolved ? const Color(0xFFB45309) : AppColors.alertRed)
                                                      : const Color(0xFF15803D),
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: 32,
                                          height: 32,
                                          decoration: BoxDecoration(
                                            color: Colors.grey[50],
                                            shape: BoxShape.circle,
                                          ),
                                          child: Icon(Icons.chevron_right, size: 20, color: Colors.grey[400]),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                        .animate(delay: (index * 60).ms)
                        .fadeIn(duration: 220.ms, curve: Curves.easeOut)
                        .slideY(begin: 0.06, end: 0, duration: 240.ms, curve: Curves.easeOutCubic);
                  },
                  childCount: _incidents.length,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
