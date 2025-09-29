import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:food_order_workflow/bloc/order_bloc.dart';
import 'package:food_order_workflow/bloc/order_event.dart';
import 'package:food_order_workflow/bloc/order_state.dart';
import 'package:food_order_workflow/models/menu_item.dart';
import 'package:food_order_workflow/repositories/order_repository.dart';

class MockOrderRepo extends Mock implements OrderRepository {}

void main() {
  late OrderRepository repo;
  late OrderBloc bloc;

  setUp(() {
    repo = MockOrderRepo();
    bloc = OrderBloc(orderRepository: repo);
  });

  final sampleItem = MenuItem(id: 'm1', name: 'Test', description: 'd', price: 100.0);

  test('add item updates cart', () {
    bloc.add(AddItem(sampleItem));
    // wait for event to be processed
    return expectLater(bloc.stream, emits(isA<OrderUpdated>()));
  });

  blocTest<OrderBloc, OrderState>(
    'place order success',
    setUp: () {
      when(() => repo.placeOrder(any(), any())).thenAnswer((_) async => 'ORD-123');
    },
    build: () => bloc,
    act: (b) {
      b.add(AddItem(sampleItem));
      b.add(PlaceOrder());
    },
    expect: () => [
      isA<OrderUpdated>(),
      isA<OrderPlacing>(),
      isA<OrderSuccess>(),
      isA<OrderUpdated>(),
    ],
  );

  blocTest<OrderBloc, OrderState>(
    'place order failure',
    setUp: () {
      when(() => repo.placeOrder(any(), any())).thenThrow(Exception('fail'));
    },
    build: () => bloc,
    act: (b) {
      b.add(AddItem(sampleItem));
      b.add(PlaceOrder());
    },
    expect: () => [
      isA<OrderUpdated>(),
      isA<OrderPlacing>(),
      isA<OrderFailure>(),
    ],
  );
}
