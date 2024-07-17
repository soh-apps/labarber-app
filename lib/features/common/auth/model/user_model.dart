import 'dart:convert';

import 'package:la_barber/core/utils/user_type_enum.dart';

class UserModel {
  String token;
  String refreshToken;
  String name;
  UserType? userType;
  int credentialId;

  UserModel({
    required this.token,
    required this.refreshToken,
    required this.name,
    this.userType,
    required this.credentialId,
  });

  Map<String, dynamic> toMap() {
    return {
      'token': token,
      'refreshToken': refreshToken,
      'name': name,
      'userType': userType != null ? UserTypeHelper.getTypeCode(userType!) : null,
      'credentialId': credentialId,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      token: map['token'],
      refreshToken: map['refreshToken'],
      userType: UserTypeHelper.getType(map['userType']?.toInt()),
      name: map['name'],
      credentialId: map['credentialId'].toInt(),
    );
  }

  String toJson() => jsonEncode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(jsonDecode(source));
}
