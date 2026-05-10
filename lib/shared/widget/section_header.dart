// lib/shared/widgets/section_header.dart
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/theme/app_theme.dart';

class SectionHeader extends StatelessWidget {
  final String label;
  final String title;
  final String? subtitle;
  final CrossAxisAlignment alignment;

  const SectionHeader({
    super.key,
    required this.label,
    required this.title,
    this.subtitle,
    this.alignment = CrossAxisAlignment.center,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: alignment,
      children: [
        // Label chip
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            border: Border.all(color: AppColors.cyan.withOpacity(0.5), width: 1),
            color: AppColors.cyan.withOpacity(0.08),
          ),
          child: Text(
            label.toUpperCase(),
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.cyan,
              letterSpacing: 2,
            ),
          ),
        )
            .animate()
            .fadeIn(delay: 100.ms, duration: 600.ms)
            .slideY(begin: 0.3, end: 0),

        const SizedBox(height: 16),

        // Title with gradient
        ShaderMask(
          shaderCallback: (bounds) =>
              AppColors.cyanPurpleGradient.createShader(bounds),
          child: Text(
            title,
            style: Theme.of(context).textTheme.displaySmall!.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
            textAlign: alignment == CrossAxisAlignment.center
                ? TextAlign.center
                : TextAlign.left,
          ),
        )
            .animate()
            .fadeIn(delay: 200.ms, duration: 600.ms)
            .slideY(begin: 0.3, end: 0),

        if (subtitle != null) ...[
          const SizedBox(height: 16),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: Text(
              subtitle!,
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: alignment == CrossAxisAlignment.center
                  ? TextAlign.center
                  : TextAlign.left,
            ),
          )
              .animate()
              .fadeIn(delay: 300.ms, duration: 600.ms),
        ],

        const SizedBox(height: 8),

        // Neon underline
        if (alignment == CrossAxisAlignment.center)
          Center(
            child: Container(
              margin: const EdgeInsets.only(top: 16),
              width: 60,
              height: 3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                gradient: AppColors.cyanPurpleGradient,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.cyan.withOpacity(0.6),
                    blurRadius: 10,
                    spreadRadius: 1,
                  ),
                ],
              ),
            ),
          )
              .animate()
              .fadeIn(delay: 400.ms, duration: 600.ms)
              .scaleX(begin: 0, end: 1),
      ],
    );
  }
}
