// lib/featured/contact/presentation/screens/contact_section.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/constance/app_constance.dart';
import '../../../../shared/widget/section_header.dart';
import '../../../../shared/widget/glass_card.dart';
import '../../../../shared/widget/glow_button.dart';
import '../../provier/contact_providers.dart';

class ContactSection extends ConsumerWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isMobile = MediaQuery.of(context).size.width < AppSizes.tabletBreakpoint;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.bgPrimary,
            AppColors.bgSecondary.withValues(alpha: 0.4),
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
                label: "Let's Talk",
                title: 'Get In Touch',
                subtitle:
                "Have a project in mind? Let's build something amazing together.",
              ),
              const SizedBox(height: 64),
              isMobile
                  ? Column(
                children: [
                  _ContactInfo(),
                  const SizedBox(height: 32),
                  _ContactForm(),
                ],
              )
                  : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 4, child: _ContactInfo()),
                  const SizedBox(width: 48),
                  Expanded(flex: 6, child: _ContactForm()),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ContactInfo extends StatelessWidget {
  static const _contacts = [
    (Icons.email_rounded, 'Email', AppConstants.email, AppColors.cyan),
    (Icons.phone_rounded, 'WhatsApp', AppConstants.whatsApp, AppColors.purple),
    (Icons.code_rounded, 'GitHub', 'github.com/ashikur', AppColors.textSecondary),
    (Icons.work_rounded, 'LinkedIn', 'linkedin.com/in/ashikur', AppColors.cyan),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Let's create something\namazing together.",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
            height: 1.3,
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          "I'm always open to discussing new projects, creative ideas, or opportunities to be part of your vision.",
          style: TextStyle(
            fontSize: 15,
            color: AppColors.textSecondary,
            height: 1.6,
          ),
        ),
        const SizedBox(height: 32),
        ..._contacts.map((c) => _ContactItem(
          icon: c.$1,
          label: c.$2,
          value: c.$3,
          color: c.$4,
        )),
      ],
    ).animate().fadeIn(duration: 600.ms).slideX(begin: -0.1, end: 0);
  }
}

class _ContactItem extends StatefulWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _ContactItem({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  State<_ContactItem> createState() => _ContactItemState();
}

class _ContactItemState extends State<_ContactItem> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: _hovered
                ? widget.color.withValues(alpha: 0.5)
                : AppColors.borderGlass,
          ),
          color: _hovered ? widget.color.withValues(alpha: 0.05) : Colors.transparent,
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: widget.color.withValues(alpha: 0.1),
                border: Border.all(color: widget.color.withValues(alpha: 0.3)),
              ),
              child: Icon(widget.icon, color: widget.color, size: 18),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.label,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textMuted,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    widget.value,
                    style: TextStyle(
                      fontSize: 14,
                      color: _hovered ? widget.color : AppColors.textPrimary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 14,
              color: _hovered ? widget.color : AppColors.textMuted,
            ),
          ],
        ),
      ),
    );
  }
}

class _ContactForm extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(contactFormProvider);
    final notifier = ref.read(contactFormProvider.notifier);

    if (state.status == ContactFormStatus.success) {
      return GlassCard(
        glowColor: AppColors.cyan,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.check_circle_rounded, color: AppColors.cyan, size: 64),
              const SizedBox(height: 16),
              const Text(
                "Message Sent! 🚀",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "I'll get back to you within 24 hours.",
                style: TextStyle(color: AppColors.textSecondary),
              ),
              const SizedBox(height: 24),
              GlowButton(
                label: 'Send Another',
                variant: GlowButtonVariant.outlined,
                onTap: notifier.reset,
              ),
            ],
          ),
        ),
      ).animate().fadeIn(duration: 500.ms).scale();
    }

    return GlassCard(
      child: Column(
        children: [
          _FormField(
            label: 'Your Name',
            hint: 'Ashikur Rahman',
            icon: Icons.person_rounded,
            onChanged: notifier.updateName,
          ),
          const SizedBox(height: 16),
          _FormField(
            label: 'Email Address',
            hint: 'you@example.com',
            icon: Icons.email_rounded,
            onChanged: notifier.updateEmail,
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 16),
          _FormField(
            label: 'Your Message',
            hint: "Tell me about your project...",
            icon: Icons.message_rounded,
            onChanged: notifier.updateMessage,
            maxLines: 5,
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: state.status == ContactFormStatus.loading
                ? const Center(
              child: CircularProgressIndicator(color: AppColors.cyan),
            )
                : GlowButton(
              label: 'Send Message',
              icon: Icons.send_rounded,
              width: double.infinity,
              onTap: notifier.submit,
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 200.ms, duration: 600.ms).slideX(begin: 0.1, end: 0);
  }
}

class _FormField extends StatefulWidget {
  final String label;
  final String hint;
  final IconData icon;
  final ValueChanged<String> onChanged;
  final int maxLines;
  final TextInputType? keyboardType;

  const _FormField({
    required this.label,
    required this.hint,
    required this.icon,
    required this.onChanged,
    this.maxLines = 1,
    this.keyboardType,
  });

  @override
  State<_FormField> createState() => _FormFieldState();
}

class _FormFieldState extends State<_FormField> {
  bool _focused = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 8),
        Focus(
          onFocusChange: (v) => setState(() => _focused = v),
          child: TextField(
            maxLines: widget.maxLines,
            keyboardType: widget.keyboardType,
            onChanged: widget.onChanged,
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.textPrimary,
            ),
            decoration: InputDecoration(
              hintText: widget.hint,
              hintStyle: const TextStyle(
                color: AppColors.textMuted,
                fontSize: 14,
              ),
              prefixIcon: Icon(
                widget.icon,
                size: 18,
                color: _focused ? AppColors.cyan : AppColors.textMuted,
              ),
              filled: true,
              fillColor: AppColors.bgPrimary,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: AppColors.borderGlass),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: AppColors.borderGlass),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: AppColors.cyan, width: 1.5),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
