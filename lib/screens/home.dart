import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      header: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: SearchBar(
          constraints: BoxConstraints(),
          shape: MaterialStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(6),
              ),
            ),
          ),
          elevation: MaterialStatePropertyAll(0),
          hintText: 'Search for products...',
        ),
      ),
      content: Container(
        margin: const EdgeInsets.only(
          left: 15,
          right: 15,
          bottom: 60,
          top: 15,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceVariant,
          borderRadius: BorderRadius.circular(6),
        ),
      ),
    );
  }
}
