// lib/shared/widgets/navbar.dart
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/constance/app_constance.dart';
import '../../core/theme/app_theme.dart';
import '../provider/scroll_provider.dart';
import 'glow_button.dart';

class PortfolioNavbar extends ConsumerWidget {
  const PortfolioNavbar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isScrolled = ref.watch(navbarScrolledProvider);
    final activeIndex = ref.watch(activeNavIndexProvider);
    final sectionKeys = ref.watch(sectionKeysProvider);
    final isMobile = MediaQuery.of(context).size.width < AppSizes.mobileBreakpoint;

    void scrollTo(int index) {
      ref.read(activeNavIndexProvider.notifier).state = index;
      final keys = sectionKeys.values.toList();
      if (index < keys.length) {
        final ctx = keys[index].currentContext;
        if (ctx != null) {
          Scrollable.ensureVisible(
            ctx,
            duration: const Duration(milliseconds: 700),
            curve: Curves.easeInOutCubic,
          );
        }
      }
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: AppSizes.navHeight,
      decoration: BoxDecoration(
        color: isScrolled
            ? AppColors.bgPrimary.withOpacity(0.85)
            : Colors.transparent,
        border: isScrolled
            ? Border(
          bottom: BorderSide(
            color: AppColors.cyan.withOpacity(0.15),
            width: 1,
          ),
        )
            : null,
      ),
      child: ClipRect(
        child: BackdropFilter(
          filter: isScrolled
              ? ImageFilter.blur(sigmaX: 20, sigmaY: 20)
              : ImageFilter.blur(sigmaX: 0, sigmaY: 0),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Row(
              children: [
                // Logo
                ShaderMask(
                  shaderCallback: (b) =>
                      AppColors.cyanPurpleGradient.createShader(b),
                  child: const Text(
                    'AR.',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      letterSpacing: -1,
                    ),
                  ),
                ),
                const Spacer(),

                if (!isMobile) ...[
                  // Nav Items
                  ...AppConstants.navItems.asMap().entries.map((e) {
                    final isActive = activeIndex == e.key;
                    return _NavItem(
                      label: e.value,
                      isActive: isActive,
                      onTap: () => scrollTo(e.key),
                    );
                  }),
                  const SizedBox(width: 24),
                  GlowButton(
                    label: 'Hire Me',
                    onTap: () {},
                  ),
                ] else
                  IconButton(
                    icon: const Icon(Icons.menu, color: AppColors.textPrimary),
                    onPressed: () => _showMobileMenu(context, scrollTo),
                  ),
              ],
            ),
          ),
        ),
      ),
    ).animate().fadeIn(duration: 800.ms).slideY(begin: -1, end: 0);
  }

  void _showMobileMenu(BuildContext context, void Function(int) scrollTo) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.bgSecondary,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        side: BorderSide(color: AppColors.borderGlass),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: AppConstants.navItems.asMap().entries.map((e) {
            return ListTile(
              title: Text(e.value, style: const TextStyle(color: AppColors.textPrimary)),
              onTap: () {
                Navigator.pop(context);
                scrollTo(e.key);
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}

class _NavItem extends StatefulWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavItem({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final active = widget.isActive || _hovered;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 200),
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: active ? AppColors.cyan : AppColors.textSecondary,
                ),
                child: Text(widget.label),
              ),
              const SizedBox(height: 2),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: 2,
                width: active ? 24 : 0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  gradient: AppColors.cyanPurpleGradient,
                  boxShadow: active
                      ? [
                    BoxShadow(
                      color: AppColors.cyan.withOpacity(0.6),
                      blurRadius: 6,
                    )
                  ]
                      : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
