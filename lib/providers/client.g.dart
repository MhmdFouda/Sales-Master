// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$asyncClientsHash() => r'78025a5d55e84026f264fec95f73eb6d83196550';

/// See also [AsyncClients].
@ProviderFor(AsyncClients)
final asyncClientsProvider =
    AutoDisposeAsyncNotifierProvider<AsyncClients, List<Client>>.internal(
  AsyncClients.new,
  name: r'asyncClientsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$asyncClientsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AsyncClients = AutoDisposeAsyncNotifier<List<Client>>;
String _$getAsyncClientHash() => r'3da1472d8e1521f8bee46239212c1802e20d000e';

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

abstract class _$GetAsyncClient
    extends BuildlessAutoDisposeAsyncNotifier<Client> {
  late final String id;

  FutureOr<Client> build(
    String id,
  );
}

/// See also [GetAsyncClient].
@ProviderFor(GetAsyncClient)
const getAsyncClientProvider = GetAsyncClientFamily();

/// See also [GetAsyncClient].
class GetAsyncClientFamily extends Family<AsyncValue<Client>> {
  /// See also [GetAsyncClient].
  const GetAsyncClientFamily();

  /// See also [GetAsyncClient].
  GetAsyncClientProvider call(
    String id,
  ) {
    return GetAsyncClientProvider(
      id,
    );
  }

  @override
  GetAsyncClientProvider getProviderOverride(
    covariant GetAsyncClientProvider provider,
  ) {
    return call(
      provider.id,
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
  String? get name => r'getAsyncClientProvider';
}

/// See also [GetAsyncClient].
class GetAsyncClientProvider
    extends AutoDisposeAsyncNotifierProviderImpl<GetAsyncClient, Client> {
  /// See also [GetAsyncClient].
  GetAsyncClientProvider(
    this.id,
  ) : super.internal(
          () => GetAsyncClient()..id = id,
          from: getAsyncClientProvider,
          name: r'getAsyncClientProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getAsyncClientHash,
          dependencies: GetAsyncClientFamily._dependencies,
          allTransitiveDependencies:
              GetAsyncClientFamily._allTransitiveDependencies,
        );

  final String id;

  @override
  bool operator ==(Object other) {
    return other is GetAsyncClientProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }

  @override
  FutureOr<Client> runNotifierBuild(
    covariant GetAsyncClient notifier,
  ) {
    return notifier.build(
      id,
    );
  }
}
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
