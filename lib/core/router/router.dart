import 'package:go_router/go_router.dart';
import 'package:portfolio/features/home/presentation/home_screen.dart';
import 'package:portfolio/features/about/presentation/about_screen.dart';
import 'package:portfolio/features/skills/presentation/skills_screen.dart';
import 'package:portfolio/features/experience/presentation/experience_screen.dart';
import 'package:portfolio/features/projects/presentation/projects_screen.dart';
import 'package:portfolio/features/contact/presentation/contact_screen.dart';
import 'package:portfolio/shared/widgets/main_layout.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return MainLayout(child: child);
      },
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: '/about',
          builder: (context, state) => const AboutScreen(),
        ),
        GoRoute(
          path: '/skills',
          builder: (context, state) => const SkillsScreen(),
        ),
        GoRoute(
          path: '/experience',
          builder: (context, state) => const ExperienceScreen(),
        ),
        GoRoute(
          path: '/projects',
          builder: (context, state) => const ProjectsScreen(),
        ),
        GoRoute(
          path: '/contact',
          builder: (context, state) => const ContactScreen(),
        ),
      ],
    ),
  ],
);
