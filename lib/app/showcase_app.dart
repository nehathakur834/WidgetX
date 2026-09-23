import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widgetx_ui/widgetx_ui.dart';
import '../providers/theme_provider.dart';
import '../routing/app_router.dart';

class ShowcaseApp extends ConsumerWidget {
  const ShowcaseApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final accentIndex = ref.watch(accentIndexProvider);
    final seedColor = AccentIndexNotifier.accentColors[accentIndex];
    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      title: 'WidgetX UI',
      debugShowCheckedModeBanner: false,
      theme: WidgetXTheme.light(seedColor: seedColor),
      darkTheme: WidgetXTheme.dark(seedColor: seedColor),
      themeMode: themeMode,
      routerConfig: router,
    );
  }
}
