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
    final client = await clientCollection.get();
    return client.map((doc) => Client.fromSnapshot(doc)).toList();
  }

  //get one product with id
  Future<Client> getProduct(String id) async {
    final clientCollection = Firestore.instance.collection('clients');
    final client = await clientCollection.document(id).get();
    return Client.fromSnapshot(client);
  }

  Future<void> addProduct(Client client) async {
    final clientCollection = Firestore.instance.collection('clients');
    final docRef = await clientCollection.add(client.toMap());
    final id = docRef.id;
    return docRef.reference.update({'id': id});
  }

  // update product
  Future<void> updateProduct(Client client) async {
    final clientCollection = Firestore.instance.collection('clients');
    return clientCollection.document(client.id!).update(client.toMap());
  }
  // delete product
}
