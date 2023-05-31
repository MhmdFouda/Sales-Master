import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fouda_pharma/providers/client.dart';
import 'package:fouda_pharma/screens/client_info_page.dart';
import 'package:fouda_pharma/widget/add_client_button.dart';

class AllClientPage extends ConsumerWidget {
  const AllClientPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final clientList = ref.watch(asyncClientProvider);

    return ScaffoldPage(
      header: const Padding(
        padding: EdgeInsets.all(30),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Clients',
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                AddClientButton(),
              ],
            ),
            SizedBox(
              height: 28,
            ),
            // AutoSuggestBox<Client>.form(
            //     items: clientList.value!.map((client) {
            //   return AutoSuggestBoxItem<Client>(
            //       onSelected: () {
            //         Navigator.of(context).push(FluentPageRoute(
            //           builder: (context) => ClientInfoPage(client: client),
            //         ));
            //       },
            //       value: client,
            //       label: client.name);
            // }).toList())
          ],
        ),
      ),
      content: clientList.when(data: (data) {
        return ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 28.0,
                vertical: 6,
              ),
              child: Card(
                padding: const EdgeInsets.all(0),
                child: ListTile(
                  onPressed: () {
                    Navigator.of(context).push(FluentPageRoute(
                      builder: (context) => ClientInfoPage(client: data[index]),
                    ));
                  },
                  title: Text(data[index].name),
                  leading: const Icon(FluentIcons.contact),
                ),
              ),
            );
          },
        );
      }, error: (error, stackTrace) {
        return Text(error.toString());
      }, loading: () {
        return const Center(child: ProgressBar());
      }),
    );
  }
}
