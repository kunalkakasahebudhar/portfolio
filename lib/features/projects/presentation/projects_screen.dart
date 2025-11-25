import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:portfolio/core/theme/theme.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProjectsScreen extends StatelessWidget {
  const ProjectsScreen({super.key});

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
              'Projects',
              style: Theme.of(context).textTheme.displayMedium,
            ).animate().fadeIn().slideX(),
            const SizedBox(height: 40),
            Wrap(
              spacing: 24,
              runSpacing: 24,
              children: [
                _ProjectCard(
                  title: 'E-Commerce App',
                  description:
                      'A full-featured shopping app with cart, payment integration, and order tracking.',
                  techStack: const ['Flutter', 'Firebase', 'Stripe'],
                  color: Colors.blueAccent,
                  width: isDesktop
                      ? (size.width * 0.8 - 48) / 3
                      : double.infinity,
                  delay: 200,
                ),
                _ProjectCard(
                  title: 'Task Manager',
                  description:
                      'Productivity app for managing daily tasks with reminders and categories.',
                  techStack: const ['Flutter', 'Hive', 'Riverpod'],
                  color: Colors.purpleAccent,
                  width: isDesktop
                      ? (size.width * 0.8 - 48) / 3
                      : double.infinity,
                  delay: 400,
                ),
                _ProjectCard(
                  title: 'Weather Forecast',
                  description:
                      'Real-time weather updates using OpenWeatherMap API with beautiful animations.',
                  techStack: const ['Flutter', 'REST API', 'Bloc'],
                  color: Colors.orangeAccent,
                  width: isDesktop
                      ? (size.width * 0.8 - 48) / 3
                      : double.infinity,
                  delay: 600,
                ),
                _ProjectCard(
                  title: 'Social Media Dashboard',
                  description:
                      'Analytics dashboard for social media accounts with charts and graphs.',
                  techStack: const ['Flutter Web', 'Chart.js', 'Go'],
                  color: Colors.tealAccent,
                  width: isDesktop
                      ? (size.width * 0.8 - 48) / 3
                      : double.infinity,
                  delay: 800,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ProjectCard extends StatefulWidget {
  final String title;
  final String description;
  final List<String> techStack;
  final Color color;
  final double width;
  final int delay;

  const _ProjectCard({
    required this.title,
    required this.description,
    required this.techStack,
    required this.color,
    required this.width,
    required this.delay,
  });

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: widget.width,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppTheme.cardColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _isHovered
                ? widget.color
                : Colors.white.withValues(alpha: 0.05),
            width: _isHovered ? 2 : 1,
          ),
          boxShadow: [
            if (_isHovered)
              BoxShadow(
                color: widget.color.withValues(alpha: 0.2),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
          ],
        ),
        transform: Matrix4.identity()
          ..setTranslationRaw(0.0, _isHovered ? -10.0 : 0.0, 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 160,
              decoration: BoxDecoration(
                color: widget.color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Icon(Icons.folder_open, size: 64, color: widget.color),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              widget.title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppTheme.primaryText,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              widget.description,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(height: 1.5),
            ),
            const SizedBox(height: 24),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: widget.techStack
                  .map(
                    (tech) => Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppTheme.background,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        tech,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppTheme.secondaryText,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                // TODO: Add GitHub link
              },
              icon: const FaIcon(FontAwesomeIcons.github, size: 16),
              label: const Text('View on GitHub'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.background,
                foregroundColor: AppTheme.primaryText,
                elevation: 0,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(delay: widget.delay.ms).slideY(begin: 0.2, end: 0);
  }
}
