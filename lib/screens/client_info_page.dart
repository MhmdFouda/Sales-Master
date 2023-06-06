import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fouda_pharma/localization/extension.dart';
import 'package:fouda_pharma/models/client.dart';
import 'package:fouda_pharma/providers/client.dart';
import 'package:fouda_pharma/widget/client_dialog.dart';
import 'package:fouda_pharma/widget/window_button.dart';
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
        bottomBar: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Button(
                onPressed: () => clientContentDialog(
                  context: context,
                  ref: ref,
                  client: client,
                  update: true,
                  title: context.loc.updateclient,
                  buttonTitle: context.loc.cansel,
                  onPressed: (updatedClient) {
                    ref.read(asyncClientProvider.notifier).updateClient(
                          updatedClient.copyWith(id: client.id),
                        );
                  },
                ),
                child: const Text('Edit'),
              ),
              const SizedBox(
                width: 20,
              ),
              Button(
                onPressed: () {
                  ref
                      .read(asyncClientProvider.notifier)
                      .deleteClient(client.id!);

                  Navigator.of(context).pop();
                },
                child: const Text('Delete'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
