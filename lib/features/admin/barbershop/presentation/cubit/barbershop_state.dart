part of 'barbershop_cubit.dart';

sealed class BarbershopState extends Equatable {
  const BarbershopState();

  @override
  List<Object> get props => [];
}

final class BarbershopInitial extends BarbershopState {}

final class BarbershopLoading extends BarbershopState {}

final class BarbershopSuccess extends BarbershopState {}

final class BarbershopFailure extends BarbershopState {}
