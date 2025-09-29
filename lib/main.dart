import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/order_bloc.dart';
import 'screens/home_screen.dart';
import 'repositories/order_repository.dart';

void main() {
  final repo = OrderRepository();
  runApp(MyApp(orderRepository: repo));
}

class MyApp extends StatelessWidget {
  final OrderRepository orderRepository;
  const MyApp({super.key, required this.orderRepository});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: orderRepository,
      child: BlocProvider(
        create: (_) => OrderBloc(orderRepository: orderRepository),
        child: MaterialApp(
          title: 'Food Order Workflow',
          theme: ThemeData(
            primarySwatch: Colors.deepOrange,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: const HomeScreen(),
        ),
      ),
    );
  }
}
