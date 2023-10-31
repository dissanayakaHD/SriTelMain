import 'package:json_annotation/json_annotation.dart';

part 'model.g.dart';

@JsonSerializable()
class User {
  @JsonKey(name: '_id')
  String? id;
  String email;
  String password;
  String NIC;
  String phoneNumber;
  String address;

  User({
    this.id,
    required this.email,
    required this.password,
    required this.NIC,
    required this.phoneNumber,
    required this.address,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}

@JsonSerializable()
class Bill {
  double amount;
  double dueAmount;
  double paybleAmount;

  Bill({
    required this.amount,
    required this.dueAmount,
    required this.paybleAmount,
  });

  factory Bill.fromJson(Map<String, dynamic> json) => _$BillFromJson(json);
  Map<String, dynamic> toJson() => _$BillToJson(this);
}

@JsonSerializable()
class Chat {
  String userId;
  String messageContent;
  bool isAgent;

  Chat({
    required this.userId,
    required this.messageContent,
    this.isAgent = false,
  });

  factory Chat.fromJson(Map<String, dynamic> json) => _$ChatFromJson(json);
  Map<String, dynamic> toJson() => _$ChatToJson(this);
}

@JsonSerializable()
class Issue {
  String userId;
  String messageContent;
  bool state;

  Issue({required this.userId, required this.messageContent, this.state = false});

  factory Issue.fromJson(Map<String, dynamic> json) => _$IssueFromJson(json);
  Map<String, dynamic> toJson() => _$IssueToJson(this);
}

@JsonSerializable()
class Vas {
  String userId;
  @JsonKey(name: 'RingInTone')
  bool ringInTone;
  @JsonKey(name: 'Roaming')
  bool roaming;
  @JsonKey(name: 'NewsAlerts')
  bool newsAlerts;
  @JsonKey(name: 'SportUpdates')
  bool sportUpdates;
  @JsonKey(name: 'GPRSService')
  bool gprsService;

  Vas({
    required this.userId,
    this.ringInTone = false,
    this.roaming = false,
    this.newsAlerts = false,
    this.sportUpdates = false,
    this.gprsService = false,
  });

  factory Vas.fromJson(Map<String, dynamic> json) => _$VasFromJson(json);
  Map<String, dynamic> toJson() => _$VasToJson(this);
}
