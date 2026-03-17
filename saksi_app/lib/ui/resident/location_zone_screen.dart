import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../../core/mock_data.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/text_styles.dart';
import '../shared/custom_button.dart';

class LocationZoneScreen extends StatelessWidget {
  const LocationZoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = MockData.resident;
    final center = LatLng(user.homeZoneLat, user.homeZoneLng);

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
          'Home Zone',
          style: AppTextStyles.heading2.copyWith(fontWeight: FontWeight.w900),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              SizedBox(
                height: 260,
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: FlutterMap(
                    options: MapOptions(
                      initialCenter: center,
                      initialZoom: 16,
                      interactionOptions: const InteractionOptions(flags: InteractiveFlag.pinchZoom | InteractiveFlag.drag),
                    ),
                    children: [
                      TileLayer(
                        urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        userAgentPackageName: 'com.saksi.saksi_app',
                      ),
                      MarkerLayer(
                        markers: [
                          Marker(
                            point: LatLng(center.latitude + 0.0006, center.longitude + 0.0004),
                            width: 64,
                            height: 64,
                            child: const _ZoneMarker(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.95),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey[100]!),
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 10)],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.location_on, size: 14, color: AppColors.alertRed),
                      const SizedBox(width: 8),
                      Flexible(
                        child: Text(
                          '${user.householdAddress} Home Zone',
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
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
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
                      'GPS-FENCED VALIDATION',
                      style: AppTextStyles.bodySmall.copyWith(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                        color: Colors.grey[400],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Your SAKSI device is locked to this Home Zone. Violations are only recorded when the device reports from within this boundary.',
                      style: AppTextStyles.bodyMedium.copyWith(color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              CustomButton(
                text: 'Recalibrate Home Zone',
                fullWidth: true,
                size: ButtonSize.lg,
                variant: ButtonVariant.primary,
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Recalibration will be available in a later milestone.')),
                  );
                },
              ),
              const SizedBox(height: 12),
              CustomButton(
                text: 'Done',
                fullWidth: true,
                size: ButtonSize.lg,
                variant: ButtonVariant.outline,
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ZoneMarker extends StatelessWidget {
  const _ZoneMarker();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: AppColors.alertRed,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 3),
          boxShadow: [
            BoxShadow(
              color: AppColors.alertRed.withOpacity(0.35),
              blurRadius: 14,
              spreadRadius: 6,
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
    );
  }
}

