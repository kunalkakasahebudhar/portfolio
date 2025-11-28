import 'package:flutter/material.dart';
import 'package:portfolio/features/about/presentation/about_screen.dart';
import 'package:portfolio/features/contact/presentation/contact_screen.dart';
import 'package:portfolio/features/experience/presentation/experience_screen.dart';
import 'package:portfolio/features/home/presentation/home_screen.dart';
import 'package:portfolio/features/projects/presentation/projects_screen.dart';
import 'package:portfolio/features/skills/presentation/skills_screen.dart';
import 'package:portfolio/shared/widgets/top_navigation_bar.dart';
import 'package:portfolio/shared/widgets/mobile_app_bar.dart';
import 'package:portfolio/shared/widgets/mobile_drawer.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _homeKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _skillsKey = GlobalKey();
  final GlobalKey _experienceKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 800;

    return Scaffold(
      appBar: isDesktop ? null : const MobileAppBar(),
      drawer: isDesktop
          ? null
          : MobileDrawer(
              onNavTap: (index) {
                switch (index) {
                  case 0:
                    _scrollToSection(_homeKey);
                    break;
                  case 1:
                    _scrollToSection(_aboutKey);
                    break;
                  case 2:
                    _scrollToSection(_skillsKey);
                    break;
                  case 3:
                    _scrollToSection(_experienceKey);
                    break;
                  case 4:
                    _scrollToSection(_projectsKey);
                    break;
                  case 5:
                    _scrollToSection(_contactKey);
                    break;
                }
              },
            ),
      body: Column(
        children: [
          if (isDesktop)
            TopNavigationBar(
              onNavTap: (index) {
                switch (index) {
                  case 0:
                    _scrollToSection(_homeKey);
                    break;
                  case 1:
                    _scrollToSection(_aboutKey);
                    break;
                  case 2:
                    _scrollToSection(_skillsKey);
                    break;
                  case 3:
                    _scrollToSection(_experienceKey);
                    break;
                  case 4:
                    _scrollToSection(_projectsKey);
                    break;
                  case 5:
                    _scrollToSection(_contactKey);
                    break;
                }
              },
            ),
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  HomeScreen(
                    key: _homeKey,
                    onViewProjects: () => _scrollToSection(_projectsKey),
                  ),
                  AboutScreen(key: _aboutKey),
                  SkillsScreen(key: _skillsKey),
                  ExperienceScreen(key: _experienceKey),
                  ProjectsScreen(key: _projectsKey),
                  ContactScreen(key: _contactKey),
                  const SizedBox(height: 50), // Bottom padding
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
