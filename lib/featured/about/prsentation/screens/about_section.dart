// lib/featured/about/prsentation/screens/about_section.dart
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../../../../core/constance/app_constance.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../shared/widget/glass_card.dart';
import '../../../../shared/widget/glow_button.dart';
import '../../../../shared/widget/section_header.dart';

class AboutSection extends StatefulWidget {
  const AboutSection({super.key});

  @override
  State<AboutSection> createState() => _AboutSectionState();
}

class _AboutSectionState extends State<AboutSection> {
  bool _visible = false;

  @override
  Widget build(BuildContext context) {
    final isMobile =
        MediaQuery.of(context).size.width < AppSizes.tabletBreakpoint;

    return VisibilityDetector(
      key: const Key('about-section'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.2 && !_visible) {
          setState(() => _visible = true);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: AppSizes.sectionPaddingV,
          horizontal: AppSizes.sectionPaddingH,
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: AppSizes.maxWidth),
            child: Column(
              children: [
                const SectionHeader(
                  label: 'About Me',
                  title: 'Who I Am',
                  subtitle:
                      'A passionate developer who turns complex problems into elegant digital solutions.',
                ),
                const SizedBox(height: 64),
                isMobile
                    ? _MobileAboutLayout(visible: _visible)
                    : _DesktopAboutLayout(visible: _visible),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DesktopAboutLayout extends StatelessWidget {
  final bool visible;
  const _DesktopAboutLayout({required this.visible});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 5, child: _AboutText(visible: visible)),
        const SizedBox(width: 48),
        Expanded(flex: 4, child: _StatsGrid(visible: visible)),
      ],
    );
  }
}

class _MobileAboutLayout extends StatelessWidget {
  final bool visible;
  const _MobileAboutLayout({required this.visible});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _AboutText(visible: visible),
        const SizedBox(height: 40),
        _StatsGrid(visible: visible),
      ],
    );
  }
}

class _AboutText extends StatelessWidget {
  final bool visible;
  const _AboutText({required this.visible});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedOpacity(
          opacity: visible ? 1 : 0,
          duration: const Duration(milliseconds: 600),
          child: AnimatedSlide(
            offset: visible ? Offset.zero : const Offset(-0.2, 0),
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeOut,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "I'm a software developer who specializes in building exceptional "
                  "digital experiences. Currently focused on building accessible, "
                  "human-centered products.",
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge!.copyWith(fontSize: 18),
                ),
                const SizedBox(height: 20),
                Text(
                  "When I'm not coding, I'm designing game worlds, contributing to open-source, "
                  "or exploring new technologies. I believe in clean code, clean architecture, "
                  "and making technology work for people.",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 32),
                // Timeline / journey highlights
                ..._journeyItems.map(
                  (item) => _JourneyItem(
                    year: item.$1,
                    title: item.$2,
                    subtitle: item.$3,
                  ),
                ),
                const SizedBox(height: 32),
                GlowButton(
                  label: 'Download CV',
                  icon: Icons.download_rounded,
                  variant: GlowButtonVariant.outlined,
                  onTap: () {},
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  static const List<(String, String, String)> _journeyItems = [
    (
      '2020',
      'Started Flutter Development',
      'Fell in love with cross-platform mobile dev',
    ),
    (
      '2021',
      'Backend Expansion',
      'Mastered Node.js, REST APIs, and JWT security',
    ),
    (
      '2022',
      'Game Development',
      'Dived into Flutter Flame and C++ game engines',
    ),
    (
      '2024',
      'Full-Stack Mastery',
      'Serverpod, Docker, Redis, and cloud deployment',
    ),
  ];
}

class _JourneyItem extends StatelessWidget {
  final String year;
  final String title;
  final String subtitle;

  const _JourneyItem({
    required this.year,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Year badge
          Container(
            width: 56,
            padding: const EdgeInsets.symmetric(vertical: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: AppColors.cyan.withValues(alpha: 0.1),
              border: Border.all(color: AppColors.cyan.withValues(alpha: 0.3)),
            ),
            child: Text(
              year,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: AppColors.cyan,
              ),
            ),
          ),
          const SizedBox(width: 16),
          // Connector
          Column(
            children: [
              const SizedBox(height: 8),
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.cyan,
                  boxShadow: [BoxShadow(color: AppColors.cyan, blurRadius: 6)],
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatsGrid extends StatelessWidget {
  final bool visible;
  const _StatsGrid({required this.visible});

  static const _stats = [
    ('4+', 'Years of\nExperience', AppColors.cyan),
    ('20+', 'Projects\nCompleted', AppColors.purple),
    ('10+', 'Happy\nClients', AppColors.pink),
    ('5+', 'Open Source\nContributions', AppColors.cyan),
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 1.2,
      children: _stats.asMap().entries.map((e) {
        return AnimatedOpacity(
          opacity: visible ? 1 : 0,
          duration: Duration(milliseconds: 600 + e.key * 100),
          child: GlassCard(
            glowColor: e.value.$3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ShaderMask(
                  shaderCallback: (b) => LinearGradient(
                    colors: [e.value.$3, AppColors.purple],
                  ).createShader(b),
                  child: Text(
                    e.value.$1,
                    style: const TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Expanded(
                  child: Text(
                    e.value.$2,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.textSecondary,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
