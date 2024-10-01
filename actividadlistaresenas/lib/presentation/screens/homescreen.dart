import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../assets/products.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Listado de Productos'),
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return ListTile(
            leading: Image.network(product['thumbnail']),
            title: Text(product['title']),
            subtitle: Text('\$${product['price'].toStringAsFixed(2)}'),
            onTap: () {
              // PEPE NO TINC NI IDEA PA QUE VALIA AÇO, ARA YA EU SE
              context.go('/product/${product['id']}');
            },
          );
        },
      ),
    );
  }
}
