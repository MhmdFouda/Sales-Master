// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Client _$$_ClientFromJson(Map<String, dynamic> json) => _$_Client(
      id: json['id'] as String?,
      name: json['name'] as String,
      phoneNumber: json['phoneNumber'] as String?,
      secPhoneNumber: json['secPhoneNumber'] as String?,
      balance: (json['balance'] as num?)?.toDouble(),
      credit: (json['credit'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$_ClientToJson(_$_Client instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phoneNumber': instance.phoneNumber,
      'secPhoneNumber': instance.secPhoneNumber,
      'balance': instance.balance,
      'credit': instance.credit,
    };
