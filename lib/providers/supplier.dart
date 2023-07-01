import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fouda_pharma/models/supplier.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'supplier.g.dart';

@Riverpod(keepAlive: true)
class AsyncSupplier extends _$AsyncSupplier {
  Future<List<Supplier>> _fetchSupplier() async {
    final supplierCollection =
        FirebaseFirestore.instance.collection('suppliers');
    final querySnapshot = await supplierCollection.get(const GetOptions());
    final supplierList =
        querySnapshot.docs.map((doc) => Supplier.fromSnapshot(doc)).toList();
    return supplierList;
  }

  @override
  FutureOr<List<Supplier>> build() async {
    return _fetchSupplier();
  }

  Future<Supplier> getSupplier(String id) async {
    final supplierCollection =
        FirebaseFirestore.instance.collection('suppliers');
    final sppliertDoc =
        await supplierCollection.doc(id).get(const GetOptions());

    if (sppliertDoc.exists) {
      return Supplier.fromSnapshot(sppliertDoc);
    } else {
      throw Exception('Supplier not found');
    }
  }

  double calculateTotalPrice() {
    double totalPrice = 0.0;
    for (final supplier in state.asData?.value ?? []) {
      totalPrice += supplier.balance;
    }
    return totalPrice;
  }

  Future<void> addSupplier(Supplier supplier) async {
    final supplierCollection =
        FirebaseFirestore.instance.collection('suppliers');
    final docRef = await supplierCollection.add(supplier.toJson());
    final id = docRef.id;
    await docRef.update({'id': id});
  }

  Future<void> updateSupplier(Supplier supplier) async {
    final supplierCollection =
        FirebaseFirestore.instance.collection('suppliers');
    await supplierCollection.doc(supplier.id!).update(supplier.toJson());
  }

  Future<void> deleteSupplier(String id) async {
    final supplierCollection =
        FirebaseFirestore.instance.collection('suppliers');
    await supplierCollection.doc(id).delete();
  }
}

@riverpod
FutureOr<Supplier> getAsyncSupplier(GetAsyncSupplierRef ref,
    {required String id}) async {
  final supplier =
      await ref.watch(asyncSupplierProvider.notifier).getSupplier(id);
  return supplier;
}
