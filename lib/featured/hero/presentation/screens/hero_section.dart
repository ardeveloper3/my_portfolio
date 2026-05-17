// lib/featured/hero/presentation/screens/hero_section.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import '../../../../core/constance/app_constance.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../shared/provider/scroll_provider.dart';
import '../../../../shared/widget/glow_button.dart';

class HeroSection extends ConsumerWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < AppSizes.mobileBreakpoint;
    final sectionKeys = ref.watch(sectionKeysProvider);

    return SizedBox(
      width: double.infinity,
      height: size.height,
      child: Stack(
        children: [
          // ── Particle background ──────────────────────────────
          Positioned.fill(
            child: Container(color: AppColors.cyan.withValues(alpha: 0.1)),
          ),

          // ── Radial glow blobs ────────────────────────────────
          Positioned(
            top: -200,
            left: -200,
            child: _GlowBlob(color: AppColors.cyan, size: 600),
          ),
          Positioned(
            bottom: -100,
            right: -100,
            child: _GlowBlob(color: AppColors.purple, size: 500),
          ),

          // ── Grid overlay ─────────────────────────────────────
          Positioned.fill(child: _GridOverlay()),

          // ── Main content ─────────────────────────────────────
          Positioned.fill(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: size.height),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: isMobile ? 10 : 12,
                      horizontal: isMobile ? 24 : 80,
                    ),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxWidth: AppSizes.maxWidth,
                      ),
                      child: isMobile
                          ? _MobileHeroContent(sectionKeys: sectionKeys)
                          : _DesktopHeroContent(sectionKeys: sectionKeys),
                    ),
                  ),
                ),
              ),
            ),
          ),

          // ── Scroll indicator ─────────────────────────────────
          Positioned(
            bottom: 32,
            left: 0,
            right: 0,
            child: Center(child: const _ScrollIndicator()),
          ),
        ],
      ),
    );
  }
}

class _DesktopHeroContent extends ConsumerWidget {
  final Map<String, GlobalKey> sectionKeys;
  const _DesktopHeroContent({required this.sectionKeys});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Left: text
        Expanded(flex: 6, child: _HeroText(sectionKeys: sectionKeys)),
        const SizedBox(width: 60),
        // Right: avatar
        const Expanded(flex: 4, child: _AvatarWidget()),
      ],
    );
  }
}

class _MobileHeroContent extends StatelessWidget {
  final Map<String, GlobalKey> sectionKeys;
  const _MobileHeroContent({required this.sectionKeys});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const _AvatarWidget(size: 160),
        const SizedBox(height: 32),
        _HeroText(sectionKeys: sectionKeys, centered: true),
      ],
    );
  }
}

class _HeroText extends ConsumerWidget {
  final Map<String, GlobalKey> sectionKeys;
  final bool centered;

  const _HeroText({required this.sectionKeys, this.centered = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: centered
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Greeting chip
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            border: Border.all(color: AppColors.cyan.withValues(alpha: 0.4)),
            color: AppColors.cyan.withValues(alpha: 0.07),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.cyan,
                  boxShadow: [BoxShadow(color: AppColors.cyan, blurRadius: 6)],
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                'Available for freelance work',
                style: TextStyle(
                  fontSize: 13,
                  color: AppColors.cyan,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ).animate().fadeIn(duration: 600.ms).slideX(begin: -0.2, end: 0),

        const SizedBox(height: 24),

        // Name
        RichText(
              textAlign: centered ? TextAlign.center : TextAlign.left,
              text: TextSpan(
                children: [
                  const TextSpan(
                    text: "Hi, I'm\n",
                    style: TextStyle(
                      fontSize: 64,
                      fontWeight: FontWeight.w300,
                      color: AppColors.textSecondary,
                      height: 1.1,
                    ),
                  ),
                  WidgetSpan(
                    child: ShaderMask(
                      shaderCallback: (b) =>
                          AppColors.cyanPurpleGradient.createShader(b),
                      child: const Text(
                        'Ashikur\nRahman',
                        style: TextStyle(
                          fontSize: 72,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                          height: 1.0,
                          letterSpacing: -2,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
            .animate()
            .fadeIn(delay: 200.ms, duration: 800.ms)
            .slideY(begin: 0.3, end: 0),

        const SizedBox(height: 16),

        // Typing animation
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: centered
              ? MainAxisAlignment.center
              : MainAxisAlignment.start,
          children: [
            AnimatedTextKit(
              repeatForever: true,
              animatedTexts: AppConstants.typingTexts.map((t) {
                return TyperAnimatedText(
                  t,
                  speed: const Duration(milliseconds: 70),
                  textStyle: const TextStyle(
                    fontSize: 20,
                    color: AppColors.cyan,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.5,
                  ),
                );
              }).toList(),
            ),
          ],
        ).animate().fadeIn(delay: 400.ms, duration: 600.ms),

        const SizedBox(height: 24),

        // Bio
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 520),
          child: Text(
            AppConstants.bio,
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: centered ? TextAlign.center : TextAlign.left,
          ),
        ).animate().fadeIn(delay: 500.ms, duration: 600.ms),

        const SizedBox(height: 40),

        // CTA Buttons
        Wrap(
              spacing: 16,
              runSpacing: 16,
              alignment: centered ? WrapAlignment.center : WrapAlignment.start,
              children: [
                GlowButton(
                  label: 'Hire Me',
                  icon: Icons.send_rounded,
                  onTap: () {},
                ),
                GlowButton(
                  label: 'View Projects',
                  icon: Icons.rocket_launch_rounded,
                  variant: GlowButtonVariant.outlined,
                  onTap: () {
                    final ctx = sectionKeys['projects']?.currentContext;
                    if (ctx != null) {
                      Scrollable.ensureVisible(
                        ctx,
                        duration: const Duration(milliseconds: 700),
                        curve: Curves.easeInOutCubic,
                      );
                    }
                  },
                ),
                GlowButton(
                  label: 'Download CV',
                  icon: Icons.download_rounded,
                  variant: GlowButtonVariant.outlined,
                  color: AppColors.purple,
                  onTap: () {},
                ),
              ],
            )
            .animate()
            .fadeIn(delay: 600.ms, duration: 600.ms)
            .slideY(begin: 0.3, end: 0),

        const SizedBox(height: 40),

        // Social icons
        _SocialRow(
          centered: centered,
        ).animate().fadeIn(delay: 800.ms, duration: 600.ms),
      ],
    );
  }
}

class _AvatarWidget extends StatefulWidget {
  final double size;
  const _AvatarWidget({this.size = 320});

  @override
  State<_AvatarWidget> createState() => _AvatarWidgetState();
}

class _AvatarWidgetState extends State<_AvatarWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _float;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    _float = Tween<double>(
      begin: -10,
      end: 10,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));

  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
          animation: _float,
          builder: (_, child) {
            return Transform.translate(
              offset: Offset(0, _float.value),
              child: child,
            );
          },

          child: Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Outer glow ring
                Container(
                  width: widget.size + 40,
                  height: widget.size + 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.cyan.withValues(alpha: 0.2),
                      width: 1,
                    ),
                  ),
                ),
                // Mid ring
                Container(
                  width: widget.size + 16,
                  height: widget.size + 16,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.purple.withValues(alpha: 0.3),
                      width: 1.5,
                    ),
                  ),
                ),
                // Avatar
                Container(
                  width: widget.size,
                  height: widget.size,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        AppColors.cyan.withValues(alpha: 0.2),
                        AppColors.purple.withValues(alpha: 0.2),
                      ],
                    ),
                    border: Border.all(
                      color: AppColors.cyan.withValues(alpha: 0.4),
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.cyan.withValues(alpha: 0.2),
                        blurRadius: 40,
                        spreadRadius: 5,
                      ),
                      BoxShadow(
                        color: AppColors.purple.withValues(alpha: 0.15),
                        blurRadius: 60,
                        spreadRadius: 10,
                      ),
                    ],
                  ),
                  child: ClipOval(child: Image.asset("assets/images/img.png")),
                ),
              ],
            ),
          ),
        )
        .animate()
        .fadeIn(delay: 400.ms, duration: 800.ms)
        .scale(begin: const Offset(0.8, 0.8), end: const Offset(1, 1));
  }
}

class _SocialRow extends StatelessWidget {
  final bool centered;
  const _SocialRow({this.centered = false});

  @override
  Widget build(BuildContext context) {
    final socials = [
      (Icons.code, 'GitHub', AppColors.textSecondary),
      (Icons.work, 'LinkedIn', AppColors.cyan),
      (Icons.facebook, 'Facebook', AppColors.purple),
      (Icons.email, 'Email', AppColors.pink),
    ];

    return Row(
      mainAxisAlignment: centered
          ? MainAxisAlignment.center
          : MainAxisAlignment.start,
      children: socials.map((s) {
        return _SocialIcon(icon: s.$1, label: s.$2, color: s.$3);
      }).toList(),
    );
  }
}

class _SocialIcon extends StatefulWidget {
  final IconData icon;
  final String label;
  final Color color;
  const _SocialIcon({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  State<_SocialIcon> createState() => _SocialIconState();
}

class _SocialIconState extends State<_SocialIcon> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(right: 16),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: _hovered
                ? widget.color.withValues(alpha: 0.6)
                : AppColors.borderSubtle,
          ),
          color: _hovered
              ? widget.color.withValues(alpha: 0.1)
              : Colors.transparent,
          boxShadow: _hovered
              ? [
                  BoxShadow(
                    color: widget.color.withValues(alpha: 0.3),
                    blurRadius: 12,
                  ),
                ]
              : null,
        ),
        child: Icon(
          widget.icon,
          size: 20,
          color: _hovered ? widget.color : AppColors.textSecondary,
        ),
      ),
    );
  }
}

class _GlowBlob extends StatelessWidget {
  final Color color;
  final double size;
  const _GlowBlob({required this.color, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [color.withValues(alpha: 0.12), Colors.transparent],
        ),
      ),
    );
  }
}

class _GridOverlay extends StatelessWidget {
  const _GridOverlay();

  @override
  Widget build(BuildContext context) {
    return Opacity(opacity: 0.03, child: CustomPaint(painter: _GridPainter()));
  }
}

class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.cyan
      ..strokeWidth = 1;
    const step = 60.0;
    for (double x = 0; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(_) => false;
}

class _ScrollIndicator extends StatefulWidget {
  const _ScrollIndicator();

  @override
  State<_ScrollIndicator> createState() => _ScrollIndicatorState();
}

class _ScrollIndicatorState extends State<_ScrollIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);
    _anim = Tween<double>(
      begin: 0,
      end: 8,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _anim,
      builder: (_, __) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Scroll down',
              style: TextStyle(
                fontSize: 12,
                color: AppColors.textMuted,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: 8),
            Transform.translate(
              offset: Offset(0, _anim.value),
              child: Icon(
                Icons.keyboard_arrow_down,
                color: AppColors.cyan.withValues(alpha: 0.6),
                size: 20,
              ),
            ),
          ],
        );
      },
    ).animate().fadeIn(delay: 1200.ms, duration: 800.ms);
  }
}
