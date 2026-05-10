// lib/featured/skill/provider/skill_provider.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../../../core/theme/app_theme.dart';

class SkillModel {
  final String name;
  final double level; // 0.0 - 1.0
  final Color color;
  final String category;
  final String icon;

  const SkillModel({
    required this.name,
    required this.level,
    required this.color,
    required this.category,
    required this.icon,
  });
}

final skillCategoryProvider = StateProvider<String>((ref) => 'All');

final skillsProvider = Provider<List<SkillModel>>((ref) {
  return const [
    SkillModel(name: 'Flutter', level: 0.95, color: AppColors.cyan, category: 'Mobile', icon: '📱'),
    SkillModel(name: 'Dart', level: 0.93, color: AppColors.cyan, category: 'Mobile', icon: '🎯'),
    SkillModel(name: 'Firebase', level: 0.85, color: Color(0xFFFF9800), category: 'Backend', icon: '🔥'),
    SkillModel(name: 'REST API', level: 0.90, color: AppColors.purple, category: 'Backend', icon: '🔗'),
    SkillModel(name: 'JWT Auth', level: 0.88, color: AppColors.purple, category: 'Backend', icon: '🔐'),
    SkillModel(name: 'Serverpod', level: 0.80, color: AppColors.cyan, category: 'Backend', icon: '⚡'),
    SkillModel(name: 'Node.js', level: 0.82, color: Color(0xFF68A063), category: 'Backend', icon: '🟢'),
    SkillModel(name: 'Docker', level: 0.75, color: Color(0xFF2496ED), category: 'DevOps', icon: '🐳'),
    SkillModel(name: 'Redis', level: 0.72, color: Color(0xFFDC382D), category: 'Backend', icon: '💾'),
    SkillModel(name: 'Game Dev', level: 0.85, color: AppColors.pink, category: 'Game', icon: '🎮'),
    SkillModel(name: 'C++', level: 0.78, color: Color(0xFF00599C), category: 'Game', icon: '⚙️'),
    SkillModel(name: 'Flutter Flame', level: 0.80, color: AppColors.pink, category: 'Game', icon: '🔥'),
    SkillModel(name: 'UI/UX', level: 0.88, color: AppColors.purple, category: 'Design', icon: '🎨'),
    SkillModel(name: 'Architecture', level: 0.87, color: AppColors.cyan, category: 'Backend', icon: '🏗️'),
  ];
});

final filteredSkillsProvider = Provider<List<SkillModel>>((ref) {
  final skills = ref.watch(skillsProvider);
  final category = ref.watch(skillCategoryProvider);
  if (category == 'All') return skills;
  return skills.where((s) => s.category == category).toList();
});

final skillCategoriesProvider = Provider<List<String>>((ref) {
  final skills = ref.watch(skillsProvider);
  final cats = skills.map((s) => s.category).toSet().toList();
  return ['All', ...cats];
});
