import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'client.freezed.dart';
part 'client.g.dart';

@freezed
class Client with _$Client {
  factory Client({
    String? id,
    required String name,
    String? phoneNumber,
    String? secPhoneNumber,
    double? balance,
    double? credit,
  }) = _Client;

  factory Client.fromJson(Map<String, dynamic> json) => _$ClientFromJson(json);

  factory Client.fromSnapshot(DocumentSnapshot doc) {
    return Client(
      id: doc.id,
      name: doc['name'],
      phoneNumber: doc['phoneNumber'],
      secPhoneNumber: doc['secPhoneNumber'],
      balance: doc['balance'].toDouble(),
      credit: doc['credit'].toDouble(),
    );
  }
}
