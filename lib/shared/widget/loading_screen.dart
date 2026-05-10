// lib/shared/widgets/loading_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/theme/app_theme.dart';

class LoadingScreen extends StatefulWidget {
  final VoidCallback onComplete;
  const LoadingScreen({super.key, required this.onComplete});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  double _progress = 0;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    _ctrl.addListener(() {
      setState(() => _progress = _ctrl.value);
    });

    _ctrl.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(const Duration(milliseconds: 300), widget.onComplete);
      }
    });

    Future.delayed(const Duration(milliseconds: 300), () {
      _ctrl.forward();
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgPrimary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Animated logo
            ShaderMask(
              shaderCallback: (b) =>
                  AppColors.cyanPurpleGradient.createShader(b),
              child: const Text(
                'AR.',
                style: TextStyle(
                  fontSize: 72,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  letterSpacing: -3,
                ),
              ),
            )
                .animate()
                .fadeIn(duration: 600.ms)
                .scale(begin: const Offset(0.8, 0.8)),

            const SizedBox(height: 8),

            const Text(
              'ASHIKUR RAHMAN',
              style: TextStyle(
                fontSize: 12,
                color: AppColors.textMuted,
                letterSpacing: 4,
                fontWeight: FontWeight.w500,
              ),
            ).animate().fadeIn(delay: 200.ms, duration: 600.ms),

            const SizedBox(height: 48),

            // Progress bar
            SizedBox(
              width: 200,
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: _progress,
                      backgroundColor: AppColors.borderGlass,
                      valueColor: AlwaysStoppedAnimation<Color>(AppColors.cyan),
                      minHeight: 3,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    '${(_progress * 100).toInt()}%',
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textMuted,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
            ).animate().fadeIn(delay: 400.ms, duration: 400.ms),
          ],
        ),
      ),
    );
  }
}
