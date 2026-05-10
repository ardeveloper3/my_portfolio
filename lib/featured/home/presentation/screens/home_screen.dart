// lib/featured/home/presentation/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/provider/scroll_provider.dart';
import '../../../../shared/widget/navbar.dart';
import '../../../../shared/widget/footer.dart';
import '../../../about/prsentation/screens/about_section.dart';
import '../../../hero/presentation/screens/hero_section.dart';
import '../../../skill/presentation/screens/skill_section.dart';
import '../../../projects/presentation/screens/project_section.dart';
import '../../../exprience/presentation/screens/exprience_secton.dart';
import '../../../contact/presentation/screens/contact_section.dart';
import '_back_to_top_button.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initScrollListener();
    });
  }

  void _initScrollListener() {
    final scrollController = ref.read(scrollControllerProvider);
    scrollController.addListener(() {
      final offset = scrollController.offset;

      // Navbar blur
      ref.read(navbarScrolledProvider.notifier).state = offset > 50;

      // Update scroll position
      ref.read(scrollPositionProvider.notifier).state = offset;

      // Update active nav
      _updateActiveNav(offset);
    });
  }

  void _updateActiveNav(double offset) {
    final sectionKeys = ref.read(sectionKeysProvider);
    final keys = sectionKeys.values.toList();
    for (int i = keys.length - 1; i >= 0; i--) {
      final ctx = keys[i].currentContext;
      if (ctx != null) {
        final box = ctx.findRenderObject() as RenderBox?;
        if (box != null) {
          final position = box.localToGlobal(Offset.zero);
          if (position.dy <= 100) {
            ref.read(activeNavIndexProvider.notifier).state = i;
            break;
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final scrollController = ref.watch(scrollControllerProvider);
    final sectionKeys = ref.watch(sectionKeysProvider);
    final keyList = sectionKeys.values.toList();

    return Scaffold(
      body: Stack(
        children: [
          // Main scroll view
          SingleChildScrollView(
            controller: scrollController,
            child: Column(
              children: [
                // Hero
                KeyedSubtree(
                  key: keyList[0],
                  child: const HeroSection(),
                ),

                // About
                KeyedSubtree(
                  key: keyList[1],
                  child: const AboutSection(),
                ),

                // Skills
                KeyedSubtree(
                  key: keyList[2],
                  child: SkillsSection(),
                ),

                // Projects
                KeyedSubtree(
                  key: keyList[3],
                  child: const ProjectsSection(),
                ),

                // Experience
                KeyedSubtree(
                  key: keyList[4],
                  child: const ExperienceSection(),
                ),

                // Contact
                KeyedSubtree(
                  key: keyList[5],
                  child: const ContactSection(),
                ),

                // Footer
                const PortfolioFooter(),
              ],
            ),
          ),

          // Sticky navbar
          const Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: PortfolioNavbar(),
          ),

          // Back to top
          const Positioned(
            bottom: 32,
            right: 32,
            child: BackToTopButton(),
          ),
        ],
      ),
    );
  }
}
