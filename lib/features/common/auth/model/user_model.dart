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

class UserModel {
  String token;
  String refreshToken;
  UserType? userType;
  String name;

  UserModel({required this.token, required this.refreshToken, this.userType, required this.name});

  Map<String, dynamic> toMap() {
    return {
      'token': token,
      'refreshToken': refreshToken,
      'userType': userType,
      'name': name,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      token: map['token'],
      refreshToken: map['refreshToken'],
      userType: getType(map['userType']?.toInt()),
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source));
}
