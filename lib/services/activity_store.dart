import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ActivityStore extends ChangeNotifier {
  ActivityStore(this._preferences)
    : _favoriteIds = _loadFavoriteIds(_preferences),
      _answeredCount = _loadAnsweredCount(_preferences);

  static const _favoritesKey = 'favorite_prompt_ids';
  static const _answeredKey = 'answered_prompt_count';

  final SharedPreferences _preferences;
  final Set<String> _favoriteIds;
  int _answeredCount;

  Set<String> get favoriteIds => Set.unmodifiable(_sortedFavoriteIds());
  int get answeredCount => _answeredCount;

  bool isFavorite(String promptId) => _favoriteIds.contains(promptId);

  Future<void> toggleFavorite(String promptId) async {
    if (!_favoriteIds.remove(promptId)) {
      _favoriteIds.add(promptId);
    }
    await _preferences.setStringList(
      _favoritesKey,
      _sortedFavoriteIds(),
    );
    notifyListeners();
  }

  Future<void> recordAnswer() async {
    _answeredCount += 1;
    await _preferences.setInt(_answeredKey, _answeredCount);
    notifyListeners();
  }

  static Set<String> _loadFavoriteIds(SharedPreferences preferences) {
    final ids = preferences
        .getStringList(_favoritesKey)
        ?.where((id) => id.isNotEmpty)
        .toSet()
        .toList(growable: true);
    ids?.sort();
    return ids == null ? <String>{} : ids.toSet();
  }

  static int _loadAnsweredCount(SharedPreferences preferences) {
    final count = preferences.getInt(_answeredKey) ?? 0;
    return count < 0 ? 0 : count;
  }

  List<String> _sortedFavoriteIds() {
    final ids = _favoriteIds.toList(growable: true)..sort();
    return ids;
  }
}

class ActivityScope extends InheritedNotifier<ActivityStore> {
  const ActivityScope({
    super.key,
    required ActivityStore store,
    required super.child,
  }) : super(notifier: store);

  static ActivityStore of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<ActivityScope>();
    assert(scope != null, 'ActivityScope não encontrado na árvore.');
    return scope!.notifier!;
  }
}
