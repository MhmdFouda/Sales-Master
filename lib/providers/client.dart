import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nimbostratus/nimbostratus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:fouda_pharma/models/client.dart';

part 'client.g.dart';

@riverpod
class AsyncClients extends _$AsyncClients {
  Future<List<Client>> _fetchClients() async {
    final clientCollection = FirebaseFirestore.instance.collection('clients');
    final snap = await Nimbostratus.instance.getDocuments(
      clientCollection,
      fetchPolicy: GetFetchPolicy.cacheFirst,
    );
    return snap.map((doc) => Client.fromSnapshot(doc)).toList();
  }

  @override
  FutureOr<List<Client>> build() async {
    return _fetchClients();
  }

  Future<Client> getClient(String id) async {
    final clientCollection = FirebaseFirestore.instance.collection('clients');
    final snap = await Nimbostratus.instance.getDocument(
      clientCollection.doc(id),
      fetchPolicy: GetFetchPolicy.cacheFirst,
    );
    return Client.fromSnapshot(snap);
  }

  Future<void> addClient(Client client) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final clientCollection = FirebaseFirestore.instance.collection('clients');
      await Nimbostratus.instance.addDocument(
        clientCollection,
        client.toJson(),
        writePolicy: WritePolicy.cacheAndServer,
      );
      return _fetchClients();
    });

    ref.invalidateSelf();
  }

  Future<void> updateClient(Client client) async {
    final clientCollection = FirebaseFirestore.instance.collection('clients');
    await Nimbostratus.instance.updateDocument(
      clientCollection.doc(client.id),
      client.toJson(),
      writePolicy: WritePolicy.cacheAndServer,
    );

    ref.invalidateSelf();
    ref.invalidate(
      getAsyncClientProvider(
        client.id!,
      ),
    );
  }

  Future<void> deleteClient(String id) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final clientCollection = FirebaseFirestore.instance.collection('clients');
      await Nimbostratus.instance.deleteDocument(
        clientCollection.doc(id),
        deletePolicy: DeletePolicy.cacheAndServer,
      );
      return _fetchClients();
    });

    ref.invalidateSelf();
  }
}

@riverpod
class GetAsyncClient extends _$GetAsyncClient {
  @override
  FutureOr<Client> build(String id) async {
    final client = await ref.watch(asyncClientsProvider.notifier).getClient(id);
    return client;
  }
}
