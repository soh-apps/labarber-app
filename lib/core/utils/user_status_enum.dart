enum UserStatus {
  inactive,
  active,
  unavailable,
  onVacancy;
}

class UserStatusHelper {
  // Converte um código numérico para um UserStatus
  static UserStatus getStatus(int code) {
    switch (code) {
      case 0:
        return UserStatus.inactive;
      case 1:
        return UserStatus.active;
      case 2:
        return UserStatus.unavailable;
      case 3:
        return UserStatus.onVacancy;
      default:
        return UserStatus.inactive;
    }
  }

  // Converte um UserStatus para um código numérico
  static int getStatusCode(UserStatus status) {
    switch (status) {
      case UserStatus.inactive:
        return 0;
      case UserStatus.active:
        return 1;
      case UserStatus.unavailable:
        return 2;
      case UserStatus.onVacancy:
        return 3;
      default:
        return 0;
    }
  }

  // Converte um UserStatus para uma string legível
  static String getStatusName(UserStatus status) {
    switch (status) {
      case UserStatus.inactive:
        return 'Inativo';
      case UserStatus.active:
        return 'Ativo';
      case UserStatus.unavailable:
        return 'Indisponível';
      case UserStatus.onVacancy:
        return 'Em ferias';
      default:
        return 'Inativo';
    }
  }
}
