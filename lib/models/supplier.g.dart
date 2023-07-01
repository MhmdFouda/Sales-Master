// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'supplier.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Supplier _$$_SupplierFromJson(Map<String, dynamic> json) => _$_Supplier(
      id: json['id'] as String?,
      name: json['name'] as String,
      phoneNumber: json['phoneNumber'] as String?,
      secPhoneNumber: json['secPhoneNumber'] as String?,
      invoices: (json['invoices'] as List<dynamic>?)
          ?.map((e) => Invoice.fromJson(e as Map<String, dynamic>))
          .toList(),
      balance: (json['balance'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$_SupplierToJson(_$_Supplier instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phoneNumber': instance.phoneNumber,
      'secPhoneNumber': instance.secPhoneNumber,
      'invoices': instance.invoices,
      'balance': instance.balance,
    };
