// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'greeter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HelloRequest _$HelloRequestFromJson(Map<String, dynamic> json) => HelloRequest(
      name: json['name'] as String,
    );

Map<String, dynamic> _$HelloRequestToJson(HelloRequest instance) =>
    <String, dynamic>{
      'name': instance.name,
    };

HelloReply _$HelloReplyFromJson(Map<String, dynamic> json) => HelloReply(
      message: json['message'] as String,
    );

Map<String, dynamic> _$HelloReplyToJson(HelloReply instance) =>
    <String, dynamic>{
      'message': instance.message,
    };
