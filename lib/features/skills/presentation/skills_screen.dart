import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/core/theme/theme.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:simple_icons/simple_icons.dart';

class SkillsScreen extends StatelessWidget {
  const SkillsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 1000;

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(color: AppTheme.background),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: isDesktop ? size.width * 0.1 : 24,
          vertical: 80,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Section Title
            Text(
              'MY SKILLS',
              style: GoogleFonts.poppins(
                fontSize: isDesktop ? 48 : 36,
                fontWeight: FontWeight.bold,
                color: const Color(0xFFF2F7A1), // Light yellow from reference
                letterSpacing: 2,
              ),
            ).animate().fadeIn(duration: 600.ms).slideY(begin: -0.2, end: 0),

            const SizedBox(height: 60),

            if (isDesktop)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 3, child: _buildSkillsGrid()),
                  const SizedBox(width: 24),
                  Expanded(flex: 2, child: _buildExperienceCard(context)),
                ],
              )
            else
              Column(
                children: [
                  _buildSkillsGrid(),
                  const SizedBox(height: 24),
                  _buildExperienceCard(context),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSkillsGrid() {
    final skills = [
      const SkillItem('Flutter', FontAwesomeIcons.flutter, Color(0xFF42A5F5)),
      const SkillItem('Dart', FontAwesomeIcons.bullseye, Color(0xFF29B6F6)),
      const SkillItem('Android', FontAwesomeIcons.android, Color(0xFF3DDC84)),
      const SkillItem('Java', FontAwesomeIcons.java, Color(0xFFE76F00)),
      const SkillItem('C / C++', FontAwesomeIcons.c, Color(0xFF00599C)),
      const SkillItem('HTML / CSS', FontAwesomeIcons.html5, Color(0xFFE34F26)),
      const SkillItem('React', FontAwesomeIcons.react, Color(0xFF61DAFB)),
      const SkillItem('Firebase', FontAwesomeIcons.fire, Color(0xFFFFA000)),
      const SkillItem('MongoDB', FontAwesomeIcons.database, Color(0xFF4CAF50)),
      const SkillItem('Go', FontAwesomeIcons.golang, Color(0xFF00ADD8)),
      const SkillItem(
        'Postman',
        Icons.send,
        Color(0xFFFF6C37),
        assetPath: 'assets/images/postman_icon.png',
      ),
      const SkillItem('Git', FontAwesomeIcons.github, Color(0xFFFFFFFF)),
      const SkillItem('Figma', FontAwesomeIcons.figma, Color(0xFFF24E1E)),
    ];

    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: skills.map((skill) => _SkillCard(item: skill)).toList(),
    );
  }

  Widget _buildExperienceCard(BuildContext context) {
    return Container(
      height: 340, // Match approx height of 2 rows of skill cards
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: const Color(0xFF111111), // Darker background
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '7+',
            style: GoogleFonts.poppins(
              fontSize: 80,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              height: 1,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Months\nExperience\nWorking',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () => _launchUrl('assets/resume/kunalCV.pdf'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFF2F7A1), // Light yellow
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              textStyle: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
            child: const Text('DOWNLOAD MY CV'),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 400.ms).slideX(begin: 0.2, end: 0);
  }

  Future<void> _launchUrl(String url) async {
    // Implementation for launching URL
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }
}

class SkillItem {
  final String label;
  final IconData icon;
  final Color color;
  final String? assetPath;

  const SkillItem(this.label, this.icon, this.color, {this.assetPath});
}

class _SkillCard extends StatefulWidget {
  final SkillItem item;

  const _SkillCard({required this.item});

  @override
  State<_SkillCard> createState() => _SkillCardState();
}

class _SkillCardState extends State<_SkillCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 160,
        height: 160,
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A1C),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _isHovered
                ? widget.item.color
                : Colors.white.withOpacity(0.05),
            width: _isHovered ? 2 : 1,
          ),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: widget.item.color.withOpacity(0.2),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ]
              : [],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (widget.item.assetPath != null)
              Image.asset(widget.item.assetPath!, width: 48, height: 48)
            else
              Icon(widget.item.icon, size: 48, color: widget.item.color),
            const SizedBox(height: 16),
            Text(
              widget.item.label,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn().scale();
  }
}
