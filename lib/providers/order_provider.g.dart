// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$asyncOrderProviderHash() =>
    r'a7eca4bef59b24b37487aa9bff5e60cbaf3f15c7';

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
String _$getOrderByIdHash() => r'164c386eda985dde65566bb53d562963adabd811';

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

abstract class _$GetOrderById extends BuildlessAutoDisposeAsyncNotifier<Order> {
  late final String id;

  Future<Order> build({
    required String id,
  });
}

/// See also [GetOrderById].
@ProviderFor(GetOrderById)
const getOrderByIdProvider = GetOrderByIdFamily();

/// See also [GetOrderById].
class GetOrderByIdFamily extends Family<AsyncValue<Order>> {
  /// See also [GetOrderById].
  const GetOrderByIdFamily();

  /// See also [GetOrderById].
  GetOrderByIdProvider call({
    required String id,
  }) {
    return GetOrderByIdProvider(
      id: id,
    );
  }

  @override
  GetOrderByIdProvider getProviderOverride(
    covariant GetOrderByIdProvider provider,
  ) {
    return call(
      id: provider.id,
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
  String? get name => r'getOrderByIdProvider';
}

/// See also [GetOrderById].
class GetOrderByIdProvider
    extends AutoDisposeAsyncNotifierProviderImpl<GetOrderById, Order> {
  /// See also [GetOrderById].
  GetOrderByIdProvider({
    required this.id,
  }) : super.internal(
          () => GetOrderById()..id = id,
          from: getOrderByIdProvider,
          name: r'getOrderByIdProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getOrderByIdHash,
          dependencies: GetOrderByIdFamily._dependencies,
          allTransitiveDependencies:
              GetOrderByIdFamily._allTransitiveDependencies,
        );

  final String id;

  @override
  bool operator ==(Object other) {
    return other is GetOrderByIdProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }

  @override
  Future<Order> runNotifierBuild(
    covariant GetOrderById notifier,
  ) {
    return notifier.build(
      id: id,
    );
  }
}

String _$clientNameHash() => r'd09f9c821a91f5050ba209cd3b0a46e96ccc00ce';

/// See also [ClientName].
@ProviderFor(ClientName)
final clientNameProvider =
    AutoDisposeNotifierProvider<ClientName, Client?>.internal(
  ClientName.new,
  name: r'clientNameProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$clientNameHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ClientName = AutoDisposeNotifier<Client?>;
String _$asyncFilterdOrderHash() => r'00baa659db21d8ec5fe3510a625c3dae941eeb10';

abstract class _$AsyncFilterdOrder
    extends BuildlessAutoDisposeAsyncNotifier<List<Order>> {
  late final String clientName;

  Future<List<Order>> build(
    String clientName,
  );
}

/// See also [AsyncFilterdOrder].
@ProviderFor(AsyncFilterdOrder)
const asyncFilterdOrderProvider = AsyncFilterdOrderFamily();

/// See also [AsyncFilterdOrder].
class AsyncFilterdOrderFamily extends Family<AsyncValue<List<Order>>> {
  /// See also [AsyncFilterdOrder].
  const AsyncFilterdOrderFamily();

  /// See also [AsyncFilterdOrder].
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

/// See also [AsyncFilterdOrder].
class AsyncFilterdOrderProvider extends AutoDisposeAsyncNotifierProviderImpl<
    AsyncFilterdOrder, List<Order>> {
  /// See also [AsyncFilterdOrder].
  AsyncFilterdOrderProvider(
    this.clientName,
  ) : super.internal(
          () => AsyncFilterdOrder()..clientName = clientName,
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

  @override
  Future<List<Order>> runNotifierBuild(
    covariant AsyncFilterdOrder notifier,
  ) {
    return notifier.build(
      clientName,
    );
  }
}
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
