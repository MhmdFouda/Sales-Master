// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: non_constant_identifier_names

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Product _$$_ProductFromJson(Map<String, dynamic> json) => _$_Product(
      id: json['id'] as String?,
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      publicPrice: (json['publicPrice'] as num).toDouble(),
      unitType: json['unitType'] as String,
      count: json['count'] as int,
      minCount: json['minCount'] as int,
      intialCount: json['intialCount'] as int,
      colorIndex: json['colorIndex'] as int,
    );

Map<String, dynamic> _$$_ProductToJson(_$_Product instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'price': instance.price,
      'publicPrice': instance.publicPrice,
      'unitType': instance.unitType,
      'count': instance.count,
      'minCount': instance.minCount,
      'intialCount': instance.intialCount,
      'colorIndex': instance.colorIndex,
    };
