import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fouda_pharma/localization/extension.dart';
import 'package:fouda_pharma/providers/auth.dart';
import 'package:fouda_pharma/providers/theme_provider.dart';
import 'package:fouda_pharma/screens/all_products.dart';
import 'package:fouda_pharma/screens/all_clients_page.dart';
import 'package:fouda_pharma/screens/all_orders.dart';
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
    if (Platform.isWindows) {
      windowManager.addListener(this);
      _init();
    }
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    super.dispose();
  }

  void _init() async {
    await windowManager.setPreventClose(true);
  }

  @override
  Widget build(BuildContext context) {
    final themeMod = ref.watch(themeDataProvider);
    final hourFormat = int.parse(DateFormat('H').format(DateTime.now()));

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
        title: Text(context.loc.product),
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
        actions: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(32)),
              child: SizedBox(
                height: 30,
                child: DropDownButton(
                  placement: FlyoutPlacementMode.topCenter,
                  trailing: null,
                  title: const Icon(FluentIcons.contact, size: 16),
                  items: [
                    MenuFlyoutItem(
                        leading: const Icon(FluentIcons.contact),
                        text: Text(
                            ref.watch(getUserEmailProvider).asData?.value ??
                                ''),
                        onPressed: () {}),
                    const MenuFlyoutSeparator(),
                    MenuFlyoutItem(
                        leading: const Icon(FluentIcons.settings),
                        text: const Text('setting'),
                        onPressed: () {}),
                    MenuFlyoutItem(
                        leading: const Icon(FluentIcons.sign_out),
                        text: const Text('log out'),
                        onPressed: () {
                          ref.read(signoutProvider);
                        }),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 8),
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
            Platform.isWindows ? const WindowButtons() : const SizedBox(),
          ],
        ),
        automaticallyImplyLeading: false,
      ),
      key: viewKey,
      pane: NavigationPane(
          header: (hourFormat >= 0 && hourFormat < 12)
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
              title: Text(context.loc.confirmcloce),
              content: Text(context.loc.sure),
              actions: [
                Button(
                  child: Text(context.loc.no),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                FilledButton(
                  child: Text(context.loc.yes),
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
