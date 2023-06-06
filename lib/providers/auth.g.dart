// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$signInHash() => r'136f9b0c152d21141f6188df794587eabdb93ab3';

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

typedef SignInRef = AutoDisposeFutureProviderRef<void>;

/// See also [signIn].
@ProviderFor(signIn)
const signInProvider = SignInFamily();

/// See also [signIn].
class SignInFamily extends Family<AsyncValue<void>> {
  /// See also [signIn].
  const SignInFamily();

  /// See also [signIn].
  SignInProvider call({
    required String email,
    required String password,
  }) {
    return SignInProvider(
      email: email,
      password: password,
    );
  }

  @override
  SignInProvider getProviderOverride(
    covariant SignInProvider provider,
  ) {
    return call(
      email: provider.email,
      password: provider.password,
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
  String? get name => r'signInProvider';
}

/// See also [signIn].
class SignInProvider extends AutoDisposeFutureProvider<void> {
  /// See also [signIn].
  SignInProvider({
    required this.email,
    required this.password,
  }) : super.internal(
          (ref) => signIn(
            ref,
            email: email,
            password: password,
          ),
          from: signInProvider,
          name: r'signInProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$signInHash,
          dependencies: SignInFamily._dependencies,
          allTransitiveDependencies: SignInFamily._allTransitiveDependencies,
        );

  final String email;
  final String password;

  @override
  bool operator ==(Object other) {
    return other is SignInProvider &&
        other.email == email &&
        other.password == password;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, email.hashCode);
    hash = _SystemHash.combine(hash, password.hashCode);

    return _SystemHash.finish(hash);
  }
}

String _$signoutHash() => r'8cb3702a53f47c9a1552b925f3f6070b2793efec';

/// See also [signout].
@ProviderFor(signout)
final signoutProvider = AutoDisposeProvider<void>.internal(
  signout,
  name: r'signoutProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$signoutHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef SignoutRef = AutoDisposeProviderRef<void>;
String _$getUserEmailHash() => r'f0c48aec4723db2c263d821dac0afeeb51c25144';

/// See also [getUserEmail].
@ProviderFor(getUserEmail)
final getUserEmailProvider = AutoDisposeFutureProvider<String?>.internal(
  getUserEmail,
  name: r'getUserEmailProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$getUserEmailHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetUserEmailRef = AutoDisposeFutureProviderRef<String?>;
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
