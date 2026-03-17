import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class HeatMarker {
  final double x;
  final double y;
  final HeatMarkerSeverity severity;
  final VoidCallback? onTap;

  const HeatMarker({
    required this.x,
    required this.y,
    required this.severity,
    this.onTap,
  });
}

enum HeatMarkerSeverity { critical, warning, normal }

class MapboxPlaceholder extends StatefulWidget {
  final List<HeatMarker> markers;
  final Widget? bottomLeftLabel;
  final bool showControls;
  final double borderRadius;
  final bool showBorder;

  const MapboxPlaceholder({
    super.key,
    required this.markers,
    this.bottomLeftLabel,
    this.showControls = true,
    this.borderRadius = 24,
    this.showBorder = true,
  });

  @override
  State<MapboxPlaceholder> createState() => _MapboxPlaceholderState();
}

class _MapboxPlaceholderState extends State<MapboxPlaceholder> with SingleTickerProviderStateMixin {
  late final AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(vsync: this, duration: const Duration(seconds: 2))..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                color: AppColors.mapBackground,
                borderRadius: BorderRadius.circular(widget.borderRadius),
                border: widget.showBorder ? Border.all(color: AppColors.borderLight) : null,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                child: Stack(
                  children: [
                    CustomPaint(size: Size.infinite, painter: _GridPainter()),
                    CustomPaint(size: Size.infinite, painter: _RoadPainter()),
                  ],
                ),
              ),
            ),
            ...widget.markers.map((m) {
              final left = (constraints.maxWidth * m.x).clamp(0.0, constraints.maxWidth);
              final top = (constraints.maxHeight * m.y).clamp(0.0, constraints.maxHeight);

              return Positioned(
                left: left,
                top: top,
                child: GestureDetector(
                  onTap: m.onTap,
                  behavior: HitTestBehavior.opaque,
                  child: AnimatedBuilder(
                    animation: _pulseController,
                    builder: (context, child) {
                      final pulse = 1.0 + (_pulseController.value * 0.2);
                      final color = _markerColor(m.severity);
                      final glowOpacity = m.severity == HeatMarkerSeverity.critical ? 0.22 : 0.12;

                      return Stack(
                        alignment: Alignment.center,
                        children: [
                          if (m.severity == HeatMarkerSeverity.critical)
                            Transform.scale(
                              scale: pulse * 2,
                              child: Container(
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: color.withOpacity(glowOpacity),
                                ),
                              ),
                            ),
                          Container(
                            width: m.severity == HeatMarkerSeverity.critical ? 32 : 22,
                            height: m.severity == HeatMarkerSeverity.critical ? 32 : 22,
                            decoration: BoxDecoration(
                              color: color,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: m.severity == HeatMarkerSeverity.critical ? 3 : 2),
                              boxShadow: [
                                BoxShadow(
                                  color: color.withOpacity(0.35),
                                  blurRadius: 12,
                                  spreadRadius: m.severity == HeatMarkerSeverity.critical ? 4 : 1,
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
                        ],
                      );
                    },
                  ),
                ),
              );
            }),
            if (widget.showControls)
              Positioned(
                right: 16,
                top: 16,
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10)],
                      ),
                      child: Column(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.add, color: AppColors.textPrimary),
                            onPressed: () {},
                          ),
                          Container(height: 1, width: 30, color: Colors.grey[200]),
                          IconButton(
                            icon: const Icon(Icons.remove, color: AppColors.textPrimary),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10)],
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.navigation, color: AppColors.textPrimary),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),
            if (widget.bottomLeftLabel != null)
              Positioned(
                left: 12,
                bottom: 12,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.95),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey[100]!),
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 10)],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: widget.bottomLeftLabel,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  Color _markerColor(HeatMarkerSeverity severity) {
    switch (severity) {
      case HeatMarkerSeverity.critical:
        return AppColors.alertRed;
      case HeatMarkerSeverity.warning:
        return AppColors.warningRedSoft;
      case HeatMarkerSeverity.normal:
        return Colors.grey[500]!;
    }
  }
}

class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.mapGridLine.withOpacity(0.35)
      ..strokeWidth = 1.0;

    for (double i = 0; i < size.width; i += 40) {
      canvas.drawLine(Offset(i, 0), Offset(i, size.height), paint);
    }
    for (double i = 0; i < size.height; i += 40) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _RoadPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.mapRoadLine.withOpacity(0.3)
      ..strokeWidth = 12.0
      ..strokeCap = StrokeCap.round;

    final paintThick = Paint()
      ..color = AppColors.mapRoadLine.withOpacity(0.3)
      ..strokeWidth = 16.0
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(Offset(size.width * 0.12, 0), Offset(size.width * 0.18, size.height), paint);
    canvas.drawLine(Offset(size.width * 0.45, 0), Offset(size.width * 0.42, size.height), paint);
    canvas.drawLine(Offset(size.width * 0.78, 0), Offset(size.width * 0.82, size.height), paint);

    canvas.drawLine(Offset(0, size.height * 0.22), Offset(size.width, size.height * 0.28), paintThick);
    canvas.drawLine(Offset(0, size.height * 0.5), Offset(size.width, size.height * 0.46), paintThick);
    canvas.drawLine(Offset(0, size.height * 0.72), Offset(size.width, size.height * 0.78), paintThick);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

