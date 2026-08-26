import 'package:flutter/material.dart';

import '../data/prompt_catalog.dart';
import '../services/activity_store.dart';
import '../widgets/content_shell.dart';
import '../widgets/prompt_tile.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final store = ActivityScope.of(context);
    final favorites = icebreakerPrompts
        .where((prompt) => store.isFavorite(prompt.id))
        .toList(growable: false);

    return Scaffold(
      appBar: AppBar(title: const Text('Perguntas salvas')),
      body: ContentShell(
        maxWidth: 760,
        child: favorites.isEmpty
            ? const _EmptyFavorites()
            : ListView.builder(
                itemCount: favorites.length,
                itemBuilder: (context, index) {
                  final prompt = favorites[index];
                  return PromptTile(
                    prompt: prompt,
                    isFavorite: true,
                    onFavorite: () => store.toggleFavorite(prompt.id),
                  );
                },
              ),
      ),
    );
  }
}

class _EmptyFavorites extends StatelessWidget {
  const _EmptyFavorites();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.bookmark_add_outlined,
            size: 64,
            color: theme.colorScheme.primary,
          ),
          const SizedBox(height: 18),
          Text('Nenhuma pergunta salva', style: theme.textTheme.headlineSmall),
          const SizedBox(height: 8),
          Text(
            'Durante uma rodada, toque no marcador para guardar suas favoritas.',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 18),
          FilledButton.tonal(
            onPressed: () => Navigator.pop(context),
            child: const Text('Escolher uma categoria'),
          ),
        ],
      ),
    );
  }
}
