import 'package:equatable/equatable.dart';
import '../models/menu_item.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();
  @override
  List<Object?> get props => [];
}

class AddItem extends OrderEvent {
  final MenuItem item;
  const AddItem(this.item);
  @override
  List<Object?> get props => [item];
}

class RemoveItem extends OrderEvent {
  final MenuItem item;
  const RemoveItem(this.item);
  @override
  List<Object?> get props => [item];
}

class PlaceOrder extends OrderEvent {}
