import 'package:flutter/material.dart';

import '../models/icebreaker_prompt.dart';

class PromptTile extends StatelessWidget {
  const PromptTile({
    super.key,
    required this.prompt,
    required this.isFavorite,
    required this.onFavorite,
  });

  final IcebreakerPrompt prompt;
  final bool isFavorite;
  final VoidCallback onFavorite;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        contentPadding: const EdgeInsets.fromLTRB(20, 16, 12, 16),
        title: Text(
          prompt.text,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w700,
            height: 1.25,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Text(prompt.followUp),
        ),
        trailing: IconButton(
          tooltip: isFavorite
              ? 'Remover dos favoritos'
              : 'Salvar nos favoritos',
          onPressed: onFavorite,
          icon: Icon(
            isFavorite ? Icons.bookmark_rounded : Icons.bookmark_border_rounded,
            color: isFavorite ? colors.primary : colors.onSurfaceVariant,
          ),
        ),
      ),
    );
  }
}
