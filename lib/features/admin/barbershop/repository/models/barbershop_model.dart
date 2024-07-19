import 'package:la_barber/features/admin/barbershop/repository/models/working_hour.dart';

class BarbershopModel {
  final int id;
  final String name;
  final String phone;
  final String email;
  final String logo;
  final String website;
  final String description;
  final String city;
  final String state;
  final String street;
  final String? number;
  final String? complement;
  final String zipCode;
  List<WorkingHour>? workingHours;

  BarbershopModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.logo,
    required this.website,
    required this.description,
    required this.city,
    required this.state,
    required this.street,
    this.number,
    this.complement = '',
    required this.zipCode,
    this.workingHours,
  });

  Map<String, dynamic> toMapv0() {
    return {
      'name': name,
      'city': city,
      'state': state,
      'street': street,
      'number': number,
      'phone': phone,
      'zipCode': zipCode,
      'complement': complement,
      'workingHours': workingHours?.map((wh) => wh.toMap()).toList(),
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'city': city,
      'state': state,
      'street': street,
      'number': number,
      'phone': phone,
      'zipCode': zipCode,
      'complement': complement,
      'workingHours': workingHours?.map((wh) => wh.toMap()).toList(),
    };
  }

  factory BarbershopModel.fromMap(Map<String, dynamic> map) {
    return BarbershopModel(
      id: map['id'],
      name: map['name'] ?? '',
      phone: map['phone'] ?? '',
      email: map['email'] ?? '',
      logo: map['logo'] ?? '',
      website: map['website'] ?? '',
      description: map['description'] ?? '',
      city: map['city'] ?? '',
      state: map['state'] ?? '',
      street: map['street'] ?? '',
      number: map['number'] ?? '',
      complement: map['complement'] ?? '',
      zipCode: map['zipCode'] ?? '',
      workingHours: map['availabilities'] != null
          ? List<WorkingHour>.from(map['availabilities'].map((x) => WorkingHour.fromJson(x)))
          : null,
    );
  }

  static List<BarbershopModel> fromList(List<dynamic> list) {
    return list.map((item) => BarbershopModel.fromMap(item)).toList();
  }
}
