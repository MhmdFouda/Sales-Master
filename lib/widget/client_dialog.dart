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
  final clientNameController = TextEditingController();
  final clientFirstNumController = TextEditingController();
  final clientSecNumController = TextEditingController();

  await showDialog(
    context: context,
    builder: (context) => ContentDialog(
      title: Text(title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextBox(
            controller: clientNameController,
            placeholder: update ? client!.name : context.loc.name,
          ),
          const SizedBox(
            height: 10,
          ),
          TextBox(
            keyboardType: TextInputType.phone,
            controller: clientFirstNumController,
            placeholder: update ? client!.phoneNumber : context.loc.phone,
          ),
          const SizedBox(
            height: 10,
          ),
          TextBox(
            keyboardType: TextInputType.phone,
            controller: clientSecNumController,
            placeholder: update ? client!.secPhoneNumber : context.loc.phone,
          ),
        ],
      ),
      actions: [
        FilledButton(
          child: Text(buttonTitle),
          onPressed: () {
            onPressed(
              Client(
                  name: clientNameController.text,
                  phoneNumber: clientFirstNumController.text,
                  secPhoneNumber: clientSecNumController.text),
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
