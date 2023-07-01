// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getRandomIntHash() => r'83d34356664b15d79be7ae1dc1c2a82c3ea453b3';

/// See also [getRandomInt].
@ProviderFor(getRandomInt)
final getRandomIntProvider = Provider<int>.internal(
  getRandomInt,
  name: r'getRandomIntProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$getRandomIntHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetRandomIntRef = ProviderRef<int>;
String _$themeDataHash() => r'cb916d12d1b7a83a18852d3b1f7915a7772376dc';

/// See also [ThemeData].
@ProviderFor(ThemeData)
final themeDataProvider =
    AutoDisposeNotifierProvider<ThemeData, ThemeMode>.internal(
  ThemeData.new,
  name: r'themeDataProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$themeDataHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ThemeData = AutoDisposeNotifier<ThemeMode>;
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
