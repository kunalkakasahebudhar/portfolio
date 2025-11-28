import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/core/theme/theme.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class MobileDrawer extends StatelessWidget {
  final Function(int) onNavTap;

  const MobileDrawer({super.key, required this.onNavTap});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppTheme.background,
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: AppTheme.cardColor,
              border: Border(
                bottom: BorderSide(color: Colors.white.withValues(alpha: 0.05)),
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppTheme.accentColor.withValues(alpha: 0.5),
                        width: 2,
                      ),
                    ),
                    child: const Icon(
                      Icons.code,
                      size: 40,
                      color: AppTheme.accentColor,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Kunal Udhar',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          _DrawerItem(
            icon: Icons.home_outlined,
            label: 'Home',
            onTap: () {
              Navigator.pop(context);
              onNavTap(0);
            },
          ),
          _DrawerItem(
            icon: Icons.person_outline,
            label: 'About',
            onTap: () {
              Navigator.pop(context);
              onNavTap(1);
            },
          ),
          _DrawerItem(
            icon: Icons.code,
            label: 'Skills',
            onTap: () {
              Navigator.pop(context);
              onNavTap(2);
            },
          ),
          _DrawerItem(
            icon: Icons.work_outline,
            label: 'Experience',
            onTap: () {
              Navigator.pop(context);
              onNavTap(3);
            },
          ),
          _DrawerItem(
            icon: Icons.folder_open,
            label: 'Projects',
            onTap: () {
              Navigator.pop(context);
              onNavTap(4);
            },
          ),
          _DrawerItem(
            icon: Icons.mail_outline,
            label: 'Contact',
            onTap: () {
              Navigator.pop(context);
              onNavTap(5);
            },
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _DrawerSocialIcon(
                  icon: FontAwesomeIcons.github,
                  onTap: () =>
                      _launchUrl('https://github.com/kunalkakasahebudhar'),
                ),
                _DrawerSocialIcon(
                  icon: FontAwesomeIcons.linkedin,
                  onTap: () => _launchUrl(
                    'https://www.linkedin.com/in/kunal-udhar-99a6ba32b/',
                  ),
                ),
                _DrawerSocialIcon(
                  icon: FontAwesomeIcons.envelope,
                  onTap: () => _launchUrl('mailto:kudhar892@gmail.com'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }
}

class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _DrawerItem({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: AppTheme.secondaryText),
      title: Text(
        label,
        style: GoogleFonts.inter(
          color: AppTheme.primaryText,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
      hoverColor: Colors.white.withValues(alpha: 0.05),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    );
  }
}

class _DrawerSocialIcon extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _DrawerSocialIcon({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      icon: FaIcon(icon, size: 20, color: AppTheme.secondaryText),
      style: IconButton.styleFrom(
        backgroundColor: AppTheme.cardColor,
        padding: const EdgeInsets.all(12),
      ),
    );
  }
}
