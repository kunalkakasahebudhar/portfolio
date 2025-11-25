import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/core/theme/theme.dart';
import 'package:url_launcher/url_launcher.dart';

class TopNavigationBar extends StatelessWidget {
  final Function(int) onNavTap;

  const TopNavigationBar({super.key, required this.onNavTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 40),
      decoration: BoxDecoration(
        color: AppTheme.background.withValues(alpha: 0.8),
        border: Border(
          bottom: BorderSide(
            color: Colors.white.withValues(alpha: 0.05),
            width: 1,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Logo
          Text(
            'Kunal Udhar',
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppTheme.accentColor,
            ),
          ),
          const Spacer(),
          // Navigation Items
          Row(
            children: [
              _NavBarItem(label: 'Home', onTap: () => onNavTap(0)),
              const SizedBox(width: 8),
              _NavBarItem(label: 'About', onTap: () => onNavTap(1)),
              const SizedBox(width: 8),
              _NavBarItem(label: 'Skills', onTap: () => onNavTap(2)),
              const SizedBox(width: 8),
              _NavBarItem(label: 'Experience', onTap: () => onNavTap(3)),
              const SizedBox(width: 8),
              _NavBarItem(label: 'Projects', onTap: () => onNavTap(4)),
              const SizedBox(width: 8),
              _NavBarItem(label: 'Contact', onTap: () => onNavTap(5)),
            ],
          ),
          const Spacer(),
          // Right Side Actions
          ElevatedButton(
            onPressed: () => _launchUrl('mailto:kudhar892@gmail.com'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.accentColor,
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: const Text('Hire Me'),
          ),
          const SizedBox(width: 16),
          IconButton(
            onPressed: () {
              // TODO: Implement settings
            },
            icon: const Icon(
              Icons.settings_outlined,
              color: AppTheme.secondaryText,
            ),
          ),
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

class _NavBarItem extends StatefulWidget {
  final String label;
  final VoidCallback onTap;

  const _NavBarItem({required this.label, required this.onTap});

  @override
  State<_NavBarItem> createState() => _NavBarItemState();
}

class _NavBarItemState extends State<_NavBarItem> {
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
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: _isHovered
                ? Colors.white.withValues(alpha: 0.05)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            widget.label,
            style: GoogleFonts.inter(
              color: _isHovered ? AppTheme.primaryText : AppTheme.secondaryText,
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}
