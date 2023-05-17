part of 'type_bloc.dart';

abstract class TypeEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetAtHomeData extends TypeEvent {
  GetAtHomeData();
}