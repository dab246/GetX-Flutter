// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserResponse _$UserResponseFromJson(Map<String, dynamic> json) {
  return UserResponse(
    const UserIdConverter().fromJson(json['uuid'] as String),
    json['locale'] as String,
    json['externalMailLocale'] as String,
    json['domain'] as String,
    json['firstName'] as String,
    json['lastName'] as String,
    json['mail'] as String,
    json['canUpload'] as bool,
    json['canCreateGuest'] as bool,
    _$enumDecodeNullable(_$AccountTypeEnumMap, json['accountType']),
    const QuotaIdConverter().fromJson(json['quotaUuid'] as String),
  );
}

Map<String, dynamic> _$UserResponseToJson(UserResponse instance) =>
    <String, dynamic>{
      'uuid': const UserIdConverter().toJson(instance.userId),
      'locale': instance.locale,
      'externalMailLocale': instance.externalMailLocale,
      'domain': instance.domain,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'mail': instance.mail,
      'canUpload': instance.canUpload,
      'canCreateGuest': instance.canCreateGuest,
      'accountType': _$AccountTypeEnumMap[instance.accountType],
      'quotaUuid': const QuotaIdConverter().toJson(instance.quotaUuid),
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$AccountTypeEnumMap = {
  AccountType.INTERNAL: 'INTERNAL',
};
