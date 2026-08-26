import 'package:flutter/material.dart';

import '../models/icebreaker_prompt.dart';

const promptCategories = <PromptCategory>[
  PromptCategory(
    id: 'leves',
    title: 'Comece leve',
    description: 'Perguntas rápidas para abrir a conversa.',
    icon: Icons.wb_sunny_outlined,
    color: Color(0xFFFF9D66),
  ),
  PromptCategory(
    id: 'curiosidades',
    title: 'Descubra histórias',
    description: 'Boas memórias e detalhes inesperados.',
    icon: Icons.auto_awesome_outlined,
    color: Color(0xFF55B8A5),
  ),
  PromptCategory(
    id: 'colaboracao',
    title: 'Crie conexão',
    description: 'Ideias para aproximar e colaborar.',
    icon: Icons.people_alt_outlined,
    color: Color(0xFF7768E8),
  ),
];

const icebreakerPrompts = <IcebreakerPrompt>[
  IcebreakerPrompt(
    id: 'leve-1',
    categoryId: 'leves',
    text: 'Qual pequena coisa melhorou o seu dia hoje?',
    followUp: 'Conte por que isso fez diferença.',
  ),
  IcebreakerPrompt(
    id: 'leve-2',
    categoryId: 'leves',
    text:
        'Se você pudesse dominar uma habilidade instantaneamente, qual seria?',
    followUp: 'Como você usaria essa habilidade nesta semana?',
  ),
  IcebreakerPrompt(
    id: 'leve-3',
    categoryId: 'leves',
    text: 'Qual música não pode faltar na sua playlist?',
    followUp: 'O que ela faz você sentir?',
  ),
  IcebreakerPrompt(
    id: 'leve-4',
    categoryId: 'leves',
    text: 'Praia, montanha ou cidade: qual cenário combina com você?',
    followUp: 'Descreva o seu dia perfeito nesse lugar.',
  ),
  IcebreakerPrompt(
    id: 'leve-5',
    categoryId: 'leves',
    text: 'Qual comida você indicaria sem pensar duas vezes?',
    followUp: 'Onde encontrar a melhor versão dela?',
  ),
  IcebreakerPrompt(
    id: 'curiosidade-1',
    categoryId: 'curiosidades',
    text: 'Qual foi a última coisa que você aprendeu por curiosidade?',
    followUp: 'O que despertou seu interesse?',
  ),
  IcebreakerPrompt(
    id: 'curiosidade-2',
    categoryId: 'curiosidades',
    text: 'Que objeto perto de você tem uma história interessante?',
    followUp: 'Como ele chegou até você?',
  ),
  IcebreakerPrompt(
    id: 'curiosidade-3',
    categoryId: 'curiosidades',
    text: 'Qual conselho você gostaria de ter ouvido há cinco anos?',
    followUp: 'O que teria mudado?',
  ),
  IcebreakerPrompt(
    id: 'curiosidade-4',
    categoryId: 'curiosidades',
    text: 'Qual lugar marcou uma fase importante da sua vida?',
    followUp: 'Que lembrança ficou desse lugar?',
  ),
  IcebreakerPrompt(
    id: 'curiosidade-5',
    categoryId: 'curiosidades',
    text: 'Que hábito simples você gostaria de compartilhar com mais pessoas?',
    followUp: 'Como esse hábito ajuda você?',
  ),
  IcebreakerPrompt(
    id: 'colaboracao-1',
    categoryId: 'colaboracao',
    text: 'Em que tipo de tarefa você gosta de ajudar outras pessoas?',
    followUp: 'Qual é o seu jeito de contribuir?',
  ),
  IcebreakerPrompt(
    id: 'colaboracao-2',
    categoryId: 'colaboracao',
    text: 'O que faz você se sentir parte de um grupo?',
    followUp: 'Dê um exemplo que funcionou bem.',
  ),
  IcebreakerPrompt(
    id: 'colaboracao-3',
    categoryId: 'colaboracao',
    text: 'Qual projeto você adoraria tirar do papel?',
    followUp: 'Que primeira ajuda faria diferença?',
  ),
  IcebreakerPrompt(
    id: 'colaboracao-4',
    categoryId: 'colaboracao',
    text: 'Como você prefere receber feedback?',
    followUp: 'O que torna uma conversa de feedback produtiva?',
  ),
  IcebreakerPrompt(
    id: 'colaboracao-5',
    categoryId: 'colaboracao',
    text: 'Qual qualidade você mais valoriza em uma equipe?',
    followUp: 'Quando você percebe essa qualidade na prática?',
  ),
];

PromptCategory categoryById(String id) => promptCategories.firstWhere(
  (category) => category.id == id,
  orElse: () => promptCategories.first,
);

List<IcebreakerPrompt> promptsByCategory(String id) => icebreakerPrompts
    .where((prompt) => prompt.categoryId == id)
    .toList(growable: false);
