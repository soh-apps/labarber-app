import 'package:la_barber/core/utils/user_type_enum.dart';

class BarberModel {
  final int? id;
  final String? username;
  final String? email;
  final String? password;
  final String name;
  final String? city;
  final String? state;
  final String? street;
  final String? number;
  final String? telefone;
  final String? complement;
  final String? zipCode;
  final String? imageUrl;
  final bool commissioned;
  final int barberUnitId;
  final int status;
  final bool isManager;
  final UserType userType;
  BarberModel({
    this.id,
    this.username,
    this.email,
    this.password,
    required this.name,
    this.city,
    this.state,
    this.street,
    this.number,
    this.telefone,
    this.complement,
    this.imageUrl,
    this.zipCode,
    this.status = 1,
    required this.commissioned,
    required this.barberUnitId,
    required this.isManager,
    required this.userType,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'password': password,
      'name': name,
      'city': city,
      'state': state,
      'street': street,
      'number': number,
      'telefone': telefone,
      'complement': complement,
      'zipCode': zipCode,
      'commissioned': commissioned,
      'barberUnitId': barberUnitId,
      'isManager': isManager,
      // 'imageUrl': imageUrl,
    };
  }

  Map<String, dynamic> toMapUpdate() {
    return {
      'barberId': id,
      'username': username,
      'email': email,
      'password': password,
      'name': name,
      'city': city,
      'state': state,
      'street': street,
      'number': number,
      'telefone': telefone,
      'complement': complement,
      'zipCode': zipCode,
      'commissioned': commissioned,
      'barberUnitId': barberUnitId,
      'isManager': isManager,
      'role': UserTypeHelper.getTypeCode(userType),
      'status': status,
      // 'imageUrl': imageUrl,
    };
  }

  factory BarberModel.fromMap(Map<String, dynamic> map) {
    return BarberModel(
      id: map['id'] ?? 0,
      username: map['username'] ?? '',
      email: map['email'] ?? '',
      password: map['password'],
      imageUrl: map['imageUrl'],
      name: map['name'] ?? '',
      city: map['city'],
      state: map['state'],
      street: map['street'],
      number: map['number'],
      telefone: map['telefone'],
      complement: map['complement'],
      zipCode: map['zipCode'],
      commissioned: map['commissioned'] ?? false,
      barberUnitId: map['barberUnitId']?.toInt() ?? 0,
      isManager: (UserTypeHelper.getType(map['role']) == UserType.manager),
      userType: UserTypeHelper.getType(map['role']),
    );
  }

  static List<BarberModel> fromList(List<dynamic> list) {
    return list.map((item) => BarberModel.fromMap(item)).toList();
  }
}
