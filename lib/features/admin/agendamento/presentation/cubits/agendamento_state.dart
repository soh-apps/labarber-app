part of 'agendamento_cubit.dart';

sealed class AgendamentoState extends Equatable {
  const AgendamentoState();

  @override
  List<Object> get props => [];
}

final class AgendamentoInitial extends AgendamentoState {}

final class AgendamentoLoading extends AgendamentoState {}

final class AgendamentoSuccess extends AgendamentoState {}

final class AgendamentoFailure extends AgendamentoState {
  final String errorMessage;
  const AgendamentoFailure({
    required this.errorMessage,
  });

  @override
  List<Object> get props => [errorMessage];
}
