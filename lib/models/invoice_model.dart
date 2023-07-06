import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'invoice.freezed.dart';
part 'invoice.g.dart';

@freezed
class Invoice with _$Invoice {
  factory Invoice({
    String? id,
    DateTime? date,
    double? balance,
  }) = _Invoice;

  factory Invoice.fromJson(Map<String, dynamic> json) =>
      _$InvoiceFromJson(json);

  factory Invoice.fromSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    final dateTime = DateTime.parse(data['date']);

    return Invoice(
      id: doc.id,
      date: dateTime,
      balance: data['balance'].toDouble(),
    );
  }
}
