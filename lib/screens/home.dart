import 'package:fluent_ui/fluent_ui.dart';
import 'package:fouda_pharma/widget/search.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      header: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: SerchBar(),
      ),
      bottomBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FilledButton(
            child: const Icon(FluentIcons.add),
            onPressed: () {},
          ),
          FilledButton(
            child: const Icon(FluentIcons.reset),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
