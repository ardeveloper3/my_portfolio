// lib/shared/widgets/glass_card.dart
import 'dart:ui';
import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final double? width;
  final double? height;
  final VoidCallback? onTap;
  final double borderRadius;
  final Color? glowColor;

  const GlassCard({
    super.key,
    required this.child,
    this.padding,
    this.width,
    this.height,
    this.onTap,
    this.borderRadius = 16,
    this.glowColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          gradient: AppColors.cardGradient,
          border: Border.all(
            color: (glowColor ?? AppColors.cyan).withOpacity(0.2),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: (glowColor ?? AppColors.cyan).withOpacity(0.06),
              blurRadius: 24,
              spreadRadius: 0,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Padding(
              padding: padding ?? const EdgeInsets.all(24),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
