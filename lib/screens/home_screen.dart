import 'package:flutter/material.dart';
import '../models/restaurant.dart';
import '../models/menu_item.dart';
import 'restaurant_menu_screen.dart';

const sampleData = [
  Restaurant(
    id: 'r1',
    name: 'Tasty Bites',
    cuisine: 'Indian',
    menu: [
      MenuItem(id: 'm1', name: 'Butter Chicken', description: 'Creamy delight', price: 220.0),
      MenuItem(id: 'm2', name: 'Paneer Tikka', description: 'Grilled paneer', price: 160.0),
    ],
  ),
  Restaurant(
    id: 'r2',
    name: 'Noodle House',
    cuisine: 'Chinese',
    menu: [
      MenuItem(id: 'm3', name: 'Chow Mein', description: 'Veg noodles', price: 120.0),
      MenuItem(id: 'm4', name: 'Manchurian', description: 'Spicy starter', price: 140.0),
    ],
  ),
];

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Local Restaurants'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              // simple navigation to first restaurant's menu for demo
              if (sampleData.isNotEmpty) {
                Navigator.push(context, MaterialPageRoute(builder: (_) => RestaurantMenuScreen(restaurant: sampleData[0])));
              }
            },
          )
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: sampleData.length,
        itemBuilder: (context, i) {
          final r = sampleData[i];
          return Card(
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              contentPadding: const EdgeInsets.all(12),
              title: Text(r.name, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(r.cuisine),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => RestaurantMenuScreen(restaurant: r)));
              },
            ),
          );
        },
      ),
    );
  }
}
