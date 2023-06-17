// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getRandomIntHash() => r'dd2f99aed3c71dc738f261b072fd713bae7a32b8';

/// See also [getRandomInt].
@ProviderFor(getRandomInt)
final getRandomIntProvider = AutoDisposeProvider<int>.internal(
  getRandomInt,
  name: r'getRandomIntProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$getRandomIntHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetRandomIntRef = AutoDisposeProviderRef<int>;
String _$themeDataHash() => r'f936563aa277a75d6f380be737049a17dbe65d0b';

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
