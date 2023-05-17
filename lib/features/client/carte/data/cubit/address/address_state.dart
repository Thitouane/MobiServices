part of 'address_cubit.dart';

abstract class AddressState {
  const AddressState();
}

class AddressInitial extends AddressState {}

class AddressLoading extends AddressState {}

class AddressLoaded extends AddressState {
  const AddressLoaded(this.content);

  final List<dynamic> content;
}
