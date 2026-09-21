import 'package:flutter/material.dart';
import '../screens/home_screen.dart';
import '../screens/foundations_screen.dart';
import '../screens/buttons_screen.dart';
import '../screens/inputs_screen.dart';
import '../screens/cards_screen.dart';
import '../screens/feedback_screen.dart';
import '../screens/layout_screen.dart';

abstract final class AppRouter {
  static Map<String, WidgetBuilder> get routes => {
        '/': (_) => const HomeScreen(),
        '/foundations': (_) => const FoundationsScreen(),
        '/buttons': (_) => const ButtonsScreen(),
        '/inputs': (_) => const InputsScreen(),
        '/cards': (_) => const CardsScreen(),
        '/feedback': (_) => const FeedbackScreen(),
        '/layout': (_) => const LayoutScreen(),
      };
}
