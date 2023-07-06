import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fouda_pharma/models/invoice_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'supplier.freezed.dart';
part 'supplier.g.dart';

@freezed
class Supplier with _$Supplier {
  factory Supplier({
    String? id,
    required String name,
    String? phoneNumber,
    String? secPhoneNumber,
    List<Invoice>? invoices,
    double? balance,
  }) = _Supplier;

  factory Supplier.fromJson(Map<String, dynamic> json) =>
      _$SupplierFromJson(json);

  factory Supplier.fromSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    final List<Invoice> invoices = List<Invoice>.from(
        (data['invoices']).map((product) => Invoice.fromJson(product)));
    return Supplier(
      id: doc.id,
      name: data['name'],
      phoneNumber: data['phoneNumber'],
      secPhoneNumber: data['secPhoneNumber'],
      invoices: invoices,
      balance: data['balance'].toDouble(),
    );
  }
}
