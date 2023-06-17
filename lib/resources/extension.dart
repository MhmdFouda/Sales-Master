import 'package:flutter/material.dart';

extension ColorExtension on Color {
  Color generateShade(BuildContext context, {double amount = 0.12}) {
    final Brightness brightness = Theme.of(context).brightness;
    final double adjustedAmount =
        brightness == Brightness.dark ? -amount : amount;

    final HSLColor hslColor = HSLColor.fromColor(this);
    final HSLColor adjustedColor = hslColor.withLightness(
      hslColor.lightness +
          (adjustedAmount < 0 ? adjustedAmount.abs() : -adjustedAmount),
    );

    return adjustedColor.toColor();
  }
}

extension TextExtension on Text {
  Widget wrapWithArabicDirectionality(BuildContext context) {
    final bool isArabic = data != null &&
        RegExp(r'[\u0600-\u06FF\u0750-\u077F\u08A0-\u08FF\uFB50-\uFDCF\uFDF0-\uFDFF\uFE70-\uFEFF]')
            .hasMatch(data!);

    final TextDirection textDirection =
        isArabic ? TextDirection.rtl : TextDirection.ltr;

    return Directionality(
      textDirection: textDirection,
      child: this,
    );
  }
}

extension ExpandWidgetVertically on Widget {
  Widget expand() {
    return Expanded(
      child: this,
    );
  }
}
