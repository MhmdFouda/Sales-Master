// ignore_for_file: sort_child_properties_last

import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fouda_pharma/localization/extension.dart';
import 'package:fouda_pharma/providers/client.dart';
import 'package:fouda_pharma/resources/extension.dart';
import 'package:fouda_pharma/screens/all_orders.dart';
import 'package:fouda_pharma/screens/custom_container.dart';
import 'package:fouda_pharma/widget/dialogs/client_dialog.dart';
import 'package:fouda_pharma/widget/Reusable/phone.dart';
import 'package:fouda_pharma/widget/Reusable/slider_widget.dart';
import 'package:fouda_pharma/widget/window_button.dart';
import 'package:window_manager/window_manager.dart';

class ClientInfoPage extends ConsumerWidget {
  const ClientInfoPage({
    super.key,
    required this.clientID,
  });
  final String clientID;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scaffoldBackgroundColor2 =
        FluentTheme.of(context).scaffoldBackgroundColor;
    final client =
        ref.watch(asyncClientsProvider.notifier).getClient(id: clientID);
    double? loan = ((client?.balance ?? 0) - (client?.credit ?? 0));

    return NavigationView(
        appBar: NavigationAppBar(
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
            child: SliderWidget(
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
                          'بيانات العميل',
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        client!.name,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      PhoneNumberWidget(
                        phoneNumber: client.phoneNumber.toString(),
                      ),
                      const SizedBox(height: 8),
                      PhoneNumberWidget(
                        phoneNumber: client.secPhoneNumber.toString(),
                      ),
                    ],
                  ),
                ),
              ),
              child2: ReusableContainer(
                child: Padding(
                  padding: EdgeInsets.all(Platform.isWindows ? 28.0 : 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ReusableContainer(
                        margin: const EdgeInsets.all(0),
                        color: scaffoldBackgroundColor2,
                        child: const Text(
                          'بيانات الدفع',
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        'المستحق  :     ${client.balance.toString()}',
                      ),
                      Text(
                        'المدفوع  :      ${client.credit.toString()}',
                      ),
                      Text(
                        'المتبقى   :      ${loan.toString()}',
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          content: SliderWidget(
            child2: const ReusableContainer(child: Text('')),
            child: ReusableContainer(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ReusableContainer(
                  color: FluentTheme.of(context).scaffoldBackgroundColor,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  child: const Text(
                    "طلبات العميل ",
                  ),
                ),
                OrdersList(
                  isAll: false,
                  clientName: client.name,
                ).expand(),
              ],
            )),
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
                      clientContentDialog(
                        context: context,
                        ref: ref,
                        client: client,
                        update: true,
                        title: context.loc.updateclient,
                        buttonTitle: context.loc.update,
                        onPressed: (updatedClient) {
                          ref
                              .read(asyncClientsProvider.notifier)
                              .updateClient(
                                updatedClient.copyWith(id: client.id),
                              )
                              .then((value) => ref
                                  .refresh(asyncClientsProvider.notifier)
                                  .getClient(id: clientID));

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
                          .read(asyncClientsProvider.notifier)
                          .deleteClient(client.id!)
                          .then((value) async =>
                              ref.refresh(asyncClientsProvider));
                      Navigator.of(context).pop();
                    },
                    child: Text(context.loc.delete),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
