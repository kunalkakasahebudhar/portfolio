import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:portfolio/core/theme/theme.dart';

class SkillsScreen extends StatelessWidget {
  const SkillsScreen({super.key});

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
              'Skills',
              style: Theme.of(context).textTheme.displayMedium,
            ).animate().fadeIn().slideX(),
            const SizedBox(height: 40),
            _buildSkillCategory(context, 'Mobile Development', [
              'Flutter',
              'Dart',
              'Android Development',
              'Mobile App Development',
            ], delay: 200),
            const SizedBox(height: 32),
            _buildSkillCategory(context, 'Backend & Database', [
              'MongoDB',
              'Go (Golang - Learning)',
              'REST APIs',
            ], delay: 400),
            const SizedBox(height: 32),
            _buildSkillCategory(context, 'Tools & Concepts', [
              'Postman (API Testing)',
              'UI/UX Implementation',
              'State Management',
              'Git',
              'Clean Architecture',
            ], delay: 600),
          ],
        ),
      ),
    );
  }

  Widget _buildSkillCategory(
    BuildContext context,
    String title,
    List<String> skills, {
    required int delay,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: AppTheme.accentColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: skills.map((skill) => _SkillChip(label: skill)).toList(),
        ),
      ],
    ).animate().fadeIn(delay: delay.ms).slideY(begin: 0.2, end: 0);
  }
}

class _SkillChip extends StatelessWidget {
  final String label;

  const _SkillChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: AppTheme.cardColor,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: AppTheme.primaryText,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
