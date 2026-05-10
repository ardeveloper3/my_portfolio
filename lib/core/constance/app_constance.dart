// lib/core/constants/app_constants.dart

class AppConstants {
  AppConstants._();

  static const String name = 'Ashikur Rahman';
  static const String title = 'Flutter Developer • Backend Developer • Game Developer';
  static const String bio =
      'I build high-performance mobile apps, scalable backends, and immersive games. '
      'Passionate about clean architecture, smooth UX, and impactful digital products.';

  // Contact
  static const String email = 'ashikur@example.com';
  static const String whatsApp = '+8801XXXXXXXXX';
  static const String github = 'https://github.com/ashikur';
  static const String linkedin = 'https://linkedin.com/in/ashikur';
  static const String facebook = 'https://facebook.com/ashikur';

  // Nav sections
  static const List<String> navItems = [
    'Home',
    'About',
    'Skills',
    'Projects',
    'Experience',
    'Contact',
  ];

  static const List<String> typingTexts = [
    'Flutter Developer',
    'Backend Developer',
    'Game Developer',
    'UI/UX Enthusiast',
    'Problem Solver',
  ];
}

class AppSizes {
  AppSizes._();

  static const double navHeight = 70;
  static const double maxWidth = 1200;
  static const double sectionPaddingV = 100;
  static const double sectionPaddingH = 24;

  static const double mobileBreakpoint = 600;
  static const double tabletBreakpoint = 1024;
}
