import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

extension ColorExtension on Color {
  Color generateShade(BuildContext context, double amount) {
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

extension NullableCurrencyFormatting on double? {
  String formatAsCurrency({
    String symbol = '\$', // Customize the currency symbol as needed
    int decimalDigits = 2, // Specify the number of decimal digits to display
  }) {
    if (this == null) {
      return '';
    }
    final currencyFormatter = intl.NumberFormat.currency(
      locale: 'en_US',
      symbol: symbol,
      decimalDigits: decimalDigits,
    );
    return currencyFormatter.format(this!);
  }
}
