import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fouda_pharma/localization/extension.dart';
import 'package:fouda_pharma/providers/supplier.dart';
import 'package:fouda_pharma/resources/extension.dart';
import 'package:fouda_pharma/screens/custom_container.dart';
import 'package:fouda_pharma/screens/supplier_info.dart';
import 'package:fouda_pharma/widget/dialogs/supplier_dialog.dart';

class SuppliersPage extends ConsumerWidget {
  const SuppliersPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final suppliertList = ref.watch(asyncSupplierProvider);
    return ScaffoldPage(
      header: ReusableContainer(
        child: Padding(
          padding: EdgeInsets.all(Platform.isWindows ? 28.0 : 12.0),
          child: Column(
            children: [
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      'الموردين',
                      style: TextStyle(
                        fontSize: 38,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  FilledButton(
                    child: Text(context.loc.add),
                    onPressed: () {
                      supplierContentDialog(
                        context: context,
                        ref: ref,
                        title: "مورد جديد",
                        buttonTitle: context.loc.add,
                        update: false,
                        onPressed: (newSupplier) {
                          ref
                              .read(asyncSupplierProvider.notifier)
                              .addSupplier(newSupplier);
                          Navigator.of(context).pop();
                        },
                      );
                    },
                  )
                ],
              ),
              const SizedBox(
                height: 28,
              ),
              AutoSuggestBox.form(
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: FluentTheme.of(context).accentColor,
                      ),
                      borderRadius: BorderRadius.circular(6)),
                  items: const [])
            ],
          ),
        ),
      ),
      content: suppliertList.when(data: (data) {
        String calculateTotalBalance() {
          double totalBalance = 0.0;

          for (var supplier in data) {
            totalBalance += supplier.balance!;
          }

          return totalBalance.toString();
        }

        List<Widget> children = [
          ReusableContainer(
            child: ListView.separated(
              itemBuilder: (context, index) {
                return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: FluentTheme.of(context).accentColor,
                      radius: 18,
                      child: Text(
                        (index + 1).toString(),
                      ),
                    ),
                    title: Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text(
                        data[index].name,
                      ),
                    ),
                    trailing: Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text(data[index].phoneNumber ?? ""),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                        FluentPageRoute(
                          builder: (context) => SupplierInfoPage(data[index]),
                        ),
                      );
                    });
              },
              separatorBuilder: (context, index) {
                return const Divider();
              },
              itemCount: data.length,
            ),
          ).expand(),
          ReusableContainer(
            width: MediaQuery.sizeOf(context).width,
            child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'إجمالى حساب الموردين ',
                      style: TextStyle(fontSize: 28),
                    ),
                    Center(
                      child: Text(
                        "${calculateTotalBalance()} ج م",
                        style: const TextStyle(
                          fontSize: 35,
                        ),
                      ),
                    ).expand(),
                  ],
                )),
          ).expand(),
        ];
        if (Platform.isWindows) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: children,
          );
        } else {
          return Column(
            children: children,
          );
        }
      }, error: (error, stackTrace) {
        return Text(error.toString());
      }, loading: () {
        return const Center(child: ProgressBar());
      }),
      bottomBar: const SizedBox(
        height: 15,
      ),
    );
  }
}
