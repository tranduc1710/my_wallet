// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserEntityImpl _$$UserEntityImplFromJson(Map<String, dynamic> json) =>
    _$UserEntityImpl(
      id: json['id'] as String,
      username: json['username'] as String,
      enabled: json['enabled'] as bool,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      email: json['email'] as String,
      staffId: json['staffId'] as String,
      staffCode: json['staffCode'] as String,
      staffName: json['staffName'] as String,
      shopId: json['shopId'] as String,
      roles: json['roles'] as List<dynamic>,
      functions: json['functions'] as List<dynamic>,
      checkResult: json['checkResult'] as bool,
      tenantId: json['tenantId'] as String,
      clientCode: json['clientCode'] as String,
    );

Map<String, dynamic> _$$UserEntityImplToJson(_$UserEntityImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'enabled': instance.enabled,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'staffId': instance.staffId,
      'staffCode': instance.staffCode,
      'staffName': instance.staffName,
      'shopId': instance.shopId,
      'roles': instance.roles,
      'functions': instance.functions,
      'checkResult': instance.checkResult,
      'tenantId': instance.tenantId,
      'clientCode': instance.clientCode,
    };
