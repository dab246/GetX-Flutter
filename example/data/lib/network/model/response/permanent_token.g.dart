// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'permanent_token.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PermanentToken _$PermanentTokenFromJson(Map<String, dynamic> json) {
  return PermanentToken(
    json['token'] as String,
    _uuidFromJson(json['uuid']),
  );
}

Map<String, dynamic> _$PermanentTokenToJson(PermanentToken instance) =>
    <String, dynamic>{
      'token': instance.token,
      'uuid': _uuidToJson(instance.tokenId),
    };
