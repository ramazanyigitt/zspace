import 'dart:convert';
import 'dart:developer';

import 'package:hive/hive.dart';

import '../../domain/entities/user.dart';

part 'user_model.g.dart';

@HiveType(typeId: 1)
// ignore: must_be_immutable
class UserModel extends User with HiveObjectMixin {
  UserModel({
    this.id,
    this.userName,
    this.emailAddress,
    this.phoneNumber,
    this.credit,
    this.levelId,
    this.roleUser,
    this.createdAt,
    this.lastLogin,
    this.accessToken,
    this.stayLoggedIn,
  }) : super(
          id: id,
          userName: userName,
          emailAddress: emailAddress,
          phoneNumber: phoneNumber,
          credit: credit,
          levelId: levelId,
          roleUser: roleUser,
          createdAt: createdAt,
          lastLogin: lastLogin,
          accessToken: accessToken,
          stayLoggedIn: stayLoggedIn,
        );

  @HiveField(0)
  int? id;
  @HiveField(1)
  String? userName;
  @HiveField(2)
  String? emailAddress;
  @HiveField(3)
  String? phoneNumber;
  @HiveField(4)
  int? credit;
  @HiveField(5)
  int? levelId;
  @HiveField(6)
  dynamic roleUser;
  @HiveField(7)
  DateTime? createdAt;
  @HiveField(8)
  DateTime? lastLogin;
  @HiveField(9)
  String? accessToken;
  @HiveField(10)
  bool? stayLoggedIn;

  fromRawJson(String str) => fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  updateFromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['userName'];
    emailAddress = json['emailAddress'];
    phoneNumber = json['phoneNumber'];
    credit = json['credit'];
    levelId = json['levelId'];
    roleUser = json['roleUser'];
    createdAt = DateTime.parse(json['createdAt']);
    lastLogin = DateTime.parse(json['lastLogin']);
    accessToken = json['access_token'];
    stayLoggedIn = json['stayLoggedIn'] ?? this.stayLoggedIn;
  }

  fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"] == null ? null : json["id"],
        userName: json["userName"] == null ? null : json["userName"],
        emailAddress:
            json["emailAddress"] == null ? null : json["emailAddress"],
        phoneNumber: json["phoneNumber"] == null ? null : json["phoneNumber"],
        credit: json["credit"] == null ? null : json["credit"],
        levelId: json["levelId"] == null ? null : json["levelId"],
        roleUser: json["roleUser"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        lastLogin: json["lastLogin"] == null
            ? null
            : DateTime.parse(json["lastLogin"]),
        accessToken: json["access_token"] == null ? null : json["access_token"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "userName": userName == null ? null : userName,
        "emailAddress": emailAddress == null ? null : emailAddress,
        "phoneNumber": phoneNumber == null ? null : phoneNumber,
        "credit": credit == null ? null : credit,
        "levelId": levelId == null ? null : levelId,
        "roleUser": roleUser,
        "createdAt": createdAt == null ? null : createdAt?.toIso8601String(),
        "lastLogin": lastLogin == null ? null : lastLogin?.toIso8601String(),
        "access_token": accessToken,
        "stayLoggedIn": stayLoggedIn,
      };
}
