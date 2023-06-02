// ignore_for_file: use_build_context_synchronously

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fouda_pharma/providers/theme_provider.dart';
import 'package:fouda_pharma/screens/all_products.dart';
import 'package:fouda_pharma/screens/all_client_page.dart';
import 'package:fouda_pharma/screens/history.dart';
import 'package:fouda_pharma/screens/home.dart';
import 'package:fouda_pharma/screens/setting.dart';
import 'package:fouda_pharma/widget/window_button.dart';
import 'package:window_manager/window_manager.dart';

class NavigationPage extends ConsumerStatefulWidget {
  const NavigationPage({super.key});

  @override
  ConsumerState<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends ConsumerState<NavigationPage>
    with WindowListener {
  final viewKey = GlobalKey<NavigationViewState>();
  int index = 0;
  @override
  void initState() {
    super.initState();
    windowManager.addListener(this);
    _init();
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    super.dispose();
  }

  void _init() async {
    // Add this line to override the default close handler
    await windowManager.setPreventClose(true);
  }

  @override
  Widget build(BuildContext context) {
    final themeMod = ref.watch(themeDataProvider);
    return NavigationView(
      appBar: NavigationAppBar(
        title: const DragToMoveArea(
          child: Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text('Fouda Pharma'),
          ),
        ),
        actions: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          Padding(
            padding: const EdgeInsetsDirectional.only(end: 8.0),
            child: ToggleSwitch(
              content: const Text('Dark Mode'),
              checked: themeMod == ThemeMode.dark,
              onChanged: (value) {
                ref.read(themeDataProvider.notifier).changeTheme(value);
              },
            ),
          ),
          const WindowButtons(),
        ]),
        automaticallyImplyLeading: false,
      ),
      key: viewKey,
      pane: NavigationPane(
          header: const Text('Hello User'),
          selected: index,
          onChanged: (value) => setState(() => index = value),
          displayMode: PaneDisplayMode.auto,
          items: items,
          footerItems: [
            PaneItemSeparator(),
            PaneItem(
              icon: const Icon(
                FluentIcons.settings,
              ),
              title: const Text('Settings'),
              body: const SettingPage(),
            ),
          ]),
    );
  }

  @override
  void onWindowClose() async {
    // ignore: no_leading_underscores_for_local_identifiers
    bool _isPreventClose = await windowManager.isPreventClose();
    if (_isPreventClose) {
      showDialog(
        context: context,
        builder: (_) {
          return ContentDialog(
            title: const Text('Are you sure you want to close this window?'),
            actions: [
              FilledButton(
                child: const Text('No'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FilledButton(
                child: const Text('Yes'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  await windowManager.destroy();
                },
              ),
            ],
          );
        },
      );
    }
  }
}

List<NavigationPaneItem> items = [
  PaneItemSeparator(),
  PaneItem(
    icon: const Icon(
      FluentIcons.home,
    ),
    title: const Text('Home'),
    body: const HomePage(),
  ),
  PaneItem(
    icon: const Icon(
      FluentIcons.contact,
    ),
    title: const Text('Client Panel'),
    body: const AllClientPage(),
  ),
  PaneItem(
    icon: const Icon(
      FluentIcons.product,
    ),
    title: const Text('All Products'),
    body: const AllProductList(),
  ),
  PaneItem(
    icon: const Icon(
      FluentIcons.history,
    ),
    title: const Text('Orders History'),
    body: const HistoryPage(),
  ),
];
