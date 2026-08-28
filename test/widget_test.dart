import 'package:conecta_turma/app.dart';
import 'package:conecta_turma/services/activity_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<ActivityStore> createStore() async {
  SharedPreferences.setMockInitialValues({});
  return ActivityStore(await SharedPreferences.getInstance());
}

void main() {
  testWidgets('exibe as categorias na página inicial', (tester) async {
    await tester.pumpWidget(ConectaTurmaApp(store: await createStore()));
    expect(find.text('Conecta Turma'), findsOneWidget);
    expect(find.text('Comece leve'), findsOneWidget);
    expect(find.text('Descubra histórias'), findsOneWidget);
    expect(find.text('Crie conexão'), findsOneWidget);
  });

  testWidgets('abre uma rodada usando rota nomeada', (tester) async {
    await tester.pumpWidget(ConectaTurmaApp(store: await createStore()));
    await tester.ensureVisible(find.text('Comece leve'));
    await tester.tap(find.text('Comece leve'));
    await tester.pumpAndSettle();
    expect(find.text('1 de 5'), findsOneWidget);
    expect(find.text('Respondemos! Próxima'), findsOneWidget);
    expect(find.byIcon(Icons.bookmark_border_rounded), findsOneWidget);
  });

  testWidgets('salva uma pergunta nos favoritos', (tester) async {
    await tester.pumpWidget(ConectaTurmaApp(store: await createStore()));
    await tester.ensureVisible(find.text('Comece leve'));
    await tester.tap(find.text('Comece leve'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Salvar nos favoritos'));
    await tester.pumpAndSettle();
    expect(find.byTooltip('Remover dos favoritos'), findsOneWidget);
  });

  testWidgets('rota desconhecida retorna ao início', (tester) async {
    await tester.pumpWidget(ConectaTurmaApp(store: await createStore()));
    Navigator.of(
      tester.element(find.text('Conecta Turma')),
    ).pushNamed('/rota-inexistente');
    await tester.pumpAndSettle();

    expect(find.text('Escolha o clima da conversa'), findsNWidgets(2));
  });

  testWidgets('concluir a rodada registra cinco respostas', (tester) async {
    final store = await createStore();
    await tester.pumpWidget(ConectaTurmaApp(store: store));
    await tester.ensureVisible(find.text('Comece leve'));
    await tester.tap(find.text('Comece leve'));
    await tester.pumpAndSettle();

    for (var index = 0; index < 5; index++) {
      await tester.tap(
        find.text(index == 4 ? 'Concluir rodada' : 'Respondemos! Próxima'),
      );
      await tester.pumpAndSettle();
    }

    expect(store.answeredCount, 5);
    expect(find.text('Rodada concluída!'), findsOneWidget);
  });
}
