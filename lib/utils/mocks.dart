import 'package:la_barber/features/admin/barbershop/repository/models/company_model.dart';
import 'package:la_barber/features/common/auth/model/user_model.dart';

class Mocks {
  static final List<BarbershopModel> companies = [
    BarbershopModel(
      id: '1',
      name: 'Penha',
      address: 'Rua do João, 123',
      phone: '123456789',
      email: '',
      logo: '',
      website: '',
      description: '',
    ),
    BarbershopModel(
      id: '2',
      name: 'Centro',
      address: 'Rua do João, 123',
      phone: '123456789',
      email: '',
      logo: '',
      website: '',
      description: '',
    ),
    BarbershopModel(
      id: '3',
      name: 'Perifa',
      address: 'Rua do João, 123',
      phone: '123456789',
      email: '',
      logo: '',
      website: '',
      description: '',
    ),
  ];

  static final List<UserModel> userBarbers = [
    UserModel(
      name: 'João',
      userType: UserType.barber,
      token: '123',
      refreshToken: '123',
      credentialId: 1,
    ),
    UserModel(
      name: 'Mario',
      userType: UserType.barber,
      token: '123',
      refreshToken: '123',
      credentialId: 1,
    ),
    UserModel(
      name: 'Que Mario?',
      userType: UserType.barber,
      token: '123',
      refreshToken: '123',
      credentialId: 1,
    ),
    UserModel(
      name: 'Que Mario?',
      userType: UserType.barber,
      token: '123',
      refreshToken: '123',
      credentialId: 1,
    ),
    UserModel(
      name: 'Que Mario?',
      userType: UserType.barber,
      token: '123',
      refreshToken: '123',
      credentialId: 1,
    ),
    UserModel(
      name: 'Que Mario?',
      userType: UserType.barber,
      token: '123',
      refreshToken: '123',
      credentialId: 1,
    ),
  ];
}
