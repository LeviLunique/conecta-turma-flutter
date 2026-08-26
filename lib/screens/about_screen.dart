import 'package:flutter/material.dart';

import '../widgets/content_shell.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Sobre o projeto')),
      body: SingleChildScrollView(
        child: ContentShell(
          maxWidth: 760,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.forum_rounded,
                size: 54,
                color: theme.colorScheme.primary,
              ),
              const SizedBox(height: 18),
              Text('Conecta Turma', style: theme.textTheme.displaySmall),
              const SizedBox(height: 12),
              Text(
                'Um aplicativo de quebra-gelo para transformar grupos de pessoas em boas conversas, uma pergunta por vez.',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 32),
              Text(
                'O que este projeto entrega',
                style: theme.textTheme.headlineSmall,
              ),
              const SizedBox(height: 14),
              const _Requirement(
                icon: Icons.layers_outlined,
                title: 'Múltiplas páginas',
                description:
                    'Início, rodada, favoritas e informações do projeto.',
              ),
              const _Requirement(
                icon: Icons.route_outlined,
                title: 'Navegação e rotas',
                description:
                    'Fluxo conectado com rotas nomeadas entre as telas.',
              ),
              const _Requirement(
                icon: Icons.devices_outlined,
                title: 'Android e Web',
                description:
                    'Interface responsiva pronta para celular e navegador.',
              ),
              const _Requirement(
                icon: Icons.save_outlined,
                title: 'Persistência local',
                description:
                    'Favoritas e progresso permanecem salvos no dispositivo.',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Requirement extends StatelessWidget {
  const _Requirement({
    required this.icon,
    required this.title,
    required this.description,
  });

  final IconData icon;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(
          children: [
            CircleAvatar(child: Icon(icon)),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(height: 3),
                  Text(description),
                ],
              ),
            ),
            const Icon(Icons.check_circle_rounded, color: Color(0xFF3A9D75)),
          ],
        ),
      ),
    );
  }
}
