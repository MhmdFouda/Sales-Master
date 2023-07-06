import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fouda_pharma/models/supplier.dart';
import 'package:nimbostratus/nimbostratus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'supplier.g.dart';

@riverpod
class AsyncSupplier extends _$AsyncSupplier {
  Future<List<Supplier>> _fetchSupplier() async {
    final supplierCollection =
        FirebaseFirestore.instance.collection('suppliers');
    final snap = await Nimbostratus.instance.getDocuments(
      supplierCollection,
      fetchPolicy: GetFetchPolicy.cacheFirst,
    );
    return snap.map((doc) => Supplier.fromSnapshot(doc)).toList();
  }

  @override
  FutureOr<List<Supplier>> build() async {
    return _fetchSupplier();
  }

  Future<Supplier> getSupplier(String id) async {
    final supplierCollection =
        FirebaseFirestore.instance.collection('suppliers');
    final snap = await Nimbostratus.instance.getDocument(
      supplierCollection.doc(id),
      fetchPolicy: GetFetchPolicy.cacheFirst,
    );

    if (snap.exists) {
      return Supplier.fromSnapshot(snap);
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
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final supplierCollection =
          FirebaseFirestore.instance.collection('suppliers');
      await Nimbostratus.instance.addDocument(
        supplierCollection,
        supplier.toJson(),
        writePolicy: WritePolicy.cacheAndServer,
      );
      return _fetchSupplier();
    });
    ref.invalidateSelf();
  }

  Future<void> updateSupplier(Supplier supplier) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final supplierCollection =
          FirebaseFirestore.instance.collection('suppliers');
      await Nimbostratus.instance.updateDocument(
        supplierCollection.doc(supplier.id),
        supplier.toJson(),
        writePolicy: WritePolicy.cacheAndServer,
      );
      return _fetchSupplier();
    });

    ref.invalidateSelf();
    ref.invalidate(getAsyncSupplierProvider(id: supplier.id!));
  }

  Future<void> deleteSupplier(String id) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final supplierCollection =
          FirebaseFirestore.instance.collection('suppliers');
      await Nimbostratus.instance.deleteDocument(
        supplierCollection.doc(id),
        deletePolicy: DeletePolicy.cacheAndServer,
      );
      return _fetchSupplier();
    });

    ref.invalidateSelf();
  }
}

@riverpod
FutureOr<Supplier> getAsyncSupplier(GetAsyncSupplierRef ref,
    {required String id}) async {
  final supplier =
      await ref.watch(asyncSupplierProvider.notifier).getSupplier(id);
  return supplier;
}
