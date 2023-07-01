// ignore_for_file: sort_child_properties_last

import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fouda_pharma/localization/extension.dart';
import 'package:fouda_pharma/models/invoice_model.dart';
import 'package:fouda_pharma/models/supplier.dart';
import 'package:fouda_pharma/providers/date_time_formater.dart';
import 'package:fouda_pharma/providers/invoices.dart';
import 'package:fouda_pharma/providers/supplier.dart';
import 'package:fouda_pharma/resources/extension.dart';
import 'package:fouda_pharma/screens/custom_container.dart';
import 'package:fouda_pharma/widget/Reusable/invoice_listtile.dart';

import 'package:fouda_pharma/widget/Reusable/phone.dart';
import 'package:fouda_pharma/widget/dialogs/supplier_dialog.dart';
import 'package:fouda_pharma/widget/window_button.dart';
import 'package:window_manager/window_manager.dart';

class SupplierInfoPage extends ConsumerWidget {
  final Supplier supplier;
  const SupplierInfoPage(this.supplier, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scaffoldBackgroundColor2 =
        FluentTheme.of(context).scaffoldBackgroundColor;
    final invoices = ref.watch(
      asyncInvoiceProvider(
          collectionName: 'suppliers', collectionId: supplier.id!),
    );

    return NavigationView(
        appBar: NavigationAppBar(
          height: Platform.isAndroid ? 25 : 56,
          title: const DragToMoveArea(
            child: Align(
              alignment: AlignmentDirectional.centerStart,
            ),
          ),
          actions: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: Platform.isWindows
                ? [
                    const WindowButtons(),
                  ]
                : [],
          ),
        ),
        content: ScaffoldPage(
          header: SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.3,
            child: ReusableContainer(
              child: Padding(
                padding: EdgeInsets.all(Platform.isWindows ? 28.0 : 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ReusableContainer(
                      margin: const EdgeInsets.all(0),
                      color: scaffoldBackgroundColor2,
                      child: const Text(
                        'بيانات المورد',
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      supplier.name,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    PhoneNumberWidget(
                      phoneNumber: supplier.phoneNumber.toString(),
                    ),
                    const SizedBox(height: 8),
                    PhoneNumberWidget(
                      phoneNumber: supplier.secPhoneNumber.toString(),
                    ),
                  ],
                ),
              ),
            ),
          ),
          content: invoices.when(
            data: (data) {
              double getTotalBalance() {
                double totalBalance = 0.0;
                if (data.isNotEmpty) {
                  for (var invoice in data) {
                    totalBalance += invoice.balance!;
                  }
                }
                return totalBalance;
              }

              double total = getTotalBalance();
              return ReusableContainer(
                width: MediaQuery.sizeOf(context).width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          FilledButton(
                            child: const Text('إضافة فاتورة'),
                            onPressed: () {
                              invoiceDialog(
                                  context: context,
                                  onPressed: (invoice) {
                                    addInvoice(ref, invoice, context, total);
                                  });
                            },
                          ),
                          ReusableContainer(
                            color:
                                FluentTheme.of(context).scaffoldBackgroundColor,
                            margin: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 10,
                            ),
                            child: Text(
                              total.toString(),
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    ListView.separated(
                      itemBuilder: (context, index) {
                        return ReusableListTile(
                          onDelete: () => deletInvoice(ref, data, index, total),
                          title: data[index].balance!,
                          subtitle: ref
                              .watch(dateFormaterProvider(data[index].date!)),
                        );
                      },
                      separatorBuilder: (context, index) => const Divider(),
                      itemCount: data.length,
                    ).expand()
                  ],
                ),
              );
            },
            error: (error, stackTrace) {
              return Center(
                child: Text(error.toString()),
              );
            },
            loading: () {
              return const Center(
                child: ProgressRing(),
              );
            },
          ),
          bottomBar: ReusableContainer(
            margin:
                const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 25),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Button(
                    onPressed: () {
                      supplierContentDialog(
                        supplier: supplier,
                        context: context,
                        ref: ref,
                        title: "مورد جديد",
                        buttonTitle: context.loc.add,
                        update: true,
                        onPressed: (newSupplier) {
                          ref
                              .read(asyncSupplierProvider.notifier)
                              .addSupplier(newSupplier);
                          Navigator.of(context).pop();
                        },
                      );
                    },
                    child: Text(context.loc.edite),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  FilledButton(
                    onPressed: () {
                      ref
                          .read(asyncSupplierProvider.notifier)
                          .deleteSupplier(supplier.id!)
                          .then((value) => ref.refresh(asyncSupplierProvider))
                          .then((value) => Navigator.of(context).pop());
                    },
                    child: Text(context.loc.delete),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  // delete invoice
  void deletInvoice(
    WidgetRef ref,
    List<Invoice> data,
    int index,
    double total,
  ) {
    ref
        .read(
          asyncInvoiceProvider(
            collectionName: 'suppliers',
            collectionId: supplier.id!,
          ).notifier,
        )
        .deleteinvoice(
          collectionId: supplier.id!,
          collectionName: 'suppliers',
          id: data[index].id!,
        )
        .then((value) => ref.refresh(
              asyncInvoiceProvider(
                collectionName: 'suppliers',
                collectionId: supplier.id!,
              ),
            ));
    ref
        .read(asyncSupplierProvider.notifier)
        .updateSupplier(
            supplier.copyWith(balance: total - data[index].balance!))
        .then((_) => ref.refresh(asyncSupplierProvider));
  }

  // add invoice
  void addInvoice(
    WidgetRef ref,
    Invoice invoice,
    BuildContext context,
    double total,
  ) {
    ref
        .read(asyncInvoiceProvider(
          collectionName: 'suppliers',
          collectionId: supplier.id!,
        ).notifier)
        .addinvoice(
            invoice: invoice,
            collectionId: supplier.id!,
            collectionName: 'suppliers')
        .then((_) => ref.refresh(
              asyncInvoiceProvider(
                collectionName: 'suppliers',
                collectionId: supplier.id!,
              ),
            ));
    ref
        .read(asyncSupplierProvider.notifier)
        .updateSupplier(supplier.copyWith(balance: total + invoice.balance!))
        .then((_) => ref.refresh(asyncSupplierProvider));
    Navigator.pop(context);
  }

  // invoice dialog
  Future<void> invoiceDialog({
    double? balance,
    required BuildContext context,
    required void Function(Invoice) onPressed,
  }) {
    double numberBoxValue = 0;

    return showDialog(
      context: context,
      builder: (context) {
        return ContentDialog(
          title: const Text('إضافة فاتورة'),
          content: NumberBox<double>(
            value: balance ?? numberBoxValue,
            onChanged: (value) {
              numberBoxValue = value ?? 0.0;
            },
            mode: SpinButtonPlacementMode.none,
          ),
          actions: [
            FilledButton(
              onPressed: () {
                onPressed(
                  Invoice(
                    balance: numberBoxValue,
                    date: DateTime.now(),
                  ),
                );
              },
              child: const Text('إضافة'),
            ),
            Button(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('إلغاء'),
            ),
          ],
        );
      },
    );
  }
}
