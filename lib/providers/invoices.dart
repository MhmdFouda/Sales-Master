import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fouda_pharma/models/invoice_model.dart';
import 'package:nimbostratus/nimbostratus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'invoices.g.dart';

@riverpod
class AsyncInvoice extends _$AsyncInvoice {
  Future<List<Invoice>> _fetchinvoice({
    required String collectionId,
    required String collectionName,
  }) async {
    final invoiceCollection = FirebaseFirestore.instance
        .collection(collectionName)
        .doc(collectionId)
        .collection('invoices');

    final snap = await Nimbostratus.instance.getDocuments(
      invoiceCollection,
      fetchPolicy: GetFetchPolicy.cacheFirst,
    );

    return snap.map((doc) => Invoice.fromSnapshot(doc)).toList();
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

  Future<void> addinvoice({
    required Invoice invoice,
    required String collectionId,
    required String collectionName,
  }) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final invoiceCollection = FirebaseFirestore.instance
          .collection(collectionName)
          .doc(collectionId)
          .collection('invoices');
      await Nimbostratus.instance.addDocument(
        invoiceCollection,
        invoice.toJson(),
        writePolicy: WritePolicy.cacheAndServer,
      );
      return _fetchinvoice(
        collectionId: collectionId,
        collectionName: collectionName,
      );
    });

    ref.invalidateSelf();
  }

  Future<void> updateinvoice(
      {required Invoice invoice,
      required String collectionId,
      required String collectionName,
      required String id}) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final invoiceCollection = FirebaseFirestore.instance
          .collection(collectionName)
          .doc(collectionId)
          .collection('invoices');
      await Nimbostratus.instance.updateDocument(
        invoiceCollection.doc(id),
        invoice.toJson(),
        writePolicy: WritePolicy.cacheAndServer,
      );
      return _fetchinvoice(
        collectionId: collectionId,
        collectionName: collectionName,
      );
    });
    ref.invalidateSelf();
  }

  Future<void> deleteinvoice({
    required String collectionId,
    required String collectionName,
    required String id,
  }) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final invoiceCollection = FirebaseFirestore.instance
          .collection(collectionName)
          .doc(collectionId)
          .collection('invoices');
      await Nimbostratus.instance.deleteDocument(
        invoiceCollection.doc(id),
        deletePolicy: DeletePolicy.cacheAndServer,
      );
      return _fetchinvoice(
        collectionId: collectionId,
        collectionName: collectionName,
      );
    });
    ref.invalidateSelf();
  }
}
