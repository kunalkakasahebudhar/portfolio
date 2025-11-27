import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/core/theme/theme.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 900;

    return Container(
      width: double.infinity,
      constraints: BoxConstraints(minHeight: size.height),
      decoration: const BoxDecoration(color: AppTheme.background),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: isDesktop ? size.width * 0.1 : 24,
          vertical: 60,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 40),

            /// Hello Line
            Text(
              'Hello, I\'m',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppTheme.accentColor,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ).animate().fadeIn(duration: 600.ms).slideX(begin: -0.2, end: 0),

            const SizedBox(height: 16),

            /// Name
            Text(
                  'Kunal Udhar',
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    fontSize: isDesktop ? 64 : 42,
                    height: 1.1,
                  ),
                )
                .animate()
                .fadeIn(delay: 200.ms, duration: 600.ms)
                .slideX(begin: -0.2, end: 0),

            const SizedBox(height: 16),

            /// Title
            Text(
                  'Mobile Application Developer\nAndroid & Flutter',
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    fontSize: isDesktop ? 32 : 24,
                    color: AppTheme.secondaryText,
                  ),
                )
                .animate()
                .fadeIn(delay: 400.ms, duration: 600.ms)
                .slideX(begin: -0.2, end: 0),

            const SizedBox(height: 24),

            /// Subtitle
            Text(
                  'Building Modern Mobile Experiences',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontSize: 20,
                    color: AppTheme.primaryText.withValues(alpha: 0.8),
                  ),
                )
                .animate()
                .fadeIn(delay: 600.ms, duration: 600.ms)
                .slideX(begin: -0.2, end: 0),

            const SizedBox(height: 48),

            /// Buttons
            Wrap(
                  spacing: 20,
                  runSpacing: 20,
                  children: [
                    ElevatedButton(
                      onPressed: () => context.go('/projects'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 20,
                        ),
                      ),
                      child: const Text('View Projects'),
                    ),
                    OutlinedButton(
                      onPressed: () {
                        // TODO: Add resume link
                      },
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 20,
                        ),
                        side: const BorderSide(color: AppTheme.accentColor),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        foregroundColor: AppTheme.accentColor,
                      ),
                      child: const Text('Download Resume'),
                    ),
                  ],
                )
                .animate()
                .fadeIn(delay: 800.ms, duration: 600.ms)
                .slideY(begin: 0.2, end: 0),

            const SizedBox(height: 80),

            /// Social Links
            _buildSocialLinks().animate().fadeIn(
              delay: 1000.ms,
              duration: 600.ms,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialLinks() {
    return Row(
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

/// SOCIAL ICON WIDGET
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
          transform: Matrix4.diagonal3Values(
            _isHovered ? 1.2 : 1.0,
            _isHovered ? 1.2 : 1.0,
            1.0,
          ),
          child: FaIcon(
            widget.icon,
            color: _isHovered ? AppTheme.accentColor : AppTheme.secondaryText,
            size: 28,
          ),
        ),
      ),
    );
  }
}
