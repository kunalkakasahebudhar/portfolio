import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:portfolio/core/theme/theme.dart';

class ExperienceScreen extends StatelessWidget {
  const ExperienceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 900;

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(color: AppTheme.background),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: isDesktop ? size.width * 0.1 : 24,
          vertical: 60,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Experience',
              style: Theme.of(context).textTheme.displayMedium,
            ).animate().fadeIn().slideX(),
            const SizedBox(height: 40),
            _buildExperienceItem(
              context,
              company: 'MHTECHIN',
              role: 'Junior Flutter Developer',
              period: 'Sept 2025 - Present',
              description:
                  'Developing cross-platform mobile applications using Flutter. Collaborating with the design and backend teams to deliver high-quality products.',
              isFirst: true,
              isLast: false,
              delay: 200,
            ),
            _buildExperienceItem(
              context,
              company: 'Internship + Full-Time',
              role: 'Android Developer',
              period: 'June - Aug',
              description:
                  'Worked on native Android development using Kotlin/Java. Assisted in bug fixing and feature implementation.',
              isFirst: false,
              isLast: true,
              delay: 400,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExperienceItem(
    BuildContext context, {
    required String company,
    required String role,
    required String period,
    required String description,
    required bool isFirst,
    required bool isLast,
    required int delay,
  }) {
    return CustomPaint(
      painter: _TimelinePainter(
        isLast: isLast,
        color: AppTheme.accentColor,
        backgroundColor: AppTheme.background,
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 50),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 40),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppTheme.cardColor,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    Text(
                      role,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: AppTheme.primaryText,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: AppTheme.accentColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        period,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppTheme.accentColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  company,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppTheme.accentColor,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  description,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ),
      ),
    ).animate().fadeIn(delay: delay.ms).slideX(begin: 0.2, end: 0);
  }
}

class _TimelinePainter extends CustomPainter {
  final bool isLast;
  final Color color;
  final Color backgroundColor;

  _TimelinePainter({
    required this.isLast,
    required this.color,
    required this.backgroundColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final linePaint = Paint()
      ..color = color.withValues(alpha: 0.3)
      ..strokeWidth = 2;

    // Draw line
    if (!isLast) {
      canvas.drawLine(const Offset(25, 20), Offset(25, size.height), linePaint);
    }

    // Draw circle border (background)
    final borderPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;

    // Draw circle
    canvas.drawCircle(const Offset(25, 10), 10, paint);
    canvas.drawCircle(const Offset(25, 10), 10, borderPaint);
  }

  @override
  bool shouldRepaint(covariant _TimelinePainter oldDelegate) {
    return oldDelegate.isLast != isLast ||
        oldDelegate.color != color ||
        oldDelegate.backgroundColor != backgroundColor;
  }
}
