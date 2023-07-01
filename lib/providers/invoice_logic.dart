import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fouda_pharma/models/order.dart';
import 'package:flutter/services.dart';
import 'package:fouda_pharma/providers/date_time_formater.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart' as pdf;
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:printing/printing.dart';

Future<void> generateInvoice(
    Order order, BuildContext context, WidgetRef ref) async {
  // Load font file data from assets
  final ByteData fontData = await rootBundle.load("assets/fonts/arabic.ttf");
  //Create an instance of PdfTrueTypeFont
  final Uint8List arabicFontBytes = fontData.buffer.asUint8List();

  //Create a PDF document.
  final PdfDocument document = PdfDocument();
  //Add page to the PDF
  final PdfPage page = document.pages.add();
  //Get page client size
  final Size pageSize = page.getClientSize();

  //Draw rectangle
  page.graphics.drawRectangle(
      bounds: Rect.fromLTWH(0, 0, pageSize.width, pageSize.height),
      pen: PdfPen(PdfColor(142, 170, 219)));
  //Generate PDF grid.
  final PdfGrid grid = getGrid(order, arabicFontBytes);
  //Draw the header section by creating text element
  final PdfLayoutResult result =
      drawHeader(page, pageSize, grid, arabicFontBytes, order);
  //Draw grid
  drawGrid(page, grid, result, arabicFontBytes);
  //Add invoice footer
  // drawFooter(page, pageSize, arabicFontBytes);
  //Save the PDF document
  final List<int> bytes = document.saveSync();
  //Dispose the document.
  document.dispose();
  //Save and launch the file.
  if (context.mounted) {
    await saveAndLaunchFile(bytes, 'Invoice.pdf', context, ref);
  }
}

// save file as pdf and launch it in android

Future<void> saveAndLaunchFile(List<int> bytes, String fileName,
    BuildContext context, WidgetRef ref) async {
  final Directory directory = await getApplicationSupportDirectory();
  final date = DateTime.now();
  final dateFormated = ref.watch(dateFormaterProvider(date));
  final path = directory.path;
  final file = File('$path/$fileName');
  await file.writeAsBytes(bytes, flush: true);
  if (Platform.isAndroid || Platform.isIOS) {
    // Open PDF within the app using flutter_pdfview
    if (context.mounted) {
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PdfPreview(
            pdfFileName: 'SalesMaster-$dateFormated.pdf',
            previewPageMargin: const EdgeInsets.all(2),
            canDebug: false,
            canChangeOrientation: false,
            padding: const EdgeInsets.only(
              top: 150,
            ),

            build: (pdf.PdfPageFormat format) => file.readAsBytesSync(),
            // ... other properties for PDFView
          ),
        ),
      );
    }
  } else if (Platform.isWindows) {
    await Process.run('start', <String>['$path\\$fileName'], runInShell: true);
  } else if (Platform.isMacOS) {
    await Process.run('open', <String>['$path/$fileName'], runInShell: true);
  } else if (Platform.isLinux) {
    await Process.run('xdg-open', <String>['$path/$fileName'],
        runInShell: true);
  }
}

//Draws the invoice header
PdfLayoutResult drawHeader(PdfPage page, Size pageSize, PdfGrid grid,
    Uint8List arabicFontBytes, Order order) {
  // Create a PdfFont using the loaded font file data
  final PdfFont arabicFont = PdfTrueTypeFont(arabicFontBytes, 12);
  final PdfFont arabicFontTitle = PdfTrueTypeFont(arabicFontBytes, 18);
  final total = order.totalPrice;
  //Draw rectangle
  page.graphics.drawRectangle(
      brush: PdfSolidBrush(PdfColor(91, 126, 215)),
      bounds: Rect.fromLTWH(0, 0, pageSize.width - 115, 50));
  //Draw string
  page.graphics.drawString(
    'الإجمالى :  $total جنيه ',
    arabicFontTitle,
    brush: PdfBrushes.white,
    bounds: Rect.fromLTWH(25, 0, pageSize.width - 115, 50),
    format: PdfStringFormat(
      textDirection: PdfTextDirection.rightToLeft,
      lineAlignment: PdfVerticalAlignment.middle,
    ),
  );

  page.graphics.drawRectangle(
      bounds: Rect.fromLTWH(300, 0, pageSize.width - 300, 50),
      brush: PdfSolidBrush(PdfColor(65, 104, 205)));

  //Draw string
  page.graphics.drawString('Mahmoud Fouda ', arabicFontTitle,
      brush: PdfBrushes.white,
      bounds: Rect.fromLTWH(355, 0, pageSize.width - 355, 50),
      format: PdfStringFormat(
        textDirection: PdfTextDirection.rightToLeft,
        lineAlignment: PdfVerticalAlignment.middle,
      ));
  //Create data foramt and convert it to text.
  final DateFormat format = DateFormat.yMMMMd('ar');
  const String footerContent =
      // ignore: leading_newlines_in_multiline_strings
      "Mahmoud Fouda\n01157847681\nmhmdfoudaa@gmail.com";
  final String invoiceNumber =
      'فاتورة رقم: 2058557939\r\nبتاريخ: ${format.format(DateTime.now())}';
  final Size contentSize = arabicFont.measureString(invoiceNumber);

  // client Name !provide client name from Order
  final String clientName = order.clientName;
  String address =
      '''بتاريخ: ${format.format(DateTime.now())}  \r\n$clientName  ''';

  PdfTextElement(
    text: footerContent,
    font: arabicFont,
    format: PdfStringFormat(
      textDirection: PdfTextDirection.rightToLeft,
    ),
  ).draw(
      page: page,
      bounds: Rect.fromLTWH(pageSize.width - (contentSize.width + 30), 70,
          contentSize.width + 30, pageSize.height - 70));

  return PdfTextElement(
    text: address,
    font: arabicFont,
    format: PdfStringFormat(
      textDirection: PdfTextDirection.rightToLeft,
    ),
  ).draw(
      page: page,
      bounds: Rect.fromLTWH(30, 70, pageSize.width - (contentSize.width + 30),
          pageSize.height - 70))!;
}

//Draws the grid
void drawGrid(PdfPage page, PdfGrid grid, PdfLayoutResult result,
    Uint8List arabicFontBytes) {
  // Create a PdfFont using the loaded font file data
  // final PdfFont arabicFont = PdfTrueTypeFont(
  //   arabicFontBytes,
  //   12,
  //   style: PdfFontStyle.bold,
  // );
  // Rect? totalPriceCellBounds;
  // Rect? quantityCellBounds;
  //Invoke the beginCellLayout event.
  // grid.beginCellLayout = (Object sender, PdfGridBeginCellLayoutArgs args) {
  //   final PdfGrid grid = sender as PdfGrid;
  //   if (args.cellIndex == grid.columns.count - 1) {
  //     totalPriceCellBounds = args.bounds;
  //   } else if (args.cellIndex == grid.columns.count - 2) {
  //     quantityCellBounds = args.bounds;
  //   }
  // };
  //Draw the PDF grid and get the result.
  result = grid.draw(
      page: page, bounds: Rect.fromLTWH(0, result.bounds.bottom + 40, 0, 0))!;

  //Draw grand total.
  // page.graphics.drawString('الإجمالى', arabicFont,
  //     format: PdfStringFormat(
  //       textDirection: PdfTextDirection.rightToLeft,
  //     ),
  //     bounds: Rect.fromLTWH(quantityCellBounds!.left, result.bounds.bottom + 10,
  //         quantityCellBounds!.width, quantityCellBounds!.height));
  // page.graphics.drawString(
  //     format: PdfStringFormat(textDirection: PdfTextDirection.rightToLeft),
  //     getTotalAmount(grid).toString(),
  //     arabicFont,
  //     bounds: Rect.fromLTWH(
  //         totalPriceCellBounds!.left,
  //         result.bounds.bottom + 10,
  //         totalPriceCellBounds!.width,
  //         totalPriceCellBounds!.height));
}

//Draw the invoice footer data.
// void drawFooter(PdfPage page, Size pageSize, Uint8List arabicFontBytes) {
//   // Create a PdfFont using the loaded font file data
//   final PdfFont arabicFont = PdfTrueTypeFont(arabicFontBytes, 9);
//   final PdfPen linePen =
//       PdfPen(PdfColor(142, 170, 219), dashStyle: PdfDashStyle.custom);
//   linePen.dashPattern = <double>[3, 3];
//   //Draw line
//   page.graphics.drawLine(linePen, Offset(0, pageSize.height - 100),
//       Offset(pageSize.width, pageSize.height - 100));
//   // Pdf footer content
//   const String footerContent =
//       // ignore: leading_newlines_in_multiline_strings
//       "Mahmoud Fouda\n01157847681\nmhmdfoudaa@gmail.com";

//   //Added 30 as a margin for the layout
//   page.graphics.drawString(footerContent, arabicFont,
//       format: PdfStringFormat(
//           textDirection: PdfTextDirection.rightToLeft,
//           alignment: PdfTextAlignment.right),
//       bounds: Rect.fromLTWH(pageSize.width - 30, pageSize.height - 70, 0, 0));
// }

//Create PDF grid and return
PdfGrid getGrid(Order order, Uint8List arabicFontBytes) {
  final products = order.products;

  final PdfGrid grid = PdfGrid();

  grid.columns.add(count: 5);

  final PdfFont arabicFont = PdfTrueTypeFont(arabicFontBytes, 12);
  final PdfGridRow headerRow = grid.headers.add(1)[0];
  headerRow.style.backgroundBrush = PdfSolidBrush(PdfColor(68, 114, 196));
  headerRow.style.textBrush = PdfBrushes.white;
  headerRow.style.font = arabicFont;

  headerRow.cells[4].value = 'اسم المنتج';
  headerRow.cells[3].value = 'الكمية';
  headerRow.cells[2].value = 'النوع';
  headerRow.cells[1].value = 'السعر';
  headerRow.cells[0].value = 'الإجمالى';
  // headerRow.cells[5].value = 'الإجمالى للبيع';

  for (int i = 0; i < headerRow.cells.count; i++) {
    headerRow.cells[i].stringFormat.textDirection =
        PdfTextDirection.rightToLeft;
    headerRow.cells[i].stringFormat.alignment = PdfTextAlignment.center;
  }

  for (final product in products) {
    addProducts(
      productName: product.name,
      count: product.count,
      productType: product.unitType,
      price: product.price,
      publicPrice: product.publicPrice,
      grid: grid,
      arabicFont: arabicFont,
    );
  }

  grid.applyBuiltInStyle(
    PdfGridBuiltInStyle.listTable4Accent5,
  );
  grid.columns[4].width = 200;

  for (int i = 0; i < headerRow.cells.count; i++) {
    headerRow.cells[i].style.cellPadding =
        PdfPaddings(bottom: 5, left: 5, right: 5, top: 5);
  }

  for (int i = 0; i < grid.rows.count; i++) {
    final PdfGridRow row = grid.rows[i];
    for (int j = 0; j < row.cells.count; j++) {
      final PdfGridCell cell = row.cells[j];
      if (j == 0) {
        cell.stringFormat.alignment = PdfTextAlignment.center;
        cell.stringFormat.textDirection = PdfTextDirection.rightToLeft;
      }
      cell.style.cellPadding =
          PdfPaddings(bottom: 5, left: 5, right: 5, top: 5);
      // cell.style.stringFormat?.textDirection = PdfTextDirection.rightToLeft;
    }
  }

  return grid;
}

//Create and row for the grid.
void addProducts({
  required String productName,
  required String productType,
  required int count,
  required double price,
  required double publicPrice,
  required PdfGrid grid,
  required PdfFont arabicFont,
}) {
  final PdfGridRow row = grid.rows.add();
  row.style.font = arabicFont;
  for (int i = 0; i < row.cells.count; i++) {
    row.cells[i].stringFormat.textDirection = PdfTextDirection.rightToLeft;
    row.cells[i].stringFormat.alignment = PdfTextAlignment.center;
  }
  double totalPriceForProduct = count * price;

  row.cells[4].value = productName;
  row.cells[3].value = count.toString();
  row.cells[2].value = productType;
  row.cells[1].value = price.toString();
  row.cells[0].value = totalPriceForProduct.toString();
}

//Get the total amount.
// double getTotalAmount(PdfGrid grid) {
//   double total = 0;
//   for (int i = 0; i < grid.rows.count; i++) {
//     final String value =
//         grid.rows[i].cells[grid.columns.count - 1].value as String;
//     total += double.parse(value);
//   }
//   return total;
// }
