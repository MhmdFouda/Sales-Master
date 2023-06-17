import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fouda_pharma/localization/extension.dart';
import 'package:fouda_pharma/providers/client.dart';
import 'package:fouda_pharma/screens/client_info_page.dart';
import 'package:fouda_pharma/widget/client_dialog.dart';
import 'package:fouda_pharma/widget/rec_widget.dart';

class AllClientPage extends ConsumerWidget {
  const AllClientPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final clientList = ref.watch(asyncClientProvider);

    return ScaffoldPage(
      header: Padding(
        padding: EdgeInsets.all(Platform.isWindows ? 28.0 : 12.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    context.loc.clients,
                    style: const TextStyle(
                      fontSize: 48,
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
                          .read(asyncClientProvider.notifier)
                          .addClient(newClient);
                      Navigator.of(context).pop();
                    },
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 28,
            ),
            AutoSuggestBox.form(items: [])
          ],
        ),
      ),
      content: clientList.when(
          skipLoadingOnRefresh: false,
          data: (data) {
            return GridView.builder(
              padding: EdgeInsets.all(Platform.isWindows ? 28.0 : 12.0),
              itemCount: data.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: Platform.isAndroid ? 3 : 4,
              ),
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.all(Platform.isWindows ? 12.0 : 6.0),
                  child: CustomInfoleWidget(
                    colorIndex: data[index].colorIndex,
                    phoneNumber: data[index].phoneNumber,
                    widgetType: WidgetType.client,
                    objectName: data[index].name,
                    onPressed: () {
                      Navigator.of(context).push(
                        FluentPageRoute(
                          builder: (context) =>
                              ClientInfoPage(client: data[index]),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          },
          error: (error, stackTrace) {
            return Text(error.toString());
          },
          loading: () {
            return const Center(child: ProgressBar());
          }),
    );
  }
}
