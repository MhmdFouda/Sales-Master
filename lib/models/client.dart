import 'package:firedart/firedart.dart';

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
    required int colorIndex,
  }) = _Client;

  factory Client.fromJson(Map<String, dynamic> json) => _$ClientFromJson(json);

  factory Client.fromSnapshot(Document doc) {
    return Client(
      id: doc.id,
      name: doc['name'],
      phoneNumber: doc['phoneNumber'],
      secPhoneNumber: doc['secPhoneNumber'],
      colorIndex: doc['colorIndex'],
    );
  }
}
