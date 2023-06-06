import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fouda_pharma/providers/client.dart';
import 'package:fouda_pharma/providers/order_provider.dart';

class DropDownClient extends ConsumerWidget {
  const DropDownClient({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final clientList = ref.watch(asyncClientProvider);
    final value = ref.watch(clientNameProvider);
    List<ComboBoxItem<String>> comboBoxClient = [];
    return clientList.when(
      data: (data) {
        for (var client in data) {
          comboBoxClient.add(
            ComboBoxItem<String>(
              value: client.name,
              child: Text(client.name),
            ),
          );
        }
        return SizedBox(
          width: double.infinity,
          child: ComboBox<String>(
            value: value,
            items: comboBoxClient.toList(),
            onChanged: (newvalue) {
              ref.read(clientNameProvider.notifier).changeClientName(newvalue!);
            },
          ),
        );
      },
      error: (error, stackTrace) {
        return const Center(child: Text('Error'));
      },
      loading: () {
        return const Center(child: ProgressRing());
      },
    );
  }
}
