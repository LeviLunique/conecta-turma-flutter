import 'package:flutter/material.dart';

class PromptCategory {
  const PromptCategory({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
  });

  final String id;
  final String title;
  final String description;
  final IconData icon;
  final Color color;
}

class IcebreakerPrompt {
  const IcebreakerPrompt({
    required this.id,
    required this.categoryId,
    required this.text,
    required this.followUp,
  });

  final String id;
  final String categoryId;
  final String text;
  final String followUp;
}
