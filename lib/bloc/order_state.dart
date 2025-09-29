import 'package:equatable/equatable.dart';
import '../models/menu_item.dart';

abstract class OrderState extends Equatable {
  const OrderState();
  @override
  List<Object?> get props => [];
}

class OrderInitial extends OrderState {}

class OrderUpdated extends OrderState {
  final Map<MenuItem, int> items;
  final double total;
  const OrderUpdated({required this.items, required this.total});
  @override
  List<Object?> get props => [items, total];
}

class OrderPlacing extends OrderState {}

class OrderSuccess extends OrderState {
  final String orderId;
  const OrderSuccess(this.orderId);
  @override
  List<Object?> get props => [orderId];
}

class OrderFailure extends OrderState {
  final String message;
  const OrderFailure(this.message);
  @override
  List<Object?> get props => [message];
}
