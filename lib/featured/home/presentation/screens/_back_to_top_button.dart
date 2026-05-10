// lib/features/home/presentation/screens/_back_to_top_button.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../shared/provider/scroll_provider.dart';
class BackToTopButton extends ConsumerWidget {
  const BackToTopButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollPos = ref.watch(scrollPositionProvider);
    final visible = scrollPos > 400;

    return AnimatedOpacity(
      opacity: visible ? 1 : 0,
      duration: const Duration(milliseconds: 300),
      child: visible
          ? _BackToTopBtn(ref: ref)
          : const SizedBox.shrink(),
    );
  }
}

class _BackToTopBtn extends StatefulWidget {
  final WidgetRef ref;
  const _BackToTopBtn({required this.ref});

  @override
  State<_BackToTopBtn> createState() => _BackToTopBtnState();
}

class _BackToTopBtnState extends State<_BackToTopBtn> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () {
          widget.ref.read(scrollControllerProvider).animateTo(
            0,
            duration: const Duration(milliseconds: 700),
            curve: Curves.easeInOutCubic,
          );
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              colors: [
                AppColors.cyan.withOpacity(_hovered ? 1.0 : 0.8),
                AppColors.purple.withOpacity(_hovered ? 1.0 : 0.8),
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.cyan.withOpacity(_hovered ? 0.5 : 0.3),
                blurRadius: _hovered ? 20 : 12,
              ),
            ],
          ),
          child: const Icon(
            Icons.keyboard_arrow_up_rounded,
            color: Colors.white,
            size: 24,
          ),
        ),
      ),
    ).animate().scale(begin: const Offset(0, 0), end: const Offset(1, 1));
  }
}
