import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:fouda_pharma/models/client.dart';

part 'client.g.dart';

@Riverpod(keepAlive: true)
class AsyncClients extends _$AsyncClients {
  Future<List<Client>> _fetchClient() async {
    final clientCollection = FirebaseFirestore.instance.collection('clients');
    final querySnapshot = await clientCollection.get(const GetOptions());
    final clientList =
        querySnapshot.docs.map((doc) => Client.fromSnapshot(doc)).toList();
    return clientList;
  }

  @override
  FutureOr<List<Client>> build() async {
    return _fetchClient();
  }

  Client? getClient({required String id}) {
    for (final client in state.value ?? []) {
      if (client.id == id) {
        return client;
      }
    }
    return null; // Client with the specified ID not found
  }

  Future<void> addClient(Client client) async {
    final clientCollection = FirebaseFirestore.instance.collection('clients');
    final docRef = await clientCollection.add(client.toJson());
    final id = docRef.id;
    await docRef.update({'id': id});
  }

  Future<void> updateClient(Client client) async {
    final clientCollection = FirebaseFirestore.instance.collection('clients');
    await clientCollection.doc(client.id!).update(client.toJson());
  }

  Future<void> deleteClient(String id) async {
    final clientCollection = FirebaseFirestore.instance.collection('clients');
    await clientCollection.doc(id).delete();
  }
}
