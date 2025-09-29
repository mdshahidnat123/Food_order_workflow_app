import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/restaurant.dart';
import '../models/menu_item.dart';
import '../bloc/order_bloc.dart';
import '../bloc/order_event.dart';
import '../bloc/order_state.dart';

class RestaurantMenuScreen extends StatelessWidget {
  final Restaurant restaurant;
  const RestaurantMenuScreen({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(restaurant.name),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: restaurant.menu.length,
              itemBuilder: (context, i) {
                final item = restaurant.menu[i];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: ListTile(
                    title: Text(item.name),
                    subtitle: Text(item.description),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('₹ ${item.price.toStringAsFixed(0)}'),
                        const SizedBox(height: 6),
                        ElevatedButton(
                          onPressed: () {
                            context.read<OrderBloc>().add(AddItem(item));
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Added to cart')));
                          },
                          child: const Text('Add'),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          BlocConsumer<OrderBloc, OrderState>(
            listener: (context, state) {
              if (state is OrderFailure) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
              } else if (state is OrderSuccess) {
                showDialog(context: context, builder: (_) => AlertDialog(
                  title: const Text('Order Placed'),
                  content: Text('Order ID: ${state.orderId}'),
                  actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('OK'))],
                ));
              }
            },
            builder: (context, state) {
              double total = 0;
              int itemCount = 0;
              Map<MenuItem,int> items = {};
              if (state is OrderUpdated) {
                total = state.total;
                items = state.items;
                itemCount = items.values.fold(0, (p, e) => p + e);
              }
              return Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
                ),
                child: Row(
                  children: [
                    Expanded(child: Text('Items: $itemCount  |  Total: ₹${total.toStringAsFixed(0)}')),
                    ElevatedButton(
                      onPressed: itemCount==0 ? null : () {
                        context.read<OrderBloc>().add(PlaceOrder());
                      },
                      child: const Text('Checkout'),
                    )
                  ],
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
