// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'date_time_formater.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$dateFormaterHash() => r'7efd245d66ec303393665815ecf87575ae5994fc';

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

typedef DateFormaterRef = AutoDisposeProviderRef<String>;

/// See also [dateFormater].
@ProviderFor(dateFormater)
const dateFormaterProvider = DateFormaterFamily();

/// See also [dateFormater].
class DateFormaterFamily extends Family<String> {
  /// See also [dateFormater].
  const DateFormaterFamily();

  /// See also [dateFormater].
  DateFormaterProvider call(
    DateTime dateTime,
  ) {
    return DateFormaterProvider(
      dateTime,
    );
  }

  @override
  DateFormaterProvider getProviderOverride(
    covariant DateFormaterProvider provider,
  ) {
    return call(
      provider.dateTime,
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
  String? get name => r'dateFormaterProvider';
}

/// See also [dateFormater].
class DateFormaterProvider extends AutoDisposeProvider<String> {
  /// See also [dateFormater].
  DateFormaterProvider(
    this.dateTime,
  ) : super.internal(
          (ref) => dateFormater(
            ref,
            dateTime,
          ),
          from: dateFormaterProvider,
          name: r'dateFormaterProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$dateFormaterHash,
          dependencies: DateFormaterFamily._dependencies,
          allTransitiveDependencies:
              DateFormaterFamily._allTransitiveDependencies,
        );

  final DateTime dateTime;

  @override
  bool operator ==(Object other) {
    return other is DateFormaterProvider && other.dateTime == dateTime;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, dateTime.hashCode);

    return _SystemHash.finish(hash);
  }
}

String _$timeFormaterHash() => r'de8c842e3958ae48e881d56f8afaefdf40da98af';
typedef TimeFormaterRef = AutoDisposeProviderRef<String>;

/// See also [timeFormater].
@ProviderFor(timeFormater)
const timeFormaterProvider = TimeFormaterFamily();

/// See also [timeFormater].
class TimeFormaterFamily extends Family<String> {
  /// See also [timeFormater].
  const TimeFormaterFamily();

  /// See also [timeFormater].
  TimeFormaterProvider call(
    DateTime dateTime,
  ) {
    return TimeFormaterProvider(
      dateTime,
    );
  }

  @override
  TimeFormaterProvider getProviderOverride(
    covariant TimeFormaterProvider provider,
  ) {
    return call(
      provider.dateTime,
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
  String? get name => r'timeFormaterProvider';
}

/// See also [timeFormater].
class TimeFormaterProvider extends AutoDisposeProvider<String> {
  /// See also [timeFormater].
  TimeFormaterProvider(
    this.dateTime,
  ) : super.internal(
          (ref) => timeFormater(
            ref,
            dateTime,
          ),
          from: timeFormaterProvider,
          name: r'timeFormaterProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$timeFormaterHash,
          dependencies: TimeFormaterFamily._dependencies,
          allTransitiveDependencies:
              TimeFormaterFamily._allTransitiveDependencies,
        );

  final DateTime dateTime;

  @override
  bool operator ==(Object other) {
    return other is TimeFormaterProvider && other.dateTime == dateTime;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, dateTime.hashCode);

    return _SystemHash.finish(hash);
  }
}
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
