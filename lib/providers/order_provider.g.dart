// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$asyncFilterdOrderHash() => r'7776bef38d53f534ec4124cc019aefb8b87e44de';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

typedef AsyncFilterdOrderRef = AutoDisposeFutureProviderRef<List<Order>>;

/// See also [asyncFilterdOrder].
@ProviderFor(asyncFilterdOrder)
const asyncFilterdOrderProvider = AsyncFilterdOrderFamily();

/// See also [asyncFilterdOrder].
class AsyncFilterdOrderFamily extends Family<AsyncValue<List<Order>>> {
  /// See also [asyncFilterdOrder].
  const AsyncFilterdOrderFamily();

  /// See also [asyncFilterdOrder].
  AsyncFilterdOrderProvider call(
    String clientName,
  ) {
    return AsyncFilterdOrderProvider(
      clientName,
    );
  }

  @override
  AsyncFilterdOrderProvider getProviderOverride(
    covariant AsyncFilterdOrderProvider provider,
  ) {
    return call(
      provider.clientName,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'asyncFilterdOrderProvider';
}

/// See also [asyncFilterdOrder].
class AsyncFilterdOrderProvider extends AutoDisposeFutureProvider<List<Order>> {
  /// See also [asyncFilterdOrder].
  AsyncFilterdOrderProvider(
    this.clientName,
  ) : super.internal(
          (ref) => asyncFilterdOrder(
            ref,
            clientName,
          ),
          from: asyncFilterdOrderProvider,
          name: r'asyncFilterdOrderProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$asyncFilterdOrderHash,
          dependencies: AsyncFilterdOrderFamily._dependencies,
          allTransitiveDependencies:
              AsyncFilterdOrderFamily._allTransitiveDependencies,
        );

  final String clientName;

  @override
  bool operator ==(Object other) {
    return other is AsyncFilterdOrderProvider && other.clientName == clientName;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, clientName.hashCode);

    return _SystemHash.finish(hash);
  }
}

String _$asyncOrderProviderHash() =>
    r'3d3ba96a674f9b094086de844670b38ec71f838e';

/// See also [AsyncOrderProvider].
@ProviderFor(AsyncOrderProvider)
final asyncOrderProviderProvider =
    AsyncNotifierProvider<AsyncOrderProvider, List<Order>>.internal(
  AsyncOrderProvider.new,
  name: r'asyncOrderProviderProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$asyncOrderProviderHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AsyncOrderProvider = AsyncNotifier<List<Order>>;
String _$clientNameHash() => r'11aa337f9be5711e43844fc5c5cda905f2ef6f00';

/// See also [ClientName].
@ProviderFor(ClientName)
final clientNameProvider = NotifierProvider<ClientName, Client?>.internal(
  ClientName.new,
  name: r'clientNameProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$clientNameHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ClientName = Notifier<Client?>;
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
