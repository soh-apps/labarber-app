import 'dart:convert';

class CompanyModel {
  final String id;
  final String name;
  final String address;
  final String phone;
  final String email;
  final String logo;
  final String website;
  final String description;

  CompanyModel({
    required this.id,
    required this.name,
    required this.address,
    required this.phone,
    required this.email,
    required this.logo,
    required this.website,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'phone': phone,
      'email': email,
      'logo': logo,
      'website': website,
      'description': description,
    };
  }

  factory CompanyModel.fromMap(Map<String, dynamic> map) {
    return CompanyModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      address: map['address'] ?? '',
      phone: map['phone'] ?? '',
      email: map['email'] ?? '',
      logo: map['logo'] ?? '',
      website: map['website'] ?? '',
      description: map['description'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CompanyModel.fromJson(String source) => CompanyModel.fromMap(json.decode(source));
}
