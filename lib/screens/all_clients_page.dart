import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fouda_pharma/localization/extension.dart';
import 'package:fouda_pharma/providers/client.dart';
import 'package:fouda_pharma/resources/extension.dart';
import 'package:fouda_pharma/screens/client_info_page.dart';
import 'package:fouda_pharma/screens/custom_container.dart';
import 'package:fouda_pharma/widget/charts/client_chart.dart';
import 'package:fouda_pharma/widget/dialogs/client_dialog.dart';
import 'package:fouda_pharma/widget/Reusable/slider_widget.dart';

class AllClientPage extends ConsumerWidget {
  const AllClientPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final clientList = ref.watch(asyncClientsProvider);

    return ScaffoldPage(
      resizeToAvoidBottomInset: false,
      header: ReusableContainer(
        child: Padding(
          padding: EdgeInsets.all(Platform.isWindows ? 28.0 : 12.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      context.loc.clients,
                      style: const TextStyle(
                        fontSize: 38,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  FilledButton(
                    child: Text(context.loc.add),
                    onPressed: () => clientContentDialog(
                      context: context,
                      ref: ref,
                      title: context.loc.newclient,
                      buttonTitle: context.loc.add,
                      update: false,
                      onPressed: (newClient) {
                        ref
                            .read(asyncClientsProvider.notifier)
                            .addClient(newClient)
                            .then((value) => ref.refresh(asyncClientsProvider));
                        Navigator.of(context).pop();
                      },
                    ),
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
      content: clientList.when(data: (data) {
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
                          builder: (context) =>
                              ClientInfoPage(clientID: data[index].id!),
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
          const ReusableContainer(
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: SliderWidget(
                child: OrderChart(),
                // child: OrderChart(),
              ),
            ),
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
        height: 10,
      ),
    );
  }
}
