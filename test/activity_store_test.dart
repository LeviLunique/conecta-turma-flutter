import 'package:conecta_turma/services/activity_store.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  test('normaliza favoritos e progresso carregados', () async {
    SharedPreferences.setMockInitialValues({
      'favorite_prompt_ids': ['leve-2', 'leve-1', 'leve-2', ''],
      'answered_prompt_count': -3,
    });
    final store = ActivityStore(await SharedPreferences.getInstance());

    expect(store.favoriteIds.toList(), ['leve-1', 'leve-2']);
    expect(store.answeredCount, 0);
  });

  test('persiste favoritos únicos em ordem estável', () async {
    SharedPreferences.setMockInitialValues({});
    final preferences = await SharedPreferences.getInstance();
    final store = ActivityStore(preferences);

    await store.toggleFavorite('leve-2');
    await store.toggleFavorite('leve-1');

    expect(store.favoriteIds.toList(), ['leve-1', 'leve-2']);
    expect(
      preferences.getStringList('favorite_prompt_ids'),
      ['leve-1', 'leve-2'],
    );
  });

  test('persiste cada resposta confirmada', () async {
    SharedPreferences.setMockInitialValues({});
    final preferences = await SharedPreferences.getInstance();
    final store = ActivityStore(preferences);

    await store.recordAnswer();
    await store.recordAnswer();

    expect(store.answeredCount, 2);
    expect(preferences.getInt('answered_prompt_count'), 2);
  });
}
