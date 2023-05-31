import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fouda_pharma/models/client.dart';
import 'package:fouda_pharma/screens/navigation_view.dart';
import 'package:window_manager/window_manager.dart';

class ClientInfoPage extends ConsumerWidget {
  const ClientInfoPage({
    super.key,
    required this.client,
  });
  final Client client;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return NavigationView(
      appBar: const NavigationAppBar(
        title: DragToMoveArea(
          child: Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text('Fouda Pharma'),
          ),
        ),
        actions: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          WindowButtons(),
        ]),
      ),
      content: ScaffoldPage(
        header: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                client.name,
                style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 26,
              ),
              ListTile(
                leading: const Icon(
                  FluentIcons.phone,
                  size: 30,
                ),
                title: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    client.phoneNumber.toString(),
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(
                  FluentIcons.phone,
                  size: 30,
                ),
                title: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    client.secPhoneNumber.toString(),
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}