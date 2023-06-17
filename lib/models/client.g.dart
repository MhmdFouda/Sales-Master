// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: non_constant_identifier_names

part of 'client.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Client _$$_ClientFromJson(Map<String, dynamic> json) => _$_Client(
      id: json['id'] as String?,
      name: json['name'] as String,
      phoneNumber: json['phoneNumber'] as String?,
      secPhoneNumber: json['secPhoneNumber'] as String?,
      colorIndex: json['colorIndex'] as int,
    );

Map<String, dynamic> _$$_ClientToJson(_$_Client instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phoneNumber': instance.phoneNumber,
      'secPhoneNumber': instance.secPhoneNumber,
      'colorIndex': instance.colorIndex,
    };
