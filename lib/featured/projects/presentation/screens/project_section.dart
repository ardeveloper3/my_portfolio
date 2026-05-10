// lib/featured/projects/presentation/screens/project_section.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/constance/app_constance.dart';
import '../../../../shared/widget/section_header.dart';
import '../../../../shared/widget/glow_button.dart';
import '../../provider/project_provider.dart';

class ProjectsSection extends ConsumerWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final projects = ref.watch(filteredProjectsProvider);
    final categories = ref.watch(projectCategoriesProvider);
    final activeFilter = ref.watch(projectFilterProvider);
    final isMobile =
        MediaQuery.of(context).size.width < AppSizes.mobileBreakpoint;

    return Container(
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
                label: 'Portfolio',
                title: 'Featured Projects',
                subtitle:
                    'A selection of my best work across mobile, backend, and game development.',
              ),
              const SizedBox(height: 48),

              // Filter tabs
              Wrap(
                spacing: 10,
                runSpacing: 10,
                alignment: WrapAlignment.center,
                children: categories.map((cat) {
                  final isActive = activeFilter == cat;
                  return _FilterTab(
                    label: cat,
                    isActive: isActive,
                    onTap: () =>
                        ref.read(projectFilterProvider.notifier).state = cat,
                  );
                }).toList(),
              ),

              const SizedBox(height: 48),

              // Projects grid
              LayoutBuilder(
                builder: (_, constraints) {
                  final crossAxis = constraints.maxWidth > 900
                      ? 3
                      : constraints.maxWidth > 600
                      ? 2
                      : 1;
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxis,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      childAspectRatio: 0.85,
                    ),
                    itemCount: projects.length,
                    itemBuilder: (_, i) =>
                        _ProjectCard(project: projects[i], index: i),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FilterTab extends StatefulWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _FilterTab({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  State<_FilterTab> createState() => _FilterTabState();
}

class _FilterTabState extends State<_FilterTab> {
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
            borderRadius: BorderRadius.circular(8),
            color: widget.isActive
                ? AppColors.cyan.withValues(alpha: 0.15)
                : _hovered
                ? AppColors.bgCard
                : Colors.transparent,
            border: Border.all(
              color: widget.isActive
                  ? AppColors.cyan.withValues(alpha: 0.6)
                  : AppColors.borderSubtle,
            ),
          ),
          child: Text(
            widget.label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: widget.isActive ? AppColors.cyan : AppColors.textSecondary,
            ),
          ),
        ),
      ),
    );
  }
}

class _ProjectCard extends StatefulWidget {
  final ProjectModel project;
  final int index;

  const _ProjectCard({required this.project, required this.index});

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final p = widget.project;

    return MouseRegion(
          cursor: SystemMouseCursors.click,
          onEnter: (_) => setState(() => _hovered = true),
          onExit: (_) => setState(() => _hovered = false),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            transform: Matrix4.identity()
              ..translate(0.0, _hovered ? -6.0 : 0.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: _hovered
                    ? [p.accentColor.withValues(alpha: 0.12), AppColors.bgCard]
                    : [AppColors.bgCard, AppColors.bgSecondary],
              ),
              border: Border.all(
                color: _hovered
                    ? p.accentColor.withValues(alpha: 0.5)
                    : AppColors.borderGlass,
                width: _hovered ? 1.5 : 1,
              ),
              boxShadow: _hovered
                  ? [
                      BoxShadow(
                        color: p.accentColor.withValues(alpha: 0.2),
                        blurRadius: 30,
                        offset: const Offset(0, 10),
                      ),
                    ]
                  : [],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Thumbnail / Banner
                Container(
                  height: 160,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        p.accentColor.withValues(alpha: 0.3),
                        AppColors.bgPrimary,
                      ],
                    ),
                  ),
                  child: Center(
                    child: Text(p.emoji, style: const TextStyle(fontSize: 56)),
                  ),
                ),

                // Content
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Category badge
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 3,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: p.accentColor.withValues(alpha: 0.1),
                                    border: Border.all(
                                      color: p.accentColor.withValues(
                                        alpha: 0.3,
                                      ),
                                    ),
                                  ),
                                  child: Text(
                                    p.category,
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                      color: p.accentColor,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),

                                Text(
                                  p.title,
                                  style: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.textPrimary,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  p.description,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: AppColors.textSecondary,
                                    height: 1.5,
                                  ),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 12),

                                // Tags
                                Wrap(
                                  spacing: 6,
                                  runSpacing: 6,
                                  children: p.tags.map((tag) {
                                    return Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 3,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        color: AppColors.bgPrimary,
                                        border: Border.all(
                                          color: AppColors.borderSubtle,
                                        ),
                                      ),
                                      child: Text(
                                        tag,
                                        style: const TextStyle(
                                          fontSize: 11,
                                          color: AppColors.textMuted,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 16),

                        // Buttons
                        Row(
                          children: [
                            if (p.githubUrl != null)
                              Expanded(
                                child: _SmallButton(
                                  label: 'GitHub',
                                  icon: Icons.code,
                                  color: AppColors.textSecondary,
                                  onTap: () {},
                                ),
                              ),
                            if (p.githubUrl != null && p.liveUrl != null)
                              const SizedBox(width: 8),
                            if (p.liveUrl != null)
                              Expanded(
                                child: _SmallButton(
                                  label: 'Live Demo',
                                  icon: Icons.open_in_new,
                                  color: p.accentColor,
                                  filled: true,
                                  onTap: () {},
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
        .animate()
        .fadeIn(
          delay: Duration(milliseconds: widget.index * 100),
          duration: 500.ms,
        )
        .slideY(begin: 0.2, end: 0);
  }
}

class _SmallButton extends StatefulWidget {
  final String label;
  final IconData icon;
  final Color color;
  final bool filled;
  final VoidCallback onTap;

  const _SmallButton({
    required this.label,
    required this.icon,
    required this.color,
    this.filled = false,
    required this.onTap,
  });

  @override
  State<_SmallButton> createState() => _SmallButtonState();
}

class _SmallButtonState extends State<_SmallButton> {
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
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: widget.filled
                ? widget.color.withValues(alpha: _hovered ? 0.9 : 0.8)
                : _hovered
                ? AppColors.bgPrimary
                : Colors.transparent,
            border: Border.all(
              color: widget.filled
                  ? Colors.transparent
                  : widget.color.withValues(alpha: _hovered ? 0.6 : 0.3),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                widget.icon,
                size: 14,
                color: widget.filled ? Colors.black : widget.color,
              ),
              const SizedBox(width: 6),
              Text(
                widget.label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: widget.filled ? Colors.black : widget.color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
