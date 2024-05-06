import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:online_retail_shop/product_entity.dart';
import 'package:online_retail_shop/purchase_page.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  List<Product> products = [];

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    final response = await http.get(
      Uri.parse('https://uiexercise.theproindia.com/api/Product/GetAllProduct'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List;
      setState(() {
        products = data.map((json) => Product.fromJson(json)).toList();
      });
    } else {
      throw Exception('Check each product page for other buying options.');
    }
  }

  void _updateProductQuantity(Product product, int purchasedQuantity) {
    setState(() {
      int index = products.indexWhere((p) => p.productId == product.productId);
      if (index != -1) {
        products[index] = Product(
          productId: product.productId,
          productName: product.productName,
          quantity: product.quantity - purchasedQuantity,
          isActive: product.isActive,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return Card(
            color: const Color.fromARGB(255, 196, 224, 164),
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage('assets/product_image.jpg'),
              ),
              title: Text(product.productName),
              subtitle: Text('Quantity: ${product.quantity}'),
              trailing: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PurchasePage(
                        product: product,
                        onPurchase: _updateProductQuantity,
                      ),
                    ),
                  );
                },
                child: const Text('Purchase'),
              ),
            ),
          );
        },
      ),
    );
  }
}
