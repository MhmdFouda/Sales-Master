// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UserApp _$UserAppFromJson(Map<String, dynamic> json) {
  return _UserApp.fromJson(json);
}

/// @nodoc
mixin _$UserApp {
  String? get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserAppCopyWith<UserApp> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserAppCopyWith<$Res> {
  factory $UserAppCopyWith(UserApp value, $Res Function(UserApp) then) =
      _$UserAppCopyWithImpl<$Res, UserApp>;
  @useResult
  $Res call({String? id, String name, String email});
}

/// @nodoc
class _$UserAppCopyWithImpl<$Res, $Val extends UserApp>
    implements $UserAppCopyWith<$Res> {
  _$UserAppCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = null,
    Object? email = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_UserAppCopyWith<$Res> implements $UserAppCopyWith<$Res> {
  factory _$$_UserAppCopyWith(
          _$_UserApp value, $Res Function(_$_UserApp) then) =
      __$$_UserAppCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? id, String name, String email});
}

/// @nodoc
class __$$_UserAppCopyWithImpl<$Res>
    extends _$UserAppCopyWithImpl<$Res, _$_UserApp>
    implements _$$_UserAppCopyWith<$Res> {
  __$$_UserAppCopyWithImpl(_$_UserApp _value, $Res Function(_$_UserApp) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = null,
    Object? email = null,
  }) {
    return _then(_$_UserApp(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_UserApp implements _UserApp {
  _$_UserApp({this.id, required this.name, required this.email});

  factory _$_UserApp.fromJson(Map<String, dynamic> json) =>
      _$$_UserAppFromJson(json);

  @override
  final String? id;
  @override
  final String name;
  @override
  final String email;

  @override
  String toString() {
    return 'UserApp(id: $id, name: $name, email: $email)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UserApp &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.email, email) || other.email == email));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, email);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UserAppCopyWith<_$_UserApp> get copyWith =>
      __$$_UserAppCopyWithImpl<_$_UserApp>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UserAppToJson(
      this,
    );
  }
}

abstract class _UserApp implements UserApp {
  factory _UserApp(
      {final String? id,
      required final String name,
      required final String email}) = _$_UserApp;

  factory _UserApp.fromJson(Map<String, dynamic> json) = _$_UserApp.fromJson;

  @override
  String? get id;
  @override
  String get name;
  @override
  String get email;
  @override
  @JsonKey(ignore: true)
  _$$_UserAppCopyWith<_$_UserApp> get copyWith =>
      throw _privateConstructorUsedError;
}
