import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widgetx_ui/widgetx_ui.dart';
import '../providers/theme_provider.dart';
import '../routing/app_router.dart';

class ShowcaseApp extends ConsumerStatefulWidget {
  const ShowcaseApp({super.key});

  @override
  ConsumerState<ShowcaseApp> createState() => _ShowcaseAppState();
}

class _ShowcaseAppState extends ConsumerState<ShowcaseApp> {
  @override
  void initState() {
    super.initState();
    // Make Flutter draw edge-to-edge so the system nav bar inset is
    // correctly reported via MediaQuery.paddingOf(context).bottom.
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarDividerColor: Colors.transparent,
    ));
  }

  @override
  Widget build(BuildContext context) {
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
