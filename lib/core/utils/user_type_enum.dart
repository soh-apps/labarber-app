enum UserType {
  master,
  admin,
  manager,
  barber,
  client;
}

class UserTypeHelper {
  // Converte um código numérico para um UserType
  static UserType getType(int codUserType) {
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

  // Converte um UserType para um código numérico
  static int getTypeCode(UserType userType) {
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
}
