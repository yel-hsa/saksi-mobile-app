import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/text_styles.dart';
import 'resident_dashboard.dart';
import 'history_screen.dart';
import 'settings_screen.dart';

class ResidentLayout extends StatefulWidget {
  const ResidentLayout({super.key});

  @override
  State<ResidentLayout> createState() => _ResidentLayoutState();
}

class _ResidentLayoutState extends State<ResidentLayout> {
  int _currentIndex = 0;

  void _setTab(int index) {
    if (_currentIndex == index) return;
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.paddingOf(context).bottom;
    final screens = <Widget>[
      ResidentDashboard(
        onNotificationsTap: () => _setTab(1),
        onProfileTap: () => _setTab(2),
      ),
      HistoryScreen(onBack: () => _setTab(0)),
      SettingsScreen(onBack: () => _setTab(0)),
    ];

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: screens,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: const Border(top: BorderSide(color: AppColors.borderLight)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 20,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        padding: EdgeInsets.only(bottom: bottomInset),
        child: SizedBox(
          height: 80,
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 448),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _NavItem(
                      label: 'Home',
                      isActive: _currentIndex == 0,
                      icon: _currentIndex == 0 ? Icons.home : Icons.home_outlined,
                      onTap: () => _setTab(0),
                    ),
                    _NavItem(
                      label: 'History',
                      isActive: _currentIndex == 1,
                      icon: _currentIndex == 1 ? Icons.history : Icons.history_outlined,
                      onTap: () => _setTab(1),
                    ),
                    _NavItem(
                      label: 'Settings',
                      isActive: _currentIndex == 2,
                      icon: _currentIndex == 2 ? Icons.settings : Icons.settings_outlined,
                      onTap: () => _setTab(2),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = isActive ? AppColors.alertRed : AppColors.textPrimary;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                Icon(icon, size: 24, color: color),
                if (isActive)
                  const Positioned(
                    bottom: -8,
                    child: SizedBox(
                      width: 4,
                      height: 4,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: AppColors.alertRed,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              label,
              style: AppTextStyles.navLabel.copyWith(color: color),
            ),
          ],
        ),
      ),
    );
  }
}
