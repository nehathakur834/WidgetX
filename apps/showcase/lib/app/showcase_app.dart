import 'package:flutter/material.dart';
import 'package:widgetx_ui/widgetx_ui.dart';
import '../navigation/app_router.dart';
import '../shared/theme_controller.dart';

class ShowcaseApp extends StatefulWidget {
  const ShowcaseApp({super.key});

  @override
  State<ShowcaseApp> createState() => _ShowcaseAppState();
}

class _ShowcaseAppState extends State<ShowcaseApp> {
  ThemeMode _themeMode = ThemeMode.system;

  void _setThemeMode(ThemeMode mode) {
    setState(() => _themeMode = mode);
  }

  @override
  Widget build(BuildContext context) {
    return ThemeController(
      themeMode: _themeMode,
      onThemeModeChanged: _setThemeMode,
      child: MaterialApp(
        title: 'WidgetX UI',
        debugShowCheckedModeBanner: false,
        theme: WidgetXTheme.light(),
        darkTheme: WidgetXTheme.dark(),
        themeMode: _themeMode,
        initialRoute: '/',
        routes: AppRouter.routes,
      ),
    );
  }
}
