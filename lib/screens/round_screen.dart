import 'package:flutter/material.dart';

import '../data/prompt_catalog.dart';
import '../models/icebreaker_prompt.dart';
import '../services/activity_store.dart';
import '../widgets/content_shell.dart';

class RoundScreen extends StatefulWidget {
  const RoundScreen({super.key, required this.categoryId});

  final String categoryId;

  @override
  State<RoundScreen> createState() => _RoundScreenState();
}

class _RoundScreenState extends State<RoundScreen> {
  int _index = 0;
  int _roundAnswers = 0;

  @override
  Widget build(BuildContext context) {
    final category = categoryById(widget.categoryId);
    final prompts = promptsByCategory(category.id);
    final prompt = prompts[_index];
    final store = ActivityScope.of(context);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(category.title)),
      body: SingleChildScrollView(
        child: ContentShell(
          maxWidth: 760,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(99),
                      child: LinearProgressIndicator(
                        minHeight: 8,
                        value: (_index + 1) / prompts.length,
                        color: category.color,
                        backgroundColor: category.color.withValues(alpha: 0.14),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Text('${_index + 1} de ${prompts.length}'),
                ],
              ),
              const SizedBox(height: 22),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 280),
                transitionBuilder: (child, animation) => FadeTransition(
                  opacity: animation,
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0.04, 0),
                      end: Offset.zero,
                    ).animate(animation),
                    child: child,
                  ),
                ),
                child: _QuestionCard(
                  key: ValueKey(prompt.id),
                  prompt: prompt,
                  category: category,
                  isFavorite: store.isFavorite(prompt.id),
                  onFavorite: () => store.toggleFavorite(prompt.id),
                ),
              ),
              const SizedBox(height: 18),
              FilledButton.icon(
                onPressed: () => _answer(prompts.length, store),
                icon: const Icon(Icons.check_rounded),
                label: Text(
                  _index == prompts.length - 1
                      ? 'Concluir rodada'
                      : 'Respondemos! Próxima',
                ),
              ),
              const SizedBox(height: 10),
              TextButton.icon(
                onPressed: () => _next(prompts.length),
                icon: const Icon(Icons.skip_next_rounded),
                label: const Text('Pular pergunta'),
              ),
              const SizedBox(height: 22),
              Text(
                'Dica: dê espaço para cada pessoa responder e use a pergunta de apoio se quiser aprofundar.',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _answer(int promptCount, ActivityStore store) async {
    await store.recordAnswer();
    if (!mounted) return;
    _roundAnswers += 1;
    if (_index == promptCount - 1) {
      await showDialog<void>(
        context: context,
        builder: (context) => AlertDialog(
          icon: const Icon(Icons.celebration_outlined),
          title: const Text('Rodada concluída!'),
          content: Text(
            'Vocês responderam $_roundAnswers ${_roundAnswers == 1 ? 'pergunta' : 'perguntas'} nesta rodada.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Continuar'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Text('Voltar ao início'),
            ),
          ],
        ),
      );
      if (mounted) setState(() => _index = 0);
      return;
    }
    _next(promptCount);
  }

  void _next(int promptCount) {
    setState(() => _index = (_index + 1) % promptCount);
  }
}

class _QuestionCard extends StatelessWidget {
  const _QuestionCard({
    super.key,
    required this.prompt,
    required this.category,
    required this.isFavorite,
    required this.onFavorite,
  });

  final IcebreakerPrompt prompt;
  final PromptCategory category;
  final bool isFavorite;
  final VoidCallback onFavorite;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 7,
                  ),
                  decoration: BoxDecoration(
                    color: category.color.withValues(alpha: 0.14),
                    borderRadius: BorderRadius.circular(99),
                  ),
                  child: Row(
                    children: [
                      Icon(category.icon, size: 17, color: category.color),
                      const SizedBox(width: 7),
                      Text(
                        category.title,
                        style: TextStyle(
                          color: category.color,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                IconButton.filledTonal(
                  tooltip: isFavorite
                      ? 'Remover dos favoritos'
                      : 'Salvar nos favoritos',
                  onPressed: onFavorite,
                  icon: Icon(
                    isFavorite
                        ? Icons.bookmark_rounded
                        : Icons.bookmark_border_rounded,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 48),
            Text(
              prompt.text,
              style: theme.textTheme.displaySmall?.copyWith(fontSize: 38),
            ),
            const SizedBox(height: 32),
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.question_answer_outlined,
                    color: theme.colorScheme.primary,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Pergunta de apoio',
                          style: TextStyle(fontWeight: FontWeight.w800),
                        ),
                        const SizedBox(height: 4),
                        Text(prompt.followUp),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
