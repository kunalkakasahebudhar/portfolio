import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/core/theme/theme.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:portfolio/core/utils/launcher/launcher.dart';

class HomeScreen extends StatelessWidget {
  final VoidCallback? onViewProjects;

  const HomeScreen({super.key, this.onViewProjects});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 900;

    return Container(
      width: double.infinity,
      constraints: BoxConstraints(minHeight: size.height),
      child: Stack(
        children: [
          // Background Gradient Blobs
          Positioned(
            top: -100,
            right: -100,
            child: Container(
              width: 500,
              height: 500,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppTheme.accentColor.withOpacity(0.1),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.accentColor.withOpacity(0.2),
                    blurRadius: 100,
                    spreadRadius: 20,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: -100,
            left: -100,
            child: Container(
              width: 400,
              height: 400,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.purple.withOpacity(0.1),
                boxShadow: [
                  BoxShadow(
                    color: Colors.purple.withOpacity(0.2),
                    blurRadius: 100,
                    spreadRadius: 20,
                  ),
                ],
              ),
            ),
          ),

          // Content
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isDesktop ? size.width * 0.1 : 24,
                vertical: 60,
              ),
              child: isDesktop
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(child: _buildTextContent(context, isDesktop)),
                        const SizedBox(width: 60),
                        Expanded(child: _buildVisualContent(context)),
                      ],
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildVisualContent(context),
                        const SizedBox(height: 40),
                        _buildTextContent(context, isDesktop),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextContent(BuildContext context, bool isDesktop) {
    return Column(
      crossAxisAlignment: isDesktop
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Hello Chip
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: AppTheme.accentColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: AppTheme.accentColor.withOpacity(0.2)),
          ),
          child: Text(
            '👋 Hello, I\'m',
            style: GoogleFonts.inter(
              color: AppTheme.accentColor,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.2, end: 0),

        const SizedBox(height: 24),

        // Name with Gradient
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [Colors.white, Color(0xFFE0E0E0)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ).createShader(bounds),
          child: Text(
            'Kunal Udhar',
            textAlign: isDesktop ? TextAlign.left : TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: isDesktop ? 72 : 48,
              fontWeight: FontWeight.bold,
              height: 1.1,
              color: Colors.white,
            ),
          ),
        ).animate().fadeIn(delay: 200.ms).slideX(begin: -0.2, end: 0),

        const SizedBox(height: 16),

        // Role
        Text(
          'Mobile Application Developer',
          textAlign: isDesktop ? TextAlign.left : TextAlign.center,
          style: GoogleFonts.inter(
            fontSize: isDesktop ? 24 : 18,
            color: AppTheme.secondaryText,
            fontWeight: FontWeight.w500,
          ),
        ).animate().fadeIn(delay: 400.ms).slideX(begin: -0.2, end: 0),

        Text(
          'Android & Flutter',
          textAlign: isDesktop ? TextAlign.left : TextAlign.center,
          style: GoogleFonts.inter(
            fontSize: isDesktop ? 24 : 18,
            color: AppTheme.accentColor,
            fontWeight: FontWeight.w600,
          ),
        ).animate().fadeIn(delay: 500.ms).slideX(begin: -0.2, end: 0),

        const SizedBox(height: 32),

        // Description
        Text(
          'I create modern, user-friendly, and performance-focused mobile applications using Flutter and Android. I focus on clean UI, smooth animations, and delivering seamless experiences for real-world users and businesses.',
          textAlign: isDesktop ? TextAlign.left : TextAlign.center,
          style: GoogleFonts.inter(
            fontSize: 16,
            color: AppTheme.secondaryText.withOpacity(0.8),
            height: 1.6,
          ),
        ).animate().fadeIn(delay: 600.ms).slideX(begin: -0.2, end: 0),

        const SizedBox(height: 48),

        // Buttons
        Wrap(
          spacing: 20,
          runSpacing: 20,
          alignment: isDesktop ? WrapAlignment.start : WrapAlignment.center,
          children: [
            ElevatedButton(
              onPressed: onViewProjects,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.accentColor,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 20,
                ),
                elevation: 8,
                shadowColor: AppTheme.accentColor.withOpacity(0.4),
              ),
              child: const Text('View Projects'),
            ),
            OutlinedButton(
              onPressed: () => launchCV(),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 20,
                ),
                side: const BorderSide(color: AppTheme.accentColor),
                foregroundColor: AppTheme.accentColor,
              ),
              child: const Text('Download Resume'),
            ),
          ],
        ).animate().fadeIn(delay: 800.ms).slideY(begin: 0.2, end: 0),

        const SizedBox(height: 60),

        // Socials
        _buildSocialLinks(isDesktop).animate().fadeIn(delay: 1000.ms),
      ],
    );
  }

  Widget _buildVisualContent(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 500),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Decorative Circle
          Container(
                width: 320,
                height: 320,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppTheme.accentColor.withOpacity(0.2),
                    width: 2,
                  ),
                ),
              )
              .animate(onPlay: (controller) => controller.repeat())
              .rotate(duration: 10.seconds),

          Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppTheme.cardColor,
              boxShadow: [
                BoxShadow(
                  color: AppTheme.accentColor.withOpacity(0.2),
                  blurRadius: 50,
                  spreadRadius: 10,
                ),
              ],
              image: const DecorationImage(
                image: AssetImage('assets/images/profile_pic.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 800.ms).scale();
  }

  Widget _buildSocialLinks(bool isDesktop) {
    return Row(
      mainAxisAlignment: isDesktop
          ? MainAxisAlignment.start
          : MainAxisAlignment.center,
      children: [
        _SocialIcon(
          icon: FontAwesomeIcons.github,
          onTap: () => _launchUrl('https://github.com/kunalkakasahebudhar'),
        ),
        const SizedBox(width: 24),
        _SocialIcon(
          icon: FontAwesomeIcons.linkedin,
          onTap: () =>
              _launchUrl('https://www.linkedin.com/in/kunal-udhar-99a6ba32b/'),
        ),
        const SizedBox(width: 24),
        _SocialIcon(
          icon: FontAwesomeIcons.envelope,
          onTap: () => _launchUrl('mailto:kudhar892@gmail.com'),
        ),
      ],
    );
  }

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }
}

class _SocialIcon extends StatefulWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _SocialIcon({required this.icon, required this.onTap});

  @override
  State<_SocialIcon> createState() => _SocialIconState();
}

class _SocialIconState extends State<_SocialIcon> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _isHovered
                ? AppTheme.accentColor.withOpacity(0.1)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _isHovered
                  ? AppTheme.accentColor
                  : AppTheme.secondaryText.withOpacity(0.2),
            ),
          ),
          child: FaIcon(
            widget.icon,
            color: _isHovered ? AppTheme.accentColor : AppTheme.secondaryText,
            size: 24,
          ),
        ),
      ),
    );
  }
}
