// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['_id'] as String?,
      email: json['email'] as String,
      password: json['password'] as String,
      NIC: json['NIC'] as String,
      phoneNumber: json['phoneNumber'] as String,
      address: json['address'] as String,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      '_id': instance.id,
      'email': instance.email,
      'password': instance.password,
      'NIC': instance.NIC,
      'phoneNumber': instance.phoneNumber,
      'address': instance.address,
    };

Bill _$BillFromJson(Map<String, dynamic> json) => Bill(
      amount: (json['amount'] as num).toDouble(),
      dueAmount: (json['dueAmount'] as num).toDouble(),
      paybleAmount: (json['paybleAmount'] as num).toDouble(),
    );

Map<String, dynamic> _$BillToJson(Bill instance) => <String, dynamic>{
      'amount': instance.amount,
      'dueAmount': instance.dueAmount,
      'paybleAmount': instance.paybleAmount,
    };

Chat _$ChatFromJson(Map<String, dynamic> json) => Chat(
      userId: json['userId'] as String,
      messageContent: json['messageContent'] as String,
      isAgent: json['isAgent'] as bool? ?? false,
    );

Map<String, dynamic> _$ChatToJson(Chat instance) => <String, dynamic>{
      'userId': instance.userId,
      'messageContent': instance.messageContent,
      'isAgent': instance.isAgent,
    };

Issue _$IssueFromJson(Map<String, dynamic> json) => Issue(
      userId: json['userId'] as String,
      messageContent: json['messageContent'] as String,
      state: json['state'] as bool? ?? false,
    );

Map<String, dynamic> _$IssueToJson(Issue instance) => <String, dynamic>{
      'userId': instance.userId,
      'messageContent': instance.messageContent,
      'state': instance.state,
    };

Vas _$VasFromJson(Map<String, dynamic> json) => Vas(
      userId: json['userId'] as String,
      ringInTone: json['RingInTone'] as bool? ?? false,
      roaming: json['Roaming'] as bool? ?? false,
      newsAlerts: json['NewsAlerts'] as bool? ?? false,
      sportUpdates: json['SportUpdates'] as bool? ?? false,
      gprsService: json['GPRSService'] as bool? ?? false,
    );

Map<String, dynamic> _$VasToJson(Vas instance) => <String, dynamic>{
      'userId': instance.userId,
      'RingInTone': instance.ringInTone,
      'Roaming': instance.roaming,
      'NewsAlerts': instance.newsAlerts,
      'SportUpdates': instance.sportUpdates,
      'GPRSService': instance.gprsService,
    };
