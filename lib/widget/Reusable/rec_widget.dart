import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fouda_pharma/providers/theme_provider.dart';
import 'package:fouda_pharma/resources/extension.dart';

class CustomInfoleWidget extends ConsumerWidget {
  final String objectName;
  final int? count;

  final VoidCallback onPressed;
  final int colorIndex;
  const CustomInfoleWidget({
    super.key,
    required this.objectName,
    this.count,
    required this.onPressed,
    required this.colorIndex,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color =
        ref.watch(themeDataProvider.notifier).getColor(context, colorIndex);
    return Material(
      elevation: 4.0, // Adjust the elevation value as needed
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(12.0),
      child: Ink(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(12.0),
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return Container(
                padding: const EdgeInsets.all(6.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      style: const TextStyle(fontSize: 12),
                      objectName,
                      maxLines: 3,
                      // overflow: TextOverflow.ellipsis,
                    ).wrapWithArabicDirectionality(context).expand(),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            count.toString(),
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
