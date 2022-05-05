import 'dart:convert';

import 'package:zspace/domain/entities/user.dart';

class UserModel extends User {
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
        );

  final int? id;
  final String? userName;
  final String? emailAddress;
  final String? phoneNumber;
  final int? credit;
  final int? levelId;
  final dynamic? roleUser;
  final DateTime? createdAt;
  final DateTime? lastLogin;
  final String? accessToken;

  fromRawJson(String str) => fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

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
      };
}
