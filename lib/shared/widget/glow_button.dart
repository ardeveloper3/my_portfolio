// lib/shared/widgets/glow_button.dart
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/theme/app_theme.dart';

enum GlowButtonVariant { filled, outlined }

class GlowButton extends StatefulWidget {
  final String label;
  final VoidCallback? onTap;
  final GlowButtonVariant variant;
  final Color? color;
  final IconData? icon;
  final double? width;

  const GlowButton({
    super.key,
    required this.label,
    this.onTap,
    this.variant = GlowButtonVariant.filled,
    this.color,
    this.icon,
    this.width,
  });

  @override
  State<GlowButton> createState() => _GlowButtonState();
}

class _GlowButtonState extends State<GlowButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final color = widget.color ?? AppColors.cyan;
    final isFilled = widget.variant == GlowButtonVariant.filled;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: widget.width,
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            gradient: isFilled
                ? LinearGradient(colors: [color, color.withOpacity(0.7)])
                : null,
            border: isFilled
                ? null
                : Border.all(color: color.withOpacity(_hovered ? 1.0 : 0.6), width: 1.5),
            color: isFilled ? null : color.withOpacity(_hovered ? 0.1 : 0.0),
            boxShadow: _hovered
                ? [
              BoxShadow(
                color: color.withOpacity(0.4),
                blurRadius: 24,
                spreadRadius: 0,
              )
            ]
                : [
              BoxShadow(
                color: color.withOpacity(0.15),
                blurRadius: 12,
                spreadRadius: 0,
              )
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.icon != null) ...[
                Icon(widget.icon, size: 18, color: isFilled ? Colors.black : color),
                const SizedBox(width: 8),
              ],
              Text(
                widget.label,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: isFilled ? Colors.black : color,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
      ),
    )
        .animate(target: _hovered ? 1 : 0)
        .scale(begin: const Offset(1, 1), end: const Offset(1.03, 1.03), duration: 150.ms);
  }
}
