import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fouda_pharma/localization/extension.dart';
import 'package:fouda_pharma/models/client.dart';

void clientContentDialog({
  required final BuildContext context,
  required final WidgetRef ref,
  required final String title,
  required final String buttonTitle,
  required void Function(Client) onPressed,
  required final bool update,
  final Client? client,
}) async {
  final clientNameController = TextEditingController(
    text: update ? client!.name : null,
  );
  final clientFirstNumController = TextEditingController(
    text: update ? client!.phoneNumber : null,
  );
  final clientSecNumController = TextEditingController(
    text: update ? client!.secPhoneNumber : null,
  );

  await showDialog(
    context: context,
    builder: (context) => ContentDialog(
      title: Text(title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: Text(context.loc.name),
            title: TextBox(
              controller: clientNameController,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          ListTile(
            leading: Text(context.loc.phone),
            title: TextBox(
              keyboardType: TextInputType.phone,
              controller: clientFirstNumController,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          ListTile(
            leading: Text(context.loc.phone),
            title: TextBox(
              keyboardType: TextInputType.phone,
              controller: clientSecNumController,
            ),
          ),
        ],
      ),
      actions: [
        FilledButton(
          child: Text(buttonTitle),
          onPressed: () {
            onPressed(
              Client(
                name: clientNameController.text.isNotEmpty
                    ? clientNameController.text
                    : '',
                phoneNumber: clientFirstNumController.text.isNotEmpty
                    ? clientFirstNumController.text
                    : '',
                secPhoneNumber: clientSecNumController.text.isNotEmpty
                    ? clientSecNumController.text
                    : '',
                balance: 0.0,
                credit: 0.0,
              ),
            );
          },
        ),
        Button(
          child: Text(context.loc.cansel),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    ),
  );
  clientNameController.dispose();
  clientFirstNumController.dispose();
  clientSecNumController.dispose();
}
