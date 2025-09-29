import 'dart:math';
import 'dart:async';

class OrderRepository {
  // Simulate network call for placing order.
  // Randomly fail to demonstrate error handling.
  Future<String> placeOrder(Map<String, int> items, double total) async {
    await Future.delayed(const Duration(seconds: 2));
    final rnd = Random().nextDouble();
    if (rnd < 0.2) {
      throw Exception('Network error: failed to place order');
    }
    // return order id
    return 'ORD-${DateTime.now().millisecondsSinceEpoch}';
  }
}
