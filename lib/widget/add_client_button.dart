import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fouda_pharma/localization/extension.dart';
import 'package:fouda_pharma/models/client.dart';
import 'package:fouda_pharma/providers/client.dart';

class AddClientButton extends ConsumerStatefulWidget {
  const AddClientButton({
    super.key,
  });

  @override
  ConsumerState<AddClientButton> createState() => _AddClientButton();
}

class _AddClientButton extends ConsumerState<AddClientButton> {
  final clientNameController = TextEditingController();
  final clientFirstNumController = TextEditingController();
  final clientSecNumController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Button(
      child: Text(context.loc.add),
      onPressed: () => showContentDialog(context),
    );
  }

  void showContentDialog(BuildContext context) async {
    await showDialog<String>(
      context: context,
      builder: (context) => ContentDialog(
        title: Text(context.loc.newclient),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextBox(
              controller: clientNameController,
              placeholder: context.loc.name,
            ),
            const SizedBox(
              height: 10,
            ),
            TextBox(
              keyboardType: TextInputType.phone,
              controller: clientFirstNumController,
              placeholder: context.loc.phone,
            ),
            const SizedBox(
              height: 10,
            ),
            TextBox(
              keyboardType: TextInputType.phone,
              controller: clientSecNumController,
              placeholder: context.loc.phone,
            ),
          ],
        ),
        actions: [
          Button(
            child: Text(context.loc.add),
            onPressed: () {
              ref.read(asyncClientProvider.notifier).addProduct(
                    Client(
                        name: clientNameController.text,
                        phoneNumber: clientFirstNumController.text,
                        secPhoneNumber: clientSecNumController.text),
                  );
              Navigator.pop(context);
              // Delete file here
            },
          ),
          FilledButton(
            child: Text(context.loc.cansel),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}
