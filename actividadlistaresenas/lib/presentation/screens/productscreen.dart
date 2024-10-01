import 'package:flutter/material.dart';
import '../../assets/products.dart';

class ProductScreen extends StatelessWidget {
  final int productId;

  ProductScreen({required this.productId});

  @override
  Widget build(BuildContext context) {
    final product = products.firstWhere((prod) => prod['id'] == productId);

    return Scaffold(
      appBar: AppBar(
        title: Text(product['title']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 200,
              width: double.infinity,
              //AÇO ES PER AL TAMANY DE LES IMATJES
              child: Image.network(
                product['images'][0],
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 16),
            Text(
              product['title'],
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              '\$${product['price'].toStringAsFixed(2)}',
              style: TextStyle(fontSize: 20, color: Colors.green),
            ),
            SizedBox(height: 16),
            Text(
              product['description'],
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'Reseñas',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: product['reviews'].length,
                itemBuilder: (context, index) {
                  final review = product['reviews'][index];
                  return ListTile(
                    title: Text(review['comment']),
                    subtitle: Text('Rating: ${review['rating']}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
