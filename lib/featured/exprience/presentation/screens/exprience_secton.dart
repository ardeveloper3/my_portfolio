// lib/features/experience/presentation/screens/experience_section.dart
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/constance/app_constance.dart';
import '../../../../shared/widget/section_header.dart';
import '../../../../shared/widget/glass_card.dart';

class ExperienceSection extends StatefulWidget {
  const ExperienceSection({super.key});

  @override
  State<ExperienceSection> createState() => _ExperienceSectionState();
}

class _ExperienceSectionState extends State<ExperienceSection> {
  bool _visible = false;

  static const _experiences = [
    _Experience(
      period: '2024 – Present',
      role: 'Senior Flutter Developer',
      company: 'Freelance / Independent',
      description:
      'Building production-grade mobile apps and backend systems for international clients. '
          'Specializing in complex state management, real-time features, and performance optimization.',
      tags: ['Flutter', 'Serverpod', 'Docker', 'Redis'],
      icon: '🚀',
      isCurrent: true,
    ),
    _Experience(
      period: '2022 – 2024',
      role: 'Flutter & Backend Developer',
      company: 'Tech Startup',
      description:
      'Led development of a school management platform serving 5000+ users. '
          'Built JWT auth backend, notification system, and CI/CD pipeline.',
      tags: ['Flutter', 'Node.js', 'Firebase', 'JWT'],
      icon: '💼',
      isCurrent: false,
    ),
    _Experience(
      period: '2021 – 2022',
      role: 'Mobile Developer',
      company: 'Software Agency',
      description:
      'Developed 10+ Flutter apps for clients across education, ecommerce, and health sectors. '
          'Implemented clean architecture patterns and RESTful API integrations.',
      tags: ['Flutter', 'REST API', 'Firebase'],
      icon: '📱',
      isCurrent: false,
    ),
    _Experience(
      period: '2020 – 2021',
      role: 'Junior Flutter Developer',
      company: 'Self-taught / Open Source',
      description:
      'Started Flutter journey. Built personal projects, contributed to open source packages, '
          'and developed foundational skills in Dart, state management, and UI design.',
      tags: ['Flutter', 'Dart', 'UI/UX'],
      icon: '🌱',
      isCurrent: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: const Key('experience-section'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.1 && !_visible) {
          setState(() => _visible = true);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.bgPrimary,
              AppColors.bgSecondary.withValues(alpha: 0.3),
              AppColors.bgPrimary,
            ],
          ),
        ),
        padding: const EdgeInsets.symmetric(
          vertical: AppSizes.sectionPaddingV,
          horizontal: AppSizes.sectionPaddingH,
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Column(
              children: [
                const SectionHeader(
                  label: 'Journey',
                  title: 'My Experience',
                  subtitle: 'The path that shaped me as a developer.',
                ),
                const SizedBox(height: 64),
                ..._experiences.asMap().entries.map((e) {
                  return _TimelineItem(
                    experience: e.value,
                    index: e.key,
                    isLast: e.key == _experiences.length - 1,
                    visible: _visible,
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Experience {
  final String period;
  final String role;
  final String company;
  final String description;
  final List<String> tags;
  final String icon;
  final bool isCurrent;

  const _Experience({
    required this.period,
    required this.role,
    required this.company,
    required this.description,
    required this.tags,
    required this.icon,
    required this.isCurrent,
  });
}

class _TimelineItem extends StatelessWidget {
  final _Experience experience;
  final int index;
  final bool isLast;
  final bool visible;

  const _TimelineItem({
    required this.experience,
    required this.index,
    required this.isLast,
    required this.visible,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: visible ? 1 : 0,
      duration: Duration(milliseconds: 600 + index * 150),
      child: AnimatedSlide(
        offset: visible ? Offset.zero : const Offset(0.1, 0),
        duration: Duration(milliseconds: 600 + index * 150),
        curve: Curves.easeOut,
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Timeline column
              SizedBox(
                width: 60,
                child: Column(
                  children: [
                    // Dot
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: experience.isCurrent
                            ? AppColors.cyan.withValues(alpha: 0.15)
                            : AppColors.bgCard,
                        border: Border.all(
                          color: experience.isCurrent
                              ? AppColors.cyan
                              : AppColors.borderGlass,
                          width: experience.isCurrent ? 2 : 1,
                        ),
                        boxShadow: experience.isCurrent
                            ? [
                          BoxShadow(
                            color: AppColors.cyan.withValues(alpha: 0.3),
                            blurRadius: 12,
                          )
                        ]
                            : null,
                      ),
                      child: Center(
                        child: Text(
                          experience.icon,
                          style: const TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                    // Line
                    if (!isLast)
                      Expanded(
                        child: Container(
                          width: 1,
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                AppColors.cyan.withValues(alpha: 0.3),
                                AppColors.borderGlass,
                              ],
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),

              const SizedBox(width: 20),

              // Content
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(bottom: isLast ? 0 : 32),
                  child: GlassCard(
                    glowColor: experience.isCurrent ? AppColors.cyan : null,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (experience.isCurrent)
                                    Container(
                                      margin: const EdgeInsets.only(bottom: 8),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 3),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        color: AppColors.cyan.withValues(alpha: 0.1),
                                        border: Border.all(
                                          color: AppColors.cyan.withValues(alpha: 0.4),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Container(
                                            width: 6,
                                            height: 6,
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: AppColors.cyan,
                                            ),
                                          ),
                                          const SizedBox(width: 6),
                                          const Text(
                                            'Current',
                                            style: TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.w600,
                                              color: AppColors.cyan,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  Text(
                                    experience.role,
                                    style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    experience.company,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: AppColors.cyan,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: AppColors.bgPrimary,
                                border: Border.all(color: AppColors.borderSubtle),
                              ),
                              child: Text(
                                experience.period,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: AppColors.textMuted,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          experience.description,
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppColors.textSecondary,
                            height: 1.6,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 6,
                          runSpacing: 6,
                          children: experience.tags.map((tag) {
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 3),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: AppColors.purple.withValues(alpha: 0.08),
                                border: Border.all(
                                    color: AppColors.purple.withValues(alpha: 0.3)),
                              ),
                              child: Text(
                                tag,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: AppColors.purple,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
