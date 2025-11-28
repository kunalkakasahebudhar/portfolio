import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

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
          horizontal: isDesktop ? size.width * 0.1 : 24,
          vertical: 60,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'About Me',
              style: Theme.of(context).textTheme.displayMedium,
            ).animate().fadeIn().slideX(),
            const SizedBox(height: 40),
            if (isDesktop)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 2, child: _buildBio(context)),
                  const SizedBox(width: 60),
                  Expanded(flex: 1, child: _buildProfileImage()),
                ],
              )
            else
              Column(
                children: [
                  _buildProfileImage(),
                  const SizedBox(height: 40),
                  _buildBio(context),
                ],
              ),
            const SizedBox(height: 60),
            _buildInfoCards(context, isDesktop),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileImage() {
    return Container(
      width: 300,
      height: 300,
      decoration: BoxDecoration(
        color: AppTheme.cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
        border: Border.all(color: AppTheme.accentColor.withValues(alpha: 0.2)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.asset('assets/images/profile_pic.png', fit: BoxFit.cover),
      ),
    ).animate().fadeIn(delay: 200.ms).scale();
  }

  Widget _buildBio(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "I'm a Junior Flutter Developer focused on building smooth, high-performance mobile apps. Skilled in Dart, Flutter, UI/UX, API integration, and REST architecture.",
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.6),
        ),
        const SizedBox(height: 20),
        Text(
          "I convert ideas into scalable, user-friendly applications. Currently learning State Management, Backend Connectivity, and Golang. My goal is to create meaningful projects that provide real value to users.",
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.6),
        ),
      ],
    ).animate().fadeIn(delay: 400.ms).slideX();
  }

  Widget _buildInfoCards(BuildContext context, bool isDesktop) {
    return Wrap(
      spacing: 24,
      runSpacing: 24,
      children: [
        _InfoCard(
          title: 'Experience',
          icon: Icons.work_outline,
          items: const [
            'Junior Flutter Developer At MHTECHIN',
            'Android Developer Intern At MHTECHIN',
          ],
          width: isDesktop ? 400 : double.infinity,
        ),
        _InfoCard(
          title: 'Education',
          icon: Icons.school_outlined,
          items: const [
            'Polytechnic Diploma in Computer Science',
            'Certified Flutter Developer',
          ],
          width: isDesktop ? 400 : double.infinity,
        ),
      ],
    ).animate().fadeIn(delay: 600.ms).slideY(begin: 0.2, end: 0);
  }
}

class _InfoCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<String> items;
  final double width;

  const _InfoCard({
    required this.title,
    required this.icon,
    required this.items,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppTheme.cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: AppTheme.accentColor),
              const SizedBox(width: 12),
              Text(
                title,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppTheme.primaryText,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ...items.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                children: [
                  const Icon(Icons.arrow_right, color: AppTheme.secondaryText),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      item,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
