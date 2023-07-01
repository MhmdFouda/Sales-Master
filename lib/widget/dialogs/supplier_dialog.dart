import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fouda_pharma/localization/extension.dart';

import 'package:fouda_pharma/models/invoice_model.dart';
import 'package:fouda_pharma/models/supplier.dart';

void supplierContentDialog({
  required final BuildContext context,
  required final WidgetRef ref,
  required final String title,
  required final String buttonTitle,
  required void Function(Supplier) onPressed,
  required final bool update,
  final Supplier? supplier,
}) async {
  final supplierNameController = TextEditingController(
    text: update ? supplier!.name : null,
  );
  final supplierFirstNumController = TextEditingController(
    text: update ? supplier!.phoneNumber : null,
  );
  final supplierSecNumController = TextEditingController(
    text: update ? supplier!.secPhoneNumber : null,
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
              controller: supplierNameController,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          ListTile(
            leading: Text(context.loc.phone),
            title: TextBox(
              keyboardType: TextInputType.phone,
              controller: supplierFirstNumController,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          ListTile(
            leading: Text(context.loc.phone),
            title: TextBox(
              keyboardType: TextInputType.phone,
              controller: supplierSecNumController,
            ),
          ),
        ],
      ),
      actions: [
        FilledButton(
          child: Text(buttonTitle),
          onPressed: () {
            onPressed(
              Supplier(
                name: supplierNameController.text.isNotEmpty
                    ? supplierNameController.text
                    : '',
                phoneNumber: supplierFirstNumController.text.isNotEmpty
                    ? supplierFirstNumController.text
                    : '',
                secPhoneNumber: supplierSecNumController.text.isNotEmpty
                    ? supplierSecNumController.text
                    : '',
                balance: 0.0,
                invoices: <Invoice>[],
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
  supplierNameController.dispose();
  supplierFirstNumController.dispose();
  supplierSecNumController.dispose();
}
