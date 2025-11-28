import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:portfolio/core/theme/theme.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectsScreen extends StatefulWidget {
  const ProjectsScreen({super.key});

  @override
  State<ProjectsScreen> createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen> {
  String _selectedCategory = 'All Projects';

  final List<String> _categories = [
    'All Projects',
    'Personal Projects',
    'Website',
  ];

  final List<Project> _projects = [
    Project(
      title: 'Expense Tracker App',
      description:
          'A personal finance app to track expenses and income efficiently.',
      techStack: const ['Flutter', 'Hive', 'Riverpod'],
      color: Colors.purpleAccent,
      category: 'Personal Projects',
      status: 'Completed',
      githubUrl:
          'https://github.com/kunalkakasahebudhar/Expense-Tracker-App.git',
      liveUrl: null,
      delay: 200,
    ),
    Project(
      title: 'E-Commerce App',
      description:
          'A complete e-commerce solution for online shopping with cart and payment.',
      techStack: const ['Flutter', 'Provider'],
      color: Colors.blueAccent,
      category: 'Personal Projects',
      status: 'Completed',
      githubUrl: 'https://github.com/kunalkakasahebudhar/E-Commerce-app.git',
      liveUrl: null,
      delay: 400,
    ),
    Project(
      title: 'Portfolio Website',
      description:
          'Personal portfolio website showcasing skills, projects, and experience.',
      techStack: const ['Flutter Web', 'Responsive Design', 'Go (Backend)'],
      color: Colors.tealAccent,
      category: 'Personal Projects',
      status: 'Completed',
      githubUrl: 'https://github.com/kunalkakasahebudhar/portfolio.git',
      liveUrl: null,
      delay: 600,
    ),
    Project(
      title: 'BloodConnect',
      description:
          'A platform connecting blood donors with those in need during emergencies.',
      techStack: const ['Flutter', 'Firebase', 'Google Maps'],
      color: Colors.redAccent,
      category: 'Personal Projects',
      status: 'Pending',
      githubUrl: null,
      liveUrl: null,
      delay: 800,
    ),
    Project(
      title: 'Web Hosting',
      description: 'A demo website for web hosting services.',
      techStack: const ['Html', 'CSS', 'JavaScript'],
      color: Colors.indigoAccent,
      category: 'Website',
      status: 'Completed',
      githubUrl: 'https://github.com/kunalkakasahebudhar/web_hosting.git',
      liveUrl: 'https://ecommerce-website-kappa-ecru.vercel.app',
      delay: 1000,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 900;

    final filteredProjects = _selectedCategory == 'All Projects'
        ? _projects
        : _projects
              .where((project) => project.category == _selectedCategory)
              .toList();

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
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _categories.map((category) {
                  final isSelected = _selectedCategory == category;
                  return Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: InkWell(
                      onTap: () => setState(() => _selectedCategory = category),
                      borderRadius: BorderRadius.circular(30),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppTheme.accentColor
                              : AppTheme.cardColor,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            color: isSelected
                                ? AppTheme.accentColor
                                : Colors.white.withValues(alpha: 0.1),
                          ),
                        ),
                        child: Text(
                          category,
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(
                                color: isSelected
                                    ? Colors.white
                                    : AppTheme.secondaryText,
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ).animate().fadeIn(delay: 100.ms).slideX(),
            const SizedBox(height: 40),
            Wrap(
              spacing: 24,
              runSpacing: 24,
              children: filteredProjects.map((project) {
                return _ProjectCard(
                  title: project.title,
                  description: project.description,
                  techStack: project.techStack,
                  color: project.color,
                  status: project.status,
                  githubUrl: project.githubUrl,
                  liveUrl: project.liveUrl,
                  width: isDesktop
                      ? (size.width * 0.8 - 48) / 3
                      : double.infinity,
                  delay: project.delay,
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class Project {
  final String title;
  final String description;
  final List<String> techStack;
  final Color color;
  final String category;
  final String status;
  final String? githubUrl;
  final String? liveUrl;
  final int delay;

  Project({
    required this.title,
    required this.description,
    required this.techStack,
    required this.color,
    required this.category,
    required this.status,
    required this.githubUrl,
    required this.liveUrl,
    required this.delay,
  });
}

class _ProjectCard extends StatefulWidget {
  final String title;
  final String description;
  final List<String> techStack;
  final Color color;
  final String status;
  final String? githubUrl;
  final String? liveUrl;
  final double width;
  final int delay;

  const _ProjectCard({
    required this.title,
    required this.description,
    required this.techStack,
    required this.color,
    required this.status,
    required this.githubUrl,
    required this.liveUrl,
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
            width: 2,
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
              child: Stack(
                children: [
                  Center(
                    child: Icon(
                      Icons.folder_open,
                      size: 64,
                      color: widget.color,
                    ),
                  ),
                  Positioned(
                    top: 12,
                    right: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.1),
                        ),
                      ),
                      child: Text(
                        widget.status,
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ),
                ],
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
            Row(
              children: [
                if (widget.githubUrl != null)
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        if (!await launchUrl(Uri.parse(widget.githubUrl!))) {
                          throw Exception(
                            'Could not launch ${widget.githubUrl}',
                          );
                        }
                      },
                      icon: const FaIcon(FontAwesomeIcons.github, size: 16),
                      label: const Text('GitHub'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.background,
                        foregroundColor: AppTheme.primaryText,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                    ),
                  )
                else
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: null,
                      icon: const Icon(Icons.lock_outline, size: 16),
                      label: const Text('Private'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.background.withValues(
                          alpha: 0.5,
                        ),
                        foregroundColor: AppTheme.secondaryText,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ),
                if (widget.liveUrl != null) ...[
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        if (!await launchUrl(Uri.parse(widget.liveUrl!))) {
                          throw Exception('Could not launch ${widget.liveUrl}');
                        }
                      },
                      icon: const Icon(Icons.language, size: 16),
                      label: const Text('Live'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.accentColor.withValues(
                          alpha: 0.1,
                        ),
                        foregroundColor: AppTheme.accentColor,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    ).animate().fadeIn(delay: widget.delay.ms).slideY(begin: 0.2, end: 0);
  }
}
