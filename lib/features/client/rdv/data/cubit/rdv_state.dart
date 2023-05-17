
import 'package:booking_calendar/booking_calendar.dart';
import 'package:mobideliv/features/client/rdv/domain/entity/booking.dart';

abstract class RdvState {
  const RdvState();
}

class RdvInitial extends RdvState {}

class RdvError extends RdvState {
  final String error;
  RdvError(this.error);
  @override
  List<Object> get props => [error];
}

class RdvLoading extends RdvState {
  @override
  List<Object?> get props => [];
}

class RdvLoaded extends RdvState {
  List<BookingModel> mydata;
  RdvLoaded(this.mydata);
  @override
  List<Object?> get props => [];
}