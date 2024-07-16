part of 'barbershop_cubit.dart';

sealed class BarbershopState extends Equatable {
  const BarbershopState();

  @override
  List<Object> get props => [];
}

final class BarbershopInitial extends BarbershopState {}

final class BarbershopLoading extends BarbershopState {}

final class BarbershopSuccess extends BarbershopState {
  final String? message;
  const BarbershopSuccess({
    this.message,
  });
}

final class BarbershopActualSuccess extends BarbershopState {
  final BarbershopModel barbershop;
  const BarbershopActualSuccess({
    required this.barbershop,
  });
}

final class BarbershopCepSuccess extends BarbershopState {}

final class BarbershopFailure extends BarbershopState {
  final String errorMessage;
  const BarbershopFailure({
    required this.errorMessage,
  });

  @override
  List<Object> get props => [errorMessage];
}

final class BarbershopCepFail extends BarbershopState {
  final String errorMessage;
  const BarbershopCepFail({
    required this.errorMessage,
  });

  @override
  List<Object> get props => [errorMessage];
}
