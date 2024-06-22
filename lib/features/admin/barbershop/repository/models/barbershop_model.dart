class BarbershopModel {
  final int id;
  final String name;
  final String address;
  final String phone;
  final String email;
  final String logo;
  final String website;
  final String description;
  List<int>? workingDays;

  BarbershopModel({
    required this.id,
    required this.name,
    required this.address,
    required this.phone,
    required this.email,
    required this.logo,
    required this.website,
    required this.description,
    this.workingDays,
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
      'workingdays': workingDays,
    };
  }

  factory BarbershopModel.fromMap(Map<String, dynamic> map) {
    return BarbershopModel(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
      address: map['address'] ?? '',
      phone: map['phone'] ?? '',
      email: map['email'] ?? '',
      logo: map['logo'] ?? '',
      website: map['website'] ?? '',
      description: map['description'] ?? '',
      workingDays: map['workingDays'] != null ? List<int>.from(map['workingDays']) : null,
    );
  }

  static List<BarbershopModel> fromList(List<dynamic> list) {
    return list.map((item) => BarbershopModel.fromMap(item)).toList();
  }
}
