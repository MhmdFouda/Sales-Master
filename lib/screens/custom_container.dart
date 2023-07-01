import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart';

class ReusableContainer extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? hight;
  final Color? color;
  final EdgeInsetsGeometry? margin;
  const ReusableContainer(
      {Key? key,
      required this.child,
      this.width,
      this.margin,
      this.color,
      this.hight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final backgroundColor = color ?? FluentTheme.of(context).cardColor;
    final brightness = FluentTheme.of(context).brightness;
    return Container(
      height: hight,
      width: width,
      padding: Platform.isWindows
          ? const EdgeInsets.all(10)
          : const EdgeInsets.all(4),
      margin: margin ??
          (Platform.isWindows
              ? const EdgeInsets.only(left: 30, right: 30, top: 15, bottom: 15)
              : const EdgeInsets.only(
                  left: 10, right: 10, top: 10, bottom: 10)),
      decoration: BoxDecoration(
        boxShadow: [
          color == null
              ? BoxShadow(
                  color: brightness.isDark
                      ? Colors.black
                      : Colors.grey.withOpacity(0.4),
                  offset: Offset.zero,
                  spreadRadius: 0,
                  blurRadius: 3.0,
                  blurStyle: BlurStyle.outer,
                )
              : BoxShadow(
                  color: brightness.isDark
                      ? Colors.black
                      : Colors.grey.withOpacity(0.4),
                  offset: Offset.zero,
                  spreadRadius: 0,
                  blurRadius: 3.0,
                  blurStyle: BlurStyle.inner,
                ),
        ],
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: child,
    );
  }
}
