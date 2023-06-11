import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fouda_pharma/localization/extension.dart';
import 'package:fouda_pharma/providers/auth.dart';
import 'package:fouda_pharma/widget/window_button.dart';
import 'package:window_manager/window_manager.dart';

class AuthPage extends ConsumerStatefulWidget {
  const AuthPage({super.key});

  @override
  ConsumerState<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends ConsumerState<AuthPage> with WindowListener {
  bool obscure = true;
  final eController = TextEditingController();
  final pController = TextEditingController();

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
    eController.dispose();
    pController.dispose();
    windowManager.removeListener(this);
    super.dispose();
  }

  void _init() async {
    await windowManager.setPreventClose(true);
  }

  @override
  Widget build(BuildContext context) {
    return NavigationView(
      appBar: NavigationAppBar(
        title: const DragToMoveArea(
          child: Align(
            alignment: AlignmentDirectional.centerStart,
            child: Center(child: Text('Sales Master')),
          ),
        ),
        actions: Platform.isWindows ? const WindowButtons() : null,
        automaticallyImplyLeading: false,
      ),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              const Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Sales Master',
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 32),
                    Text(
                      'Sales management system',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      'Designed by: Mhmd Fouda',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InfoLabel(
                        label: context.loc.signinmail,
                        child: TextBox(
                          enableSuggestions: true,
                          keyboardType: TextInputType.emailAddress,
                          controller: eController,
                          placeholder: context.loc.mail,
                          expands: false,
                        ),
                      ),
                      const SizedBox(height: 16),
                      InfoLabel(
                        label: context.loc.pass,
                        child: TextBox(
                          obscureText: obscure,
                          controller: pController,
                          placeholder: context.loc.pass,
                          expands: false,
                          suffix: Button(
                              onPressed: () {
                                setState(() {
                                  obscure = !obscure;
                                });
                              },
                              child: obscure
                                  ? const Icon(FluentIcons.red_eye)
                                  : const Icon(FluentIcons.hide3)),
                          suffixMode: OverlayVisibilityMode.editing,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 40),
          FilledButton(
            child: Text(context.loc.signin),
            onPressed: () {
              ref.read(
                signInProvider(
                  email: eController.text,
                  password: pController.text,
                ),
              );
            },
          ),
        ],
      ),
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
