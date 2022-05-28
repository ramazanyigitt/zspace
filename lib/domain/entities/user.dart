import 'package:equatable/equatable.dart';

class User extends Equatable {
  User({
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
  });

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

  @override
  List<Object?> get props => [
        id,
        userName,
        emailAddress,
        phoneNumber,
        credit,
        levelId,
        roleUser,
        createdAt,
        lastLogin,
        accessToken,
      ];
}
