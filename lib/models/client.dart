import 'package:firedart/firedart.dart';
import 'package:flutter/material.dart';

@immutable
class Client {
  final String? id;
  final String name;
  final String? phoneNumber;
  final String? secPhoneNumber;

  const Client({
    this.id,
    required this.name,
    this.phoneNumber,
    this.secPhoneNumber,
  });

  Client copyWith({
    String? id,
    String? name,
    String? phoneNumber,
    String? secPhoneNumber,
  }) {
    return Client(
      id: id ?? this.id,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      secPhoneNumber: secPhoneNumber ?? this.secPhoneNumber,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'phoneNumber': phoneNumber,
      'secPhoneNumber': secPhoneNumber,
    };
  }

  factory Client.fromSnapshot(Document doc) {
    return Client(
      id: doc.id,
      name: doc['name'],
      phoneNumber: doc['phoneNumber'],
      secPhoneNumber: doc['secPhoneNumber'],
    );
  }
}
