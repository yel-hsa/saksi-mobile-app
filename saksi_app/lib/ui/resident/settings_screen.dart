import 'package:flutter/material.dart';
import '../../core/mock_data.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/text_styles.dart';
import '../auth/splash_screen.dart';
import 'location_zone_screen.dart';
import 'ordinances_screen.dart';
import 'privacy_overview_screen.dart';
import 'setup_pairing_screen.dart';

class SettingsScreen extends StatefulWidget {
  final VoidCallback? onBack;

  const SettingsScreen({super.key, this.onBack});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _pushAlertsEnabled = true;

  @override
  Widget build(BuildContext context) {
    final user = MockData.resident;

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
          'Profile & Settings',
          style: AppTextStyles.heading2.copyWith(fontWeight: FontWeight.w900),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Card
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
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    right: -40,
                    top: -40,
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.alertRed.withOpacity(0.05),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        width: 72,
                        height: 72,
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.grey[100]!),
                        ),
                        child: Icon(Icons.person, size: 32, color: Colors.grey[400]),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user.fullName,
                              style: AppTextStyles.heading1.copyWith(
                                fontSize: 20,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                user.hardwareId.replaceAll('SAKSI-ESP32-', 'SAKSI-'),
                                style: AppTextStyles.bodySmall.copyWith(
                                  color: Colors.grey[500],
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1,
                                ),
                              ),
                            ),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                Icon(Icons.location_on, size: 14, color: Colors.grey[400]),
                                const SizedBox(width: 4),
                                Expanded(
                                  child: Text(
                                    user.householdAddress,
                                    style: AppTextStyles.bodySmall.copyWith(
                                      color: Colors.grey[400],
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
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Device & Alerts
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Text(
                'DEVICE & ALERTS',
                style: AppTextStyles.bodySmall.copyWith(
                  color: Colors.grey[400],
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
            ),
            Container(
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
                  _buildListTile(
                    icon: Icons.location_on,
                    iconColor: AppColors.alertRed,
                    iconBgColor: AppColors.alertRed.withOpacity(0.1),
                    title: 'Location Zone',
                    subtitle: 'Recalibrate home boundaries',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const LocationZoneScreen()),
                      );
                    },
                  ),
                  const Divider(height: 1, indent: 20, endIndent: 20),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.grey[50],
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey[100]!),
                          ),
                          child: Icon(Icons.notifications, size: 20, color: Colors.grey[600]),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Push Alerts', style: AppTextStyles.bodyLarge.copyWith(fontWeight: FontWeight.bold)),
                              Text(
                                'Warnings & threshold breaches',
                                style: AppTextStyles.bodySmall.copyWith(fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                        Switch(
                          value: _pushAlertsEnabled,
                          onChanged: (val) => setState(() => _pushAlertsEnabled = val),
                          activeColor: Colors.white,
                          activeTrackColor: Colors.green[500],
                          inactiveThumbColor: Colors.white,
                          inactiveTrackColor: Colors.grey[300],
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 1, indent: 20, endIndent: 20),
                  _buildListTile(
                    icon: Icons.wifi,
                    iconColor: Colors.grey[600]!,
                    iconBgColor: Colors.grey[50]!,
                    title: 'Sensor Network',
                    subtitle: 'Connected to: Saksi-Home-5G',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SetupPairingScreen()),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Support & Legal
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Text(
                'SUPPORT & LEGAL',
                style: AppTextStyles.bodySmall.copyWith(
                  color: Colors.grey[400],
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
            ),
            Container(
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
                  _buildListTile(
                    icon: Icons.shield,
                    iconColor: Colors.blue[600]!,
                    iconBgColor: Colors.blue[50]!,
                    title: 'Privacy Overview',
                    subtitle: 'How your data is protected',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const PrivacyOverviewScreen()),
                      );
                    },
                  ),
                  const Divider(height: 1, indent: 20, endIndent: 20),
                  _buildListTile(
                    icon: Icons.description,
                    iconColor: Colors.grey[600]!,
                    iconBgColor: Colors.grey[50]!,
                    title: 'Barangay Ordinances',
                    subtitle: 'Local noise regulations guide',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const OrdinancesScreen()),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Logout Button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const SplashScreen()),
                    (route) => false,
                  );
                },
                icon: const Icon(Icons.logout, color: AppColors.alertRed),
                label: Text(
                  'Sign Out Device',
                  style: AppTextStyles.bodyLarge.copyWith(
                    color: AppColors.alertRed,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  side: BorderSide(color: Colors.grey[200]!),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListTile({
    required IconData icon,
    required Color iconColor,
    required Color iconBgColor,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: iconBgColor,
                borderRadius: BorderRadius.circular(12),
                border: iconBgColor == Colors.grey[50] ? Border.fromBorderSide(BorderSide(color: Colors.grey[100]!)) : null,
              ),
              child: Icon(icon, size: 20, color: iconColor),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTextStyles.bodyLarge.copyWith(fontWeight: FontWeight.bold)),
                  Text(
                    subtitle,
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
  }
}
