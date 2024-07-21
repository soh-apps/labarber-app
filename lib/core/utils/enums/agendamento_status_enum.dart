enum AgendamentoStatus {
  agendado,

  realizado,
  cancelado,
}

class AgendamentoStatusHelper {
  // Converte um código numérico para um AgendamentoStatus
  static AgendamentoStatus getStatus(int code) {
    switch (code) {
      case 0:
        return AgendamentoStatus.agendado;
      case 1:
        return AgendamentoStatus.realizado;
      case 2:
        return AgendamentoStatus.cancelado;
      default:
        return AgendamentoStatus.agendado;
    }
  }

  // Converte um AgendamentoStatus para um código numérico
  static int getStatusCode(AgendamentoStatus status) {
    switch (status) {
      case AgendamentoStatus.agendado:
        return 0;
      case AgendamentoStatus.realizado:
        return 1;
      case AgendamentoStatus.cancelado:
        return 2;
      default:
        return 0;
    }
  }

  // Converte um AgendamentoStatus para uma string legível
  static String getStatusName(AgendamentoStatus status) {
    switch (status) {
      case AgendamentoStatus.agendado:
        return 'Agendado';
      case AgendamentoStatus.realizado:
        return 'Realizado';
      case AgendamentoStatus.cancelado:
        return 'Cancelado';
      default:
        return 'Agendado';
    }
  }

  // Converte um AgendamentoStatus para uma string legível
  static String getStatusNameForInt(int status) {
    switch (status) {
      case 0:
        return 'Agendado';
      case 1:
        return 'Realizado';
      case 2:
        return 'Cancelado';
      default:
        return 'Agendado';
    }
  }
}
