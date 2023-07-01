// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserApp _$$_UserAppFromJson(Map<String, dynamic> json) => _$_UserApp(
      id: json['id'] as String?,
      name: json['name'] as String,
      email: json['email'] as String,
    );

Map<String, dynamic> _$$_UserAppToJson(_$_UserApp instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
    };

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$asyncUserHash() => r'21c0bea4e10fd66bc68350c570ad6ed6c6e03f2b';

/// See also [AsyncUser].
@ProviderFor(AsyncUser)
final asyncUserProvider =
    AutoDisposeAsyncNotifierProvider<AsyncUser, void>.internal(
  AsyncUser.new,
  name: r'asyncUserProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$asyncUserHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AsyncUser = AutoDisposeAsyncNotifier<void>;
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
