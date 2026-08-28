import 'package:flutter/material.dart';

import 'screens/about_screen.dart';
import 'screens/favorites_screen.dart';
import 'screens/home_screen.dart';
import 'screens/round_screen.dart';
import 'services/activity_store.dart';

abstract final class AppRoutes {
  static const home = '/';
  static const round = '/round';
  static const favorites = '/favorites';
  static const about = '/about';
}

class ConectaTurmaApp extends StatelessWidget {
  const ConectaTurmaApp({super.key, required this.store});

  final ActivityStore store;

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: const Color(0xFF6557D9),
      brightness: Brightness.light,
      surface: const Color(0xFFF9F8FF),
    );

    return ActivityScope(
      store: store,
      child: MaterialApp(
        title: 'Conecta Turma',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: colorScheme,
          useMaterial3: true,
          scaffoldBackgroundColor: colorScheme.surface,
          textTheme: const TextTheme(
            displaySmall: TextStyle(
              fontWeight: FontWeight.w800,
              letterSpacing: -1.2,
              height: 1.05,
            ),
            headlineSmall: TextStyle(
              fontWeight: FontWeight.w700,
              letterSpacing: -0.4,
            ),
            titleLarge: TextStyle(fontWeight: FontWeight.w700),
          ),
          cardTheme: CardThemeData(
            elevation: 0,
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
              side: BorderSide(color: colorScheme.outlineVariant),
            ),
          ),
          filledButtonTheme: FilledButtonThemeData(
            style: FilledButton.styleFrom(
              minimumSize: const Size(0, 52),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              textStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        initialRoute: AppRoutes.home,
        onGenerateRoute: (settings) {
          final categoryArgument = settings.arguments;
          return switch (settings.name) {
            AppRoutes.home => MaterialPageRoute<void>(
              settings: settings,
              builder: (_) => const HomeScreen(),
            ),
            AppRoutes.round => MaterialPageRoute<void>(
              settings: settings,
              builder: (_) => RoundScreen(
                categoryId: categoryArgument is String
                    ? categoryArgument
                    : 'leves',
              ),
            ),
            AppRoutes.favorites => MaterialPageRoute<void>(
              settings: settings,
              builder: (_) => const FavoritesScreen(),
            ),
            AppRoutes.about => MaterialPageRoute<void>(
              settings: settings,
              builder: (_) => const AboutScreen(),
            ),
            _ => MaterialPageRoute<void>(
              settings: settings,
              builder: (_) => const HomeScreen(),
            ),
          };
        },
      ),
    );
  }
}
