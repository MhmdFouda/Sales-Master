import 'package:firedart/firedart.dart';
import 'package:fouda_pharma/models/client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'client.g.dart';

@riverpod
class AsyncClient extends _$AsyncClient {
  @override
  FutureOr<List<Client>> build() async {
    return _fetchClient();
  }

  // cashed the data

  Future<List<Client>> _fetchClient() async {
    final clientCollection = Firestore.instance.collection('clients');
    final documents = await clientCollection.get();
    List<Client> clientList = [];
    for (final doc in documents) {
      clientList.add(Client.fromSnapshot(doc));
    }
    return clientList;
  }

  //get one product with id
  Future<Client> getClient(String id) async {
    final clientCollection = Firestore.instance.collection('clients');
    final client = await clientCollection.document(id).get();
    return Client.fromSnapshot(client);
  }

  Future<void> addClient(Client client) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () async {
        final clientCollection = Firestore.instance.collection('clients');
        final docRef = await clientCollection.add(client.toMap());
        final id = docRef.id;
        await docRef.reference.update({'id': id});
        return _fetchClient();
      },
    );
  }

  // update product
  Future<void> updateClient(Client client) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () async {
        final clientCollection = Firestore.instance.collection('clients');
        await clientCollection.document(client.id!).update(client.toMap());
        return _fetchClient();
      },
    );
  }

  // delete product
  Future<void> deleteClient(String id) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () async {
        final clientCollection = Firestore.instance.collection('clients');
        await clientCollection.document(id).delete();
        return _fetchClient();
      },
    );
  }
}
