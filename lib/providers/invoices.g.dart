// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoices.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$asyncInvoiceHash() => r'98c1f1e9d0fb16a3c8ab7c8bffedb0a9a355e7a3';

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

abstract class _$AsyncInvoice
    extends BuildlessAutoDisposeAsyncNotifier<List<Invoice>> {
  late final String collectionId;
  late final String collectionName;

  FutureOr<List<Invoice>> build({
    required String collectionId,
    required String collectionName,
  });
}

/// See also [AsyncInvoice].
@ProviderFor(AsyncInvoice)
const asyncInvoiceProvider = AsyncInvoiceFamily();

/// See also [AsyncInvoice].
class AsyncInvoiceFamily extends Family<AsyncValue<List<Invoice>>> {
  /// See also [AsyncInvoice].
  const AsyncInvoiceFamily();

  /// See also [AsyncInvoice].
  AsyncInvoiceProvider call({
    required String collectionId,
    required String collectionName,
  }) {
    return AsyncInvoiceProvider(
      collectionId: collectionId,
      collectionName: collectionName,
    );
  }

  @override
  AsyncInvoiceProvider getProviderOverride(
    covariant AsyncInvoiceProvider provider,
  ) {
    return call(
      collectionId: provider.collectionId,
      collectionName: provider.collectionName,
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
  String? get name => r'asyncInvoiceProvider';
}

/// See also [AsyncInvoice].
class AsyncInvoiceProvider
    extends AutoDisposeAsyncNotifierProviderImpl<AsyncInvoice, List<Invoice>> {
  /// See also [AsyncInvoice].
  AsyncInvoiceProvider({
    required this.collectionId,
    required this.collectionName,
  }) : super.internal(
          () => AsyncInvoice()
            ..collectionId = collectionId
            ..collectionName = collectionName,
          from: asyncInvoiceProvider,
          name: r'asyncInvoiceProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$asyncInvoiceHash,
          dependencies: AsyncInvoiceFamily._dependencies,
          allTransitiveDependencies:
              AsyncInvoiceFamily._allTransitiveDependencies,
        );

  final String collectionId;
  final String collectionName;

  @override
  bool operator ==(Object other) {
    return other is AsyncInvoiceProvider &&
        other.collectionId == collectionId &&
        other.collectionName == collectionName;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, collectionId.hashCode);
    hash = _SystemHash.combine(hash, collectionName.hashCode);

    return _SystemHash.finish(hash);
  }

  @override
  FutureOr<List<Invoice>> runNotifierBuild(
    covariant AsyncInvoice notifier,
  ) {
    return notifier.build(
      collectionId: collectionId,
      collectionName: collectionName,
    );
  }
}
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
