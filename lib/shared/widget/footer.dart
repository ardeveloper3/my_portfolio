// lib/shared/widgets/footer.dart
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/theme/app_theme.dart';

class PortfolioFooter extends StatelessWidget {
  const PortfolioFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 24),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: AppColors.cyan.withOpacity(0.1)),
        ),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              // Logo
              ShaderMask(
                shaderCallback: (b) =>
                    AppColors.cyanPurpleGradient.createShader(b),
                child: const Text(
                  'AR.',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    letterSpacing: -1,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Flutter Developer • Backend Developer • Game Developer',
                style: TextStyle(
                  fontSize: 13,
                  color: AppColors.textMuted,
                  letterSpacing: 0.5,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),

              // Divider
              Container(
                height: 1,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      AppColors.borderGlass,
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Bottom row
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 32,
                runSpacing: 8,
                children: [
                  Text(
                    '© ${DateTime.now().year} Ashikur Rahman. All rights reserved.',
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.textMuted,
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Built with ',
                        style: TextStyle(fontSize: 13, color: AppColors.textMuted),
                      ),
                      const Text(
                        '❤️',
                        style: TextStyle(fontSize: 13),
                      ),
                      const Text(
                        ' using Flutter',
                        style: TextStyle(fontSize: 13, color: AppColors.cyan),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
