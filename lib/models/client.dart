// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:flutter/material.dart';

@immutable
class Client {
  final String id;
  final String name;
  final String? phoneNumber;
  final String? secPhoneNumber;

  const Client({
    required this.id,
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

  factory Client.fromMap(Map<String, dynamic> map) {
    return Client(
      id: map['id'] as String,
      name: map['name'] as String,
      phoneNumber:
          map['phoneNumber'] != null ? map['phoneNumber'] as String : null,
      secPhoneNumber: map['secPhoneNumber'] != null
          ? map['secPhoneNumber'] as String
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Client.fromJson(String source) =>
      Client.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Client(id: $id, name: $name, phoneNumber: $phoneNumber, secPhoneNumber: $secPhoneNumber)';
  }

  @override
  bool operator ==(covariant Client other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.phoneNumber == phoneNumber &&
        other.secPhoneNumber == secPhoneNumber;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        phoneNumber.hashCode ^
        secPhoneNumber.hashCode;
  }
}
