import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
      child: const Text('Add Client'),
      onPressed: () => showContentDialog(context),
    );
  }

  void showContentDialog(BuildContext context) async {
    await showDialog<String>(
      context: context,
      builder: (context) => ContentDialog(
        title: const Text('Add New Client'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextBox(
              controller: clientNameController,
              placeholder: 'Client Name',
            ),
            const SizedBox(
              height: 10,
            ),
            TextBox(
              keyboardType: TextInputType.phone,
              controller: clientFirstNumController,
              placeholder: 'First Number',
            ),
            const SizedBox(
              height: 10,
            ),
            TextBox(
              keyboardType: TextInputType.phone,
              controller: clientSecNumController,
              placeholder: 'Second Number',
            ),
          ],
        ),
        actions: [
          Button(
            child: const Text('Save'),
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
            child: const Text('Cancel'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}
