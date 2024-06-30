part of 'servico_cubit.dart';

sealed class ServicoState extends Equatable {
  const ServicoState();

  @override
  List<Object> get props => [];
}

final class ServicoInitial extends ServicoState {}

final class ServicoLoading extends ServicoState {}

final class ServicoSuccess extends ServicoState {}

final class ServicoFailure extends ServicoState {
  final String errorMessage;
  const ServicoFailure({
    required this.errorMessage,
  });

  @override
  List<Object> get props => [errorMessage];
}
