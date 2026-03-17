import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../../core/mock_data.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_layout.dart';
import '../../core/constants/text_styles.dart';
import 'evidence_detail_screen.dart';

class CommandCenterMap extends StatefulWidget {
  const CommandCenterMap({super.key});

  @override
  State<CommandCenterMap> createState() => _CommandCenterMapState();
}

class _CommandCenterMapState extends State<CommandCenterMap> {
  int? _selectedZone = 4;
  bool _isListExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackground,
      body: Stack(
        children: [
          Positioned.fill(
            child: _CommandCenterMapView(
              onHotspotTap: (zoneIndex) => setState(() => _selectedZone = zoneIndex),
            ),
          ),

          // Header
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 16,
                left: AppLayout.gutter,
                right: AppLayout.gutter,
                bottom: 16,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: const [AppLayout.headerShadow],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: AppColors.textPrimary,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0x14000000),
                              blurRadius: 12,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: const Icon(Icons.shield, color: Colors.white, size: 20),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Command Center',
                            style: AppTextStyles.heading1.copyWith(
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                              height: 1,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Container(
                                width: 6,
                                height: 6,
                                decoration: BoxDecoration(
                                  color: AppColors.success,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                'LIVE FEED ACTIVE',
                                style: AppTextStyles.bodySmall.copyWith(
                                  color: AppColors.successText,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                  letterSpacing: 1,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey[100]!),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.filter_list, color: AppColors.textPrimary, size: 20),
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
                                  Text('Filters', style: AppTextStyles.heading2),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Filtering is a UI-only placeholder. Backend query filters will be added later.',
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
            ),
          ),

          // Floating Stats Row
          Positioned(
            top: MediaQuery.of(context).padding.top + 90,
            left: 16,
            right: 16,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.white.withOpacity(0.4)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
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
                              'ACTIVE VIOLATIONS',
                              style: AppTextStyles.bodySmall.copyWith(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1,
                              ),
                            ),
                            Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                color: AppColors.alertRed,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '3',
                          style: AppTextStyles.heading1.copyWith(
                            fontSize: 32,
                            color: AppColors.alertRed,
                            height: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.white.withOpacity(0.4)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
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
                              'HIGH-RISK ZONES',
                              style: AppTextStyles.bodySmall.copyWith(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1,
                              ),
                            ),
                            Icon(Icons.location_on, size: 12, color: Colors.amber[500]),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '2',
                          style: AppTextStyles.heading1.copyWith(
                            fontSize: 32,
                            height: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Bottom Sheet
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOutCubic,
            bottom: 0,
            left: 0,
            right: 0,
            height: _selectedZone != null ? 340 : (_isListExpanded ? MediaQuery.of(context).size.height * 0.6 : 80),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.12),
                    blurRadius: 40,
                    offset: const Offset(0, -10),
                  ),
                ],
              ),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (_selectedZone == null) {
                          _isListExpanded = !_isListExpanded;
                        } else {
                          _selectedZone = null;
                        }
                      });
                    },
                    child: Container(
                      width: double.infinity,
                      color: Colors.transparent,
                      padding: const EdgeInsets.only(top: 16, bottom: 8),
                      child: Column(
                        children: [
                          Container(
                            width: 48,
                            height: 6,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                          if (_selectedZone == null)
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                _isListExpanded ? 'SWIPE DOWN TO CLOSE' : 'SWIPE UP FOR CASES',
                                style: AppTextStyles.bodySmall.copyWith(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.5,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: _selectedZone == 4 ? _buildSelectedZoneView() : _buildCaseList(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectedZoneView() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
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
                      Text('Zone 4', style: AppTextStyles.heading1.copyWith(fontSize: 24, height: 1)),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppColors.alertRed,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          'CRITICAL',
                          style: AppTextStyles.bodySmall.copyWith(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.location_on, size: 14, color: Colors.grey[500]),
                      const SizedBox(width: 4),
                      Text(
                        'Mabini St. Block 2',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: Colors.grey[500],
                          fontWeight: FontWeight.w600,
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
                        '88',
                        style: AppTextStyles.heading1.copyWith(
                          fontSize: 32,
                          color: AppColors.alertRed,
                          height: 1,
                        ),
                      ),
                      Text(
                        'dB',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.alertRed,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'PEAK NOISE',
                    style: AppTextStyles.bodySmall.copyWith(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFFEF2F2),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFFECACA)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.notifications_active, color: AppColors.alertRed, size: 20),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Active Dispute Logged',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: Colors.red[900],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Multiple resident reports received in the last 15 minutes. Protocol dictates intervention.',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: Colors.red[700],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          Row(
            children: [
              Expanded(
                flex: 2,
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
                              decoration: BoxDecoration(
                                color: AppColors.textPrimary.withOpacity(0.06),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.shield, color: AppColors.textPrimary, size: 28),
                            ),
                            const SizedBox(height: 16),
                            Text('Dispatch Logged', style: AppTextStyles.heading2),
                            const SizedBox(height: 8),
                            Text(
                              'Dispatching is simulated. This action will later notify tanods and update the case status.',
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
                  icon: const Icon(Icons.shield, color: Colors.white, size: 20),
                  label: Text(
                    'Dispatch Tanod',
                    style: AppTextStyles.bodyLarge.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.textPrimary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    elevation: 8,
                    shadowColor: AppColors.textPrimary.withOpacity(0.5),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 1,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EvidenceDetailScreen(caseFile: MockData.caseFiles.first)),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.grey[50],
                    side: BorderSide(color: Colors.grey[200]!),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  child: Text(
                    'View Details',
                    style: AppTextStyles.bodyLarge.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCaseList() {
    if (!_isListExpanded) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Active Cases', style: AppTextStyles.heading2.copyWith(fontWeight: FontWeight.w900)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFFEF2F2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '3 Requires Action',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.alertRed,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.separated(
              itemCount: 3,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final isCritical = index == 0;
                final zone = index == 0 ? 4 : index == 1 ? 2 : 9;

                return InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () {
                    setState(() {
                      _selectedZone = zone;
                      _isListExpanded = false;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey[100]!),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.02),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: isCritical ? const Color(0xFFFEF2F2) : const Color(0xFFFFFBEB),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            Icons.notifications_active,
                            color: isCritical ? AppColors.alertRed : Colors.amber[600],
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Zone $zone',
                                style: AppTextStyles.bodyLarge.copyWith(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                index == 0 ? 'Mabini St. Block 2' : 'Rizal Ave.',
                                style: AppTextStyles.bodySmall.copyWith(fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                        Icon(Icons.chevron_right, color: Colors.grey[300]),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _CommandCenterMapView extends StatelessWidget {
  final void Function(int zoneIndex) onHotspotTap;

  const _CommandCenterMapView({required this.onHotspotTap});

  @override
  Widget build(BuildContext context) {
    final center = LatLng(MockData.resident.homeZoneLat, MockData.resident.homeZoneLng);
    final hotspots = MockData.hotspots;

    return FlutterMap(
      options: MapOptions(
        initialCenter: center,
        initialZoom: 15,
        interactionOptions: const InteractionOptions(
          flags: InteractiveFlag.pinchZoom | InteractiveFlag.drag,
        ),
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.saksi.saksi_app',
        ),
        MarkerLayer(
          markers: [
            for (int i = 0; i < hotspots.length; i++)
              Marker(
                point: LatLng(
                  center.latitude + (i == 0 ? 0.0012 : i == 1 ? -0.0008 : 0.0003),
                  center.longitude + (i == 0 ? 0.0010 : i == 1 ? -0.0011 : -0.0004),
                ),
                width: 64,
                height: 64,
                child: _HeatMarker(
                  severity: i == 0 ? _HeatSeverity.critical : i == 1 ? _HeatSeverity.warning : _HeatSeverity.normal,
                  onTap: () => onHotspotTap(i == 0 ? 4 : i == 1 ? 2 : 7),
                ),
              ),
          ],
        ),
      ],
    );
  }
}

enum _HeatSeverity { critical, warning, normal }

class _HeatMarker extends StatelessWidget {
  final _HeatSeverity severity;
  final VoidCallback onTap;

  const _HeatMarker({required this.severity, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final Color color;
    switch (severity) {
      case _HeatSeverity.critical:
        color = AppColors.alertRed;
        break;
      case _HeatSeverity.warning:
        color = AppColors.warningRedSoft;
        break;
      case _HeatSeverity.normal:
        color = Colors.grey[600]!;
        break;
    }

    final double size = severity == _HeatSeverity.critical ? 32 : 24;

    return GestureDetector(
      onTap: onTap,
      child: Center(
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: severity == _HeatSeverity.critical ? 3 : 2),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.35),
                blurRadius: 14,
                spreadRadius: severity == _HeatSeverity.critical ? 6 : 2,
              ),
            ],
          ),
          child: Center(
            child: Container(
              width: 6,
              height: 6,
              decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
            ),
          ),
        ),
      ),
    );
  }
}
