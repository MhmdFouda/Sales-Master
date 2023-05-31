import 'package:fluent_ui/fluent_ui.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fouda_pharma/providers/auth.dart';
import 'package:fouda_pharma/screens/navigation_view.dart';
import 'package:window_manager/window_manager.dart';

class AuthPage extends ConsumerStatefulWidget {
  const AuthPage({super.key});

  @override
  ConsumerState<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends ConsumerState<AuthPage> {
  final eController = TextEditingController();
  final pController = TextEditingController();
  @override
  void dispose() {
    eController.dispose();
    pController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NavigationView(
      appBar: const NavigationAppBar(
        title: DragToMoveArea(
          child: Align(
            alignment: AlignmentDirectional.centerStart,
            child: Center(child: Text('Fouda Pharma')),
          ),
        ),
        actions: WindowButtons(),
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
                      'Fouda pharma',
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 32),
                    Text(
                      'Store management system',
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
                        label: 'Enter your email:',
                        child: TextBox(
                          controller: eController,
                          placeholder: 'email',
                          expands: false,
                        ),
                      ),
                      const SizedBox(height: 16),
                      InfoLabel(
                        label: 'Enter your password:',
                        child: TextBox(
                          controller: pController,
                          placeholder: 'password',
                          expands: false,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 40),
          Button(
            child: const Text('Sign In'),
            onPressed: () {
              ref.read(signInProvider(
                  email: eController.text.toString(),
                  password: pController.text.toString()));
            },
          ),
          // Button(
          //   child: Text('out'),
          //   onPressed: () {},
          // )
        ],
      ),
    );
  }
}
