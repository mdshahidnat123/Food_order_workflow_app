import 'package:flutter_bloc/flutter_bloc.dart';
import 'order_event.dart';
import 'order_state.dart';
import '../models/menu_item.dart';
import '../repositories/order_repository.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final OrderRepository orderRepository;
  final Map<MenuItem, int> _cart = {};

  OrderBloc({required this.orderRepository}) : super(OrderInitial()) {
    on<AddItem>(_onAdd);
    on<RemoveItem>(_onRemove);
    on<PlaceOrder>(_onPlaceOrder);
  }

  void _onAdd(AddItem event, Emitter<OrderState> emit) {
    final item = event.item;
    _cart.update(item, (v) => v + 1, ifAbsent: () => 1);
    emit(OrderUpdated(items: Map.unmodifiable(_cart), total: _calculateTotal()));
  }

  void _onRemove(RemoveItem event, Emitter<OrderState> emit) {
    final item = event.item;
    if (!_cart.containsKey(item)) return;
    final current = _cart[item]!;
    if (current <= 1) {
      _cart.remove(item);
    } else {
      _cart[item] = current - 1;
    }
    emit(OrderUpdated(items: Map.unmodifiable(_cart), total: _calculateTotal()));
  }

  double _calculateTotal() {
    double t = 0.0;
    _cart.forEach((k, v) => t += k.price * v);
    return t;
  }

  Future<void> _onPlaceOrder(PlaceOrder event, Emitter<OrderState> emit) async {
    if (_cart.isEmpty) {
      emit(const OrderFailure('Cart is empty.'));
      return;
    }
    emit(OrderPlacing());
    try {
      final id = await orderRepository.placeOrder(
        Map.fromEntries(_cart.entries.map((e) => MapEntry(e.key.id, e.value))),
        _calculateTotal(),
      );
      _cart.clear();
      emit(OrderSuccess(id));
      // After success, emit empty updated state
      emit(const OrderUpdated(items: {}, total: 0.0));
    } catch (e) {
      emit(OrderFailure(e.toString()));
    }
  }
}
