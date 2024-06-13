import 'dart:convert';

enum UserType {
  master,
  admin,
  manager,
  barber,
  client;
}

UserType getType(int codUserType) {
  switch (codUserType) {
    case 1:
      return UserType.master;
    case 2:
      return UserType.admin;
    case 3:
      return UserType.manager;
    case 4:
      return UserType.barber;
    case 5:
      return UserType.client;
    default:
      return UserType.client;
  }
}

int getTypeCode(UserType userType) {
  switch (userType) {
    case UserType.master:
      return 1;
    case UserType.admin:
      return 2;
    case UserType.manager:
      return 3;
    case UserType.barber:
      return 4;
    case UserType.client:
      return 5;
    default:
      return 5;
  }
}

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
      'userType': userType != null ? getTypeCode(userType!) : null,
      'credentialId': credentialId,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      token: map['token'],
      refreshToken: map['refreshToken'],
      userType: getType(map['userType']?.toInt()),
      name: map['name'],
      credentialId: map['credentialId'].toInt(),
    );
  }

  String toJson() => jsonEncode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(jsonDecode(source));
}
