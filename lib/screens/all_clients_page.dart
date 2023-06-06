import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fouda_pharma/localization/extension.dart';
import 'package:fouda_pharma/providers/client.dart';
import 'package:fouda_pharma/screens/client_info_page.dart';
import 'package:fouda_pharma/widget/client_dialog.dart';

class AllClientPage extends ConsumerWidget {
  const AllClientPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final clientList = ref.watch(asyncClientProvider);

    return ScaffoldPage(
      header: Padding(
        padding: const EdgeInsets.all(30),
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
                Button(
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
                    },
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 28,
            ),
          ],
        ),
      ),
      content: clientList.when(
          skipLoadingOnRefresh: false,
          data: (data) {
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 28.0,
                    vertical: 6,
                  ),
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                          color: FluentTheme.of(context).borderInputColor,
                          width: 1.5),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(FluentPageRoute(
                        builder: (context) =>
                            ClientInfoPage(client: data[index]),
                      ));
                    },
                    title: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(data[index].name),
                    ),
                    leading: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Icon(FluentIcons.contact),
                    ),
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
