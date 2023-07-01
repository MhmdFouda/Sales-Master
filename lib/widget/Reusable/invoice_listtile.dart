import 'package:fluent_ui/fluent_ui.dart';
import 'package:intl/intl.dart';

class ReusableListTile extends StatelessWidget {
  final double title;
  final String subtitle;

  final VoidCallback onDelete;

  const ReusableListTile({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final moneyFormat = NumberFormat.currency(locale: 'en_US', symbol: '\$');

    return ListTile(
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          moneyFormat.format(title),
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      title: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(subtitle),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(width: 20),
          IconButton(
            icon: const Icon(FluentIcons.delete),
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }
}
