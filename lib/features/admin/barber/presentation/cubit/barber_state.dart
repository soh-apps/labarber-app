part of 'barber_cubit.dart';

sealed class BarberState extends Equatable {
  const BarberState();

  @override
  List<Object> get props => [];
}

final class BarberInitial extends BarberState {}

final class BarberLoading extends BarberState {}

final class BarberSuccess extends BarberState {}

final class BarberFailure extends BarberState {
  final String errorMessage;
  const BarberFailure({
    required this.errorMessage,
  });

  @override
  List<Object> get props => [errorMessage];
}
