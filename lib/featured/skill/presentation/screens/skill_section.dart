// lib/featured/skill/presentation/screens/skill_section.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/constance/app_constance.dart';
import '../../../../shared/widget/section_header.dart';
import '../../../../shared/widget/glass_card.dart';
import '../../provider/skill_provider.dart';

class SkillsSection extends ConsumerStatefulWidget {
  const SkillsSection({super.key});

  @override
  ConsumerState<SkillsSection> createState() => _SkillsSectionState();
}

class _SkillsSectionState extends ConsumerState<SkillsSection> {
  bool _visible = false;

  @override
  Widget build(BuildContext context) {
    final skills = ref.watch(filteredSkillsProvider);
    final categories = ref.watch(skillCategoriesProvider);
    final activeCategory = ref.watch(skillCategoryProvider);
    final isMobile = MediaQuery.of(context).size.width < AppSizes.mobileBreakpoint;

    return VisibilityDetector(
      key: const Key('skills-section'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.15 && !_visible) {
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
              AppColors.bgSecondary.withValues(alpha: 0.5),
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
            constraints: const BoxConstraints(maxWidth: AppSizes.maxWidth),
            child: Column(
              children: [
                const SectionHeader(
                  label: 'My Skills',
                  title: 'Technical Expertise',
                  subtitle: 'Technologies and tools I use to build exceptional products.',
                ),
                const SizedBox(height: 48),

                // Filter tabs
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  alignment: WrapAlignment.center,
                  children: categories.map((cat) {
                    final isActive = activeCategory == cat;
                    return _FilterChip(
                      label: cat,
                      isActive: isActive,
                      onTap: () => ref.read(skillCategoryProvider.notifier).state = cat,
                    );
                  }).toList(),
                ),

                const SizedBox(height: 48),

                // Skills grid
                LayoutBuilder(
                  builder: (_, constraints) {
                    final crossAxis = constraints.maxWidth > 700 ? 2 : 1;
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxis,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: crossAxis == 2 ? 3.5 : 4,
                      ),
                      itemCount: skills.length,
                      itemBuilder: (_, i) => _SkillCard(
                        skill: skills[i],
                        index: i,
                        animate: _visible,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _FilterChip extends StatefulWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _FilterChip({required this.label, required this.isActive, required this.onTap});

  @override
  State<_FilterChip> createState() => _FilterChipState();
}

class _FilterChipState extends State<_FilterChip> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            gradient: widget.isActive ? AppColors.cyanPurpleGradient : null,
            border: Border.all(
              color: widget.isActive || _hovered
                  ? AppColors.cyan.withValues(alpha: 0.6)
                  : AppColors.borderSubtle,
            ),
            color: widget.isActive
                ? null
                : _hovered
                ? AppColors.cyan.withValues(alpha: 0.08)
                : Colors.transparent,
            boxShadow: widget.isActive
                ? [BoxShadow(color: AppColors.cyan.withValues(alpha: 0.3), blurRadius: 12)]
                : null,
          ),
          child: Text(
            widget.label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: widget.isActive ? Colors.black : AppColors.textSecondary,
            ),
          ),
        ),
      ),
    );
  }
}

class _SkillCard extends StatefulWidget {
  final SkillModel skill;
  final int index;
  final bool animate;

  const _SkillCard({required this.skill, required this.index, required this.animate});

  @override
  State<_SkillCard> createState() => _SkillCardState();
}

class _SkillCardState extends State<_SkillCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _progress;
  bool _hovered = false;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _progress = Tween<double>(begin: 0, end: widget.skill.level).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic),
    );
  }

  @override
  void didUpdateWidget(_SkillCard old) {
    super.didUpdateWidget(old);
    if (widget.animate && !old.animate) {
      Future.delayed(Duration(milliseconds: widget.index * 80), () {
        if (mounted) _ctrl.forward();
      });
    }
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: _hovered
              ? LinearGradient(
            colors: [
              widget.skill.color.withValues(alpha: 0.15),
              AppColors.bgCard,
            ],
          )
              : const LinearGradient(
            colors: [AppColors.bgCard, AppColors.bgCard],
          ),
          border: Border.all(
            color: _hovered
                ? widget.skill.color.withValues(alpha: 0.5)
                : AppColors.borderGlass,
          ),
          boxShadow: _hovered
              ? [
            BoxShadow(
              color: widget.skill.color.withValues(alpha: 0.15),
              blurRadius: 20,
              spreadRadius: 0,
            )
          ]
              : null,
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Text(
                  widget.skill.icon,
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    widget.skill.name,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
                AnimatedBuilder(
                  animation: _progress,
                  builder: (_, __) {
                    return Text(
                      '${(_progress.value * 100).toInt()}%',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: widget.skill.color,
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 10),
            AnimatedBuilder(
              animation: _progress,
              builder: (_, __) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Stack(
                    children: [
                      Container(
                        height: 6,
                        color: AppColors.borderGlass,
                      ),
                      FractionallySizedBox(
                        widthFactor: _progress.value,
                        child: Container(
                          height: 6,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [widget.skill.color, AppColors.purple],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: widget.skill.color.withValues(alpha: 0.5),
                                blurRadius: 6,
                                spreadRadius: 0,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    )
        .animate()
        .fadeIn(
      delay: Duration(milliseconds: widget.index * 50),
      duration: 400.ms,
    )
        .slideY(begin: 0.2, end: 0);
  }
}
