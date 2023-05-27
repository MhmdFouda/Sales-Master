// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_service_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$streamProductHash() => r'b8442a7c560ea64c211997dc77040192365e11ec';

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

typedef StreamProductRef = AutoDisposeStreamProviderRef<List<Product>>;

/// See also [streamProduct].
@ProviderFor(streamProduct)
const streamProductProvider = StreamProductFamily();

/// See also [streamProduct].
class StreamProductFamily extends Family<AsyncValue<List<Product>>> {
  /// See also [streamProduct].
  const StreamProductFamily();

  /// See also [streamProduct].
  StreamProductProvider call(
    String input,
  ) {
    return StreamProductProvider(
      input,
    );
  }

  @override
  StreamProductProvider getProviderOverride(
    covariant StreamProductProvider provider,
  ) {
    return call(
      provider.input,
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
  String? get name => r'streamProductProvider';
}

/// See also [streamProduct].
class StreamProductProvider extends AutoDisposeStreamProvider<List<Product>> {
  /// See also [streamProduct].
  StreamProductProvider(
    this.input,
  ) : super.internal(
          (ref) => streamProduct(
            ref,
            input,
          ),
          from: streamProductProvider,
          name: r'streamProductProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$streamProductHash,
          dependencies: StreamProductFamily._dependencies,
          allTransitiveDependencies:
              StreamProductFamily._allTransitiveDependencies,
        );

  final String input;

  @override
  bool operator ==(Object other) {
    return other is StreamProductProvider && other.input == input;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, input.hashCode);

    return _SystemHash.finish(hash);
  }
}

String _$dataBaseHash() => r'efd7fdc5b60b8d99e99e74edecd2463bc51f8897';

/// See also [DataBase].
@ProviderFor(DataBase)
final dataBaseProvider =
    AutoDisposeAsyncNotifierProvider<DataBase, List<Product>>.internal(
  DataBase.new,
  name: r'dataBaseProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$dataBaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$DataBase = AutoDisposeAsyncNotifier<List<Product>>;
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
