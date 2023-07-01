import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fouda_pharma/models/invoice_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'invoices.g.dart';

@Riverpod(keepAlive: false)
class AsyncInvoice extends _$AsyncInvoice {
  Future<List<Invoice>> _fetchinvoice({
    required String collectionId,
    required String collectionName,
  }) async {
    final invoiceCollection = FirebaseFirestore.instance
        .collection(collectionName)
        .doc(collectionId)
        .collection('invoices');
    final querySnapshot = await invoiceCollection.get(const GetOptions());
    final invoiceList =
        querySnapshot.docs.map((doc) => Invoice.fromSnapshot(doc)).toList();
    return invoiceList;
  }

  @override
  FutureOr<List<Invoice>> build({
    required String collectionId,
    required String collectionName,
  }) async {
    return _fetchinvoice(
      collectionId: collectionId,
      collectionName: collectionName,
    );
  }

  // calculate the total of the invoice.balance

  Future<void> addinvoice({
    required Invoice invoice,
    required String collectionId,
    required String collectionName,
  }) async {
    final invoiceCollection = FirebaseFirestore.instance
        .collection(collectionName)
        .doc(collectionId)
        .collection('invoices');
    final docRef = await invoiceCollection.add(invoice.toJson());
    final id = docRef.id;
    await docRef.update({'id': id});
  }

  Future<void> updateinvoice(
      {required Invoice invoice,
      required String collectionId,
      required String collectionName,
      required String id}) async {
    final invoiceCollection = FirebaseFirestore.instance
        .collection(collectionName)
        .doc(collectionId)
        .collection('invoices');
    await invoiceCollection.doc(invoice.id!).update(invoice.toJson());
  }

  Future<void> deleteinvoice({
    required String collectionId,
    required String collectionName,
    required String id,
  }) async {
    final invoiceCollection = FirebaseFirestore.instance
        .collection(collectionName)
        .doc(collectionId)
        .collection('invoices');
    await invoiceCollection.doc(id).delete();
  }
}
