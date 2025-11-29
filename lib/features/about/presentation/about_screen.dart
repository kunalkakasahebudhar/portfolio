import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/core/theme/theme.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 900;

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(color: AppTheme.background),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: isDesktop ? size.width * 0.15 : 24,
          vertical: 80,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Section Title
            ShaderMask(
              shaderCallback: (bounds) => const LinearGradient(
                colors: [Colors.white, AppTheme.accentColor],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ).createShader(bounds),
              child: Text(
                'About Me',
                style: GoogleFonts.poppins(
                  fontSize: isDesktop ? 48 : 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ).animate().fadeIn(duration: 600.ms).slideY(begin: -0.2, end: 0),

            const SizedBox(height: 16),

            // Subtitle Decoration
            Container(
              width: 60,
              height: 4,
              decoration: BoxDecoration(
                color: AppTheme.accentColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ).animate().fadeIn(delay: 200.ms).scaleX(),

            const SizedBox(height: 60),

            // Bio Content
            _buildBio(context, isDesktop),

            const SizedBox(height: 60),

            // Info Cards
            _buildInfoCards(context, isDesktop),
          ],
        ),
      ),
    );
  }

  Widget _buildBio(BuildContext context, bool isDesktop) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 900),
      child: Column(
        children: [
          Text(
            "I'm a Junior Flutter Developer focused on building smooth, high-performance mobile apps. Skilled in Dart, Flutter, UI/UX, API integration, and REST architecture.",
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: isDesktop ? 18 : 16,
              color: AppTheme.primaryText,
              height: 1.8,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            "I convert ideas into scalable, user-friendly applications. Currently learning State Management, Backend Connectivity, and Golang. My goal is to create meaningful projects that provide real value to users.",
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: isDesktop ? 18 : 16,
              color: AppTheme.secondaryText,
              height: 1.8,
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.2, end: 0);
  }

  Widget _buildInfoCards(BuildContext context, bool isDesktop) {
    return Wrap(
      spacing: 32,
      runSpacing: 32,
      alignment: WrapAlignment.center,
      children: [
        _InfoCard(
          title: 'Experience',
          icon: Icons.work_outline_rounded,
          items: const [
            'Junior Flutter Developer At MHTECHIN',
            'Android Developer Intern At MHTECHIN',
          ],
          width: isDesktop ? 400 : double.infinity,
          delay: 600.ms,
        ),
        _InfoCard(
          title: 'Education',
          icon: Icons.school_outlined,
          items: const [
            'Polytechnic Diploma in Computer Science',
            'Certified Flutter Developer',
          ],
          width: isDesktop ? 400 : double.infinity,
          delay: 800.ms,
        ),
      ],
    );
  }
}

class _InfoCard extends StatefulWidget {
  final String title;
  final IconData icon;
  final List<String> items;
  final double width;
  final Duration delay;

  const _InfoCard({
    required this.title,
    required this.icon,
    required this.items,
    required this.width,
    required this.delay,
  });

  @override
  State<_InfoCard> createState() => _InfoCardState();
}

class _InfoCardState extends State<_InfoCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: widget.width,
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: _isHovered
              ? AppTheme.cardColor.withOpacity(0.8)
              : AppTheme.cardColor.withOpacity(0.5),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: _isHovered
                ? AppTheme.accentColor.withOpacity(0.5)
                : Colors.white.withOpacity(0.05),
          ),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: AppTheme.accentColor.withOpacity(0.1),
                    blurRadius: 30,
                    offset: const Offset(0, 10),
                  ),
                ]
              : [],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppTheme.accentColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    widget.icon,
                    color: AppTheme.accentColor,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 16),
                Text(
                  widget.title,
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.primaryText,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            ...widget.items.map(
              (item) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Icon(
                        Icons.circle,
                        size: 6,
                        color: _isHovered
                            ? AppTheme.accentColor
                            : AppTheme.secondaryText,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        item,
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          color: AppTheme.secondaryText,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(delay: widget.delay).slideY(begin: 0.2, end: 0);
  }
}
