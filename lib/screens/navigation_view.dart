import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fouda_pharma/localization/extension.dart';
import 'package:fouda_pharma/providers/theme_provider.dart';
import 'package:fouda_pharma/screens/all_products.dart';
import 'package:fouda_pharma/screens/all_client_page.dart';
import 'package:fouda_pharma/screens/history.dart';
import 'package:fouda_pharma/screens/home.dart';
import 'package:fouda_pharma/screens/setting.dart';
import 'package:fouda_pharma/widget/window_button.dart';
import 'package:intl/intl.dart';
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
    final hour = int.parse(DateFormat('H').format(DateTime.now()));

    List<NavigationPaneItem> items = [
      PaneItemSeparator(),
      PaneItem(
        icon: const Icon(
          FluentIcons.home,
        ),
        title: Text(context.loc.home),
        body: const HomePage(),
      ),
      PaneItem(
        icon: const Icon(
          FluentIcons.contact,
        ),
        title: Text(context.loc.clients),
        body: const AllClientPage(),
      ),
      PaneItem(
        icon: const Icon(
          FluentIcons.product,
        ),
        title: Text(context.loc.products),
        body: const AllProductList(),
      ),
      PaneItem(
        icon: const Icon(
          FluentIcons.history,
        ),
        title: Text(context.loc.history),
        body: const HistoryPage(),
      ),
    ];

    return NavigationView(
      appBar: NavigationAppBar(
        title: DragToMoveArea(
          child: Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text(context.loc.appTitle),
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
          header: (hour >= 0 && hour < 12)
              ? Text(context.loc.mornning)
              : Text(context.loc.evenning),
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
              title: Text(context.loc.setting),
              body: const SettingPage(),
            ),
          ]),
    );
  }

  @override
  void onWindowClose() async {
    bool isPreventClose = await windowManager.isPreventClose();
    if (isPreventClose) {
      if (context.mounted) {
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
}
