// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'supplier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getAsyncSupplierHash() => r'0bdda2a18a31e50b0435387c2c8738626974c71b';

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

typedef GetAsyncSupplierRef = AutoDisposeFutureProviderRef<Supplier>;

/// See also [getAsyncSupplier].
@ProviderFor(getAsyncSupplier)
const getAsyncSupplierProvider = GetAsyncSupplierFamily();

/// See also [getAsyncSupplier].
class GetAsyncSupplierFamily extends Family<AsyncValue<Supplier>> {
  /// See also [getAsyncSupplier].
  const GetAsyncSupplierFamily();

  /// See also [getAsyncSupplier].
  GetAsyncSupplierProvider call({
    required String id,
  }) {
    return GetAsyncSupplierProvider(
      id: id,
    );
  }

  @override
  GetAsyncSupplierProvider getProviderOverride(
    covariant GetAsyncSupplierProvider provider,
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
  String? get name => r'getAsyncSupplierProvider';
}

/// See also [getAsyncSupplier].
class GetAsyncSupplierProvider extends AutoDisposeFutureProvider<Supplier> {
  /// See also [getAsyncSupplier].
  GetAsyncSupplierProvider({
    required this.id,
  }) : super.internal(
          (ref) => getAsyncSupplier(
            ref,
            id: id,
          ),
          from: getAsyncSupplierProvider,
          name: r'getAsyncSupplierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getAsyncSupplierHash,
          dependencies: GetAsyncSupplierFamily._dependencies,
          allTransitiveDependencies:
              GetAsyncSupplierFamily._allTransitiveDependencies,
        );

  final String id;

  @override
  bool operator ==(Object other) {
    return other is GetAsyncSupplierProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

String _$asyncSupplierHash() => r'32feee6768304258c34b06a8399c0e7ac1f474b1';

/// See also [AsyncSupplier].
@ProviderFor(AsyncSupplier)
final asyncSupplierProvider =
    AutoDisposeAsyncNotifierProvider<AsyncSupplier, List<Supplier>>.internal(
  AsyncSupplier.new,
  name: r'asyncSupplierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$asyncSupplierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AsyncSupplier = AutoDisposeAsyncNotifier<List<Supplier>>;
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
