// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$asyncOrderProviderHash() =>
    r'68cc452b51634b8e5d0ef66646a1c0f2c9eec133';

/// See also [AsyncOrderProvider].
@ProviderFor(AsyncOrderProvider)
final asyncOrderProviderProvider =
    AutoDisposeAsyncNotifierProvider<AsyncOrderProvider, List<Order>>.internal(
  AsyncOrderProvider.new,
  name: r'asyncOrderProviderProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$asyncOrderProviderHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AsyncOrderProvider = AutoDisposeAsyncNotifier<List<Order>>;
String _$clientNameHash() => r'2fdd53e359e5c0923a835e1b61e6aa1ef91dd376';

/// See also [ClientName].
@ProviderFor(ClientName)
final clientNameProvider =
    AutoDisposeNotifierProvider<ClientName, String?>.internal(
  ClientName.new,
  name: r'clientNameProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$clientNameHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ClientName = AutoDisposeNotifier<String?>;
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
