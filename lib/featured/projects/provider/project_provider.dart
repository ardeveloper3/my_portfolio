// lib/features/projects/providers/projects_provider.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../../../core/theme/app_theme.dart';

class ProjectModel {
  final String id;
  final String title;
  final String description;
  final List<String> tags;
  final String? githubUrl;
  final String? liveUrl;
  final Color accentColor;
  final String category;
  final String emoji;

  const ProjectModel({
    required this.id,
    required this.title,
    required this.description,
    required this.tags,
    this.githubUrl,
    this.liveUrl,
    required this.accentColor,
    required this.category,
    required this.emoji,
  });
}

final projectFilterProvider = StateProvider<String>((ref) => 'All');

final projectsProvider = Provider<List<ProjectModel>>((ref) {
  return const [
    ProjectModel(
      id: 'school_app',
      title: 'School Management App',
      description:
      'A full-featured school management system with attendance tracking, '
          'grade management, teacher-student communication, and real-time notifications.',
      tags: ['Flutter', 'Firebase', 'Riverpod', 'REST API'],
      githubUrl: 'https://github.com/ashikur',
      accentColor: AppColors.cyan,
      category: 'Mobile',
      emoji: '🏫',
    ),
    ProjectModel(
      id: 'jwt_backend',
      title: 'JWT Authentication Backend',
      description:
      'Production-ready authentication microservice with access/refresh tokens, '
          'role-based access control, Redis session management, and Docker deployment.',
      tags: ['Node.js', 'JWT', 'Redis', 'Docker'],
      githubUrl: 'https://github.com/ashikur',
      accentColor: AppColors.purple,
      category: 'Backend',
      emoji: '🔐',
    ),
    ProjectModel(
      id: 'notification_system',
      title: 'Flutter Notification System',
      description:
      'A scalable push notification system supporting FCM, local notifications, '
          'scheduled alerts, and deep linking with beautiful custom UI.',
      tags: ['Flutter', 'Firebase FCM', 'Dart', 'Serverpod'],
      githubUrl: 'https://github.com/ashikur',
      accentColor: AppColors.cyan,
      category: 'Mobile',
      emoji: '🔔',
    ),
    ProjectModel(
      id: '2d_game',
      title: '2D Platformer Game',
      description:
      'A high-performance 2D platformer built with Flutter Flame engine, '
          'featuring smooth physics, enemy AI, particle effects, and level progression.',
      tags: ['Flutter Flame', 'Dart', 'Game Dev', 'Physics'],
      githubUrl: 'https://github.com/ashikur',
      liveUrl: 'https://game.ashikur.dev',
      accentColor: AppColors.pink,
      category: 'Game',
      emoji: '🎮',
    ),
    ProjectModel(
      id: 'ai_tools',
      title: 'AI Based Tools Suite',
      description:
      'A collection of AI-powered productivity tools including text summarizer, '
          'code reviewer, and image classifier integrated with OpenAI & Gemini APIs.',
      tags: ['Flutter', 'OpenAI API', 'Gemini', 'REST API'],
      githubUrl: 'https://github.com/ashikur',
      liveUrl: 'https://ai.ashikur.dev',
      accentColor: AppColors.purple,
      category: 'AI',
      emoji: '🤖',
    ),
    ProjectModel(
      id: 'multiplayer',
      title: 'Multiplayer Game Concept',
      description:
      'Real-time multiplayer strategy game with WebSocket communication, '
          'room-based matchmaking, leaderboards, and cross-platform support.',
      tags: ['Flutter Flame', 'WebSocket', 'Serverpod', 'C++'],
      githubUrl: 'https://github.com/ashikur',
      accentColor: AppColors.pink,
      category: 'Game',
      emoji: '🕹️',
    ),
  ];
});

final filteredProjectsProvider = Provider<List<ProjectModel>>((ref) {
  final projects = ref.watch(projectsProvider);
  final filter = ref.watch(projectFilterProvider);
  if (filter == 'All') return projects;
  return projects.where((p) => p.category == filter).toList();
});

final projectCategoriesProvider = Provider<List<String>>((ref) {
  final projects = ref.watch(projectsProvider);
  final cats = projects.map((p) => p.category).toSet().toList();
  return ['All', ...cats];
});
