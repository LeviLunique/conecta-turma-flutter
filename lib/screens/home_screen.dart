import 'package:flutter/material.dart';

import '../app.dart';
import '../data/prompt_catalog.dart';
import '../models/icebreaker_prompt.dart';
import '../services/activity_store.dart';
import '../widgets/content_shell.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final store = ActivityScope.of(context);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const _Brand(),
        actions: [
          IconButton(
            tooltip: 'Perguntas salvas',
            onPressed: () => Navigator.pushNamed(context, AppRoutes.favorites),
            icon: const Icon(Icons.bookmark_outline_rounded),
          ),
          IconButton(
            tooltip: 'Sobre o aplicativo',
            onPressed: () => Navigator.pushNamed(context, AppRoutes.about),
            icon: const Icon(Icons.info_outline_rounded),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        child: ContentShell(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Hero(answeredCount: store.answeredCount),
              const SizedBox(height: 34),
              Text(
                'Escolha o clima da conversa',
                style: theme.textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              Text(
                'Cada rodada traz perguntas pensadas para criar uma conexão de verdade.',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 20),
              LayoutBuilder(
                builder: (context, constraints) {
                  final desktop = constraints.maxWidth >= 840;
                  final width = desktop
                      ? (constraints.maxWidth - 32) / 3
                      : constraints.maxWidth;
                  return Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    children: [
                      for (final category in promptCategories)
                        SizedBox(
                          width: width,
                          child: _CategoryCard(category: category),
                        ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 28),
              _SavedBanner(savedCount: store.favoriteIds.length),
            ],
          ),
        ),
      ),
    );
  }
}

class _Brand extends StatelessWidget {
  const _Brand();

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.forum_rounded),
        SizedBox(width: 10),
        Text('Conecta Turma', style: TextStyle(fontWeight: FontWeight.w800)),
      ],
    );
  }
}

class _Hero extends StatelessWidget {
  const _Hero({required this.answeredCount});

  final int answeredCount;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF5F50CF), Color(0xFF8274EE)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final compact = constraints.maxWidth < 620;
          final copy = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 7,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.16),
                  borderRadius: BorderRadius.circular(99),
                ),
                child: const Text(
                  'QUEBRE O GELO',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.1,
                  ),
                ),
              ),
              const SizedBox(height: 18),
              Text(
                'Boas conversas começam com uma boa pergunta.',
                style: theme.textTheme.displaySmall?.copyWith(
                  color: Colors.white,
                  fontSize: compact ? 34 : 46,
                ),
              ),
              const SizedBox(height: 14),
              Text(
                'Escolha uma categoria, reúna a turma e descubra algo novo sobre quem está por perto.',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: Colors.white.withValues(alpha: 0.88),
                  height: 1.45,
                ),
              ),
            ],
          );

          final stat = Container(
            width: compact ? double.infinity : 170,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(22),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.chat_bubble_outline_rounded,
                  color: Color(0xFF6557D9),
                ),
                const SizedBox(height: 18),
                Text(
                  '$answeredCount',
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  answeredCount == 1
                      ? 'pergunta respondida'
                      : 'perguntas respondidas',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          );

          if (compact) {
            return Column(children: [copy, const SizedBox(height: 24), stat]);
          }
          return Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(child: copy),
              const SizedBox(width: 36),
              stat,
            ],
          );
        },
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  const _CategoryCard({required this.category});

  final PromptCategory category;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => Navigator.pushNamed(
          context,
          AppRoutes.round,
          arguments: category.id,
        ),
        child: Padding(
          padding: const EdgeInsets.all(22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: category.color.withValues(alpha: 0.16),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Icon(category.icon, color: category.color),
              ),
              const SizedBox(height: 22),
              Text(category.title, style: theme.textTheme.titleLarge),
              const SizedBox(height: 8),
              Text(
                category.description,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  Text(
                    'Começar rodada',
                    style: TextStyle(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Icon(
                    Icons.arrow_forward_rounded,
                    size: 18,
                    color: theme.colorScheme.primary,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SavedBanner extends StatelessWidget {
  const _SavedBanner({required this.savedCount});

  final int savedCount;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            const CircleAvatar(child: Icon(Icons.bookmark_rounded)),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sua coleção',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    '$savedCount ${savedCount == 1 ? 'pergunta salva' : 'perguntas salvas'}',
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: () =>
                  Navigator.pushNamed(context, AppRoutes.favorites),
              child: const Text('Ver favoritas'),
            ),
          ],
        ),
      ),
    );
  }
}
