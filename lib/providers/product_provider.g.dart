// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getAsyncProductHash() => r'294147b6ae853a3571a43384aa412c2ffe8fec74';

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

typedef GetAsyncProductRef = AutoDisposeFutureProviderRef<Product>;

/// See also [getAsyncProduct].
@ProviderFor(getAsyncProduct)
const getAsyncProductProvider = GetAsyncProductFamily();

/// See also [getAsyncProduct].
class GetAsyncProductFamily extends Family<AsyncValue<Product>> {
  /// See also [getAsyncProduct].
  const GetAsyncProductFamily();

  /// See also [getAsyncProduct].
  GetAsyncProductProvider call({
    required String id,
  }) {
    return GetAsyncProductProvider(
      id: id,
    );
  }

  @override
  GetAsyncProductProvider getProviderOverride(
    covariant GetAsyncProductProvider provider,
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
  String? get name => r'getAsyncProductProvider';
}

/// See also [getAsyncProduct].
class GetAsyncProductProvider extends AutoDisposeFutureProvider<Product> {
  /// See also [getAsyncProduct].
  GetAsyncProductProvider({
    required this.id,
  }) : super.internal(
          (ref) => getAsyncProduct(
            ref,
            id: id,
          ),
          from: getAsyncProductProvider,
          name: r'getAsyncProductProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getAsyncProductHash,
          dependencies: GetAsyncProductFamily._dependencies,
          allTransitiveDependencies:
              GetAsyncProductFamily._allTransitiveDependencies,
        );

  final String id;

  @override
  bool operator ==(Object other) {
    return other is GetAsyncProductProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

String _$asyncProductsHash() => r'a516ad51b2ce3b061f101304a6a78934d8df88e4';

/// See also [AsyncProducts].
@ProviderFor(AsyncProducts)
final asyncProductsProvider =
    AsyncNotifierProvider<AsyncProducts, List<Product>>.internal(
  AsyncProducts.new,
  name: r'asyncProductsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$asyncProductsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AsyncProducts = AsyncNotifier<List<Product>>;
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
