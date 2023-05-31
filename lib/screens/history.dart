import 'package:fluent_ui/fluent_ui.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScaffoldPage(
      header: Padding(
        padding: EdgeInsets.all(30),
        child: Row(
          children: [
            Expanded(
              child: Text(
                'Orders History',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
