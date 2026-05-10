// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_portfolliow/shared/widget/loading_screen.dart';
import 'core/theme/app_theme.dart';
import 'featured/home/presentation/screens/home_screen.dart';


void main() {
  runApp(
    const ProviderScope(
      child: PortfolioApp(),
    ),
  );
}

class PortfolioApp extends ConsumerWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Ashikur Rahman — Flutter Developer',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      home: const _AppRoot(),
    );
  }
}

class _AppRoot extends StatefulWidget {
  const _AppRoot();

  @override
  State<_AppRoot> createState() => _AppRootState();
}

class _AppRootState extends State<_AppRoot> {
  bool _loaded = false;

  @override
  Widget build(BuildContext context) {
    if (!_loaded) {
      return LoadingScreen(
        onComplete: () => setState(() => _loaded = true),
      );
    }

    return const HomeScreen();
  }
}
