import 'package:firedart/firedart.dart';
import 'package:flutter/material.dart';
import 'package:fouda_pharma/models/order.dart';

@immutable
class Client {
  final String? id;
  final String name;
  final String? phoneNumber;
  final String? secPhoneNumber;
  final List<Order>? orders;

  const Client({
    this.id,
    required this.name,
    this.phoneNumber,
    this.secPhoneNumber,
    this.orders,
  });

  Client copyWith({
    String? id,
    String? name,
    String? phoneNumber,
    String? secPhoneNumber,
    List<Order>? orders,
  }) {
    return Client(
      id: id ?? this.id,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      secPhoneNumber: secPhoneNumber ?? this.secPhoneNumber,
      orders: orders ?? this.orders,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'phoneNumber': phoneNumber,
      'secPhoneNumber': secPhoneNumber,
      'orders': orders?.map((order) => order.toMap()).toList(),
    };
  }

  factory Client.fromSnapshot(Document doc) {
    return Client(
      id: doc.id,
      name: doc['name'],
      phoneNumber: doc['phoneNumber'],
      secPhoneNumber: doc['secPhoneNumber'],
      orders: (doc['orders'])
          ?.map(
            (order) => Order.fromSnapshot(order),
          )
          .toList(),
    );
  }
}
