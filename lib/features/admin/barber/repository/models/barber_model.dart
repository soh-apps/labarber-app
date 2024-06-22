class BarberModel {
  final String username;
  final String email;
  final String password;
  final String name;
  final String? city;
  final String? state;
  final String? street;
  final String? number;
  final String? complement;
  final String? zipCode;
  final bool commissioned;
  final int barberUnitId;
  final bool isManager;
  BarberModel({
    required this.username,
    required this.email,
    required this.password,
    required this.name,
    this.city,
    this.state,
    this.street,
    this.number,
    this.complement,
    this.zipCode,
    required this.commissioned,
    required this.barberUnitId,
    required this.isManager,
  });

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'email': email,
      'password': password,
      'name': name,
      'city': city,
      'state': state,
      'street': street,
      'number': number,
      'complement': complement,
      'zipCode': zipCode,
      'commissioned': commissioned,
      'barberUnitId': barberUnitId,
      'isManager': isManager,
    };
  }

  factory BarberModel.fromMap(Map<String, dynamic> map) {
    return BarberModel(
      username: map['username'],
      email: map['email'] ?? '',
      password: map['password'],
      name: map['name'] ?? '',
      city: map['city'],
      state: map['state'],
      street: map['street'],
      number: map['number'],
      complement: map['complement'],
      zipCode: map['zipCode'],
      commissioned: map['commissioned'],
      barberUnitId: map['barberUnitId']?.toInt() ?? 0,
      isManager: map['isManager'],
    );
  }
}
