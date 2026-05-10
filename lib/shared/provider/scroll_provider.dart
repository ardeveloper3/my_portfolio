// lib/shared/providers/scroll_provider.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

// ── Scroll Controller ────────────────────────────────────────────
final scrollControllerProvider = Provider<ScrollController>((ref) {
  final controller = ScrollController();
  ref.onDispose(controller.dispose);
  return controller;
});

// ── Active Nav Index ─────────────────────────────────────────────
final activeNavIndexProvider = StateProvider<int>((ref) => 0);

// ── Scroll Position ──────────────────────────────────────────────
final scrollPositionProvider = StateProvider<double>((ref) => 0.0);

// ── Navbar Opacity (blur on scroll) ─────────────────────────────
final navbarScrolledProvider = StateProvider<bool>((ref) => false);

// ── Section Keys (for scroll-to navigation) ──────────────────────
final sectionKeysProvider = Provider<Map<String, GlobalKey>>((ref) {
  return {
    'home': GlobalKey(),
    'about': GlobalKey(),
    'skills': GlobalKey(),
    'projects': GlobalKey(),
    'experience': GlobalKey(),
    'contact': GlobalKey(),
  };
});

// ── Cursor Position (custom cursor) ─────────────────────────────
final cursorPositionProvider = StateProvider<Offset>((ref) => Offset.zero);
final cursorHoveringProvider = StateProvider<bool>((ref) => false);

// ── Loading State ────────────────────────────────────────────────
final loadingCompleteProvider = StateProvider<bool>((ref) => false);
