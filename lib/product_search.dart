import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:online_retail_shop/product_entity.dart';
import 'package:online_retail_shop/purchase_page.dart';

class ProductSearch extends StatefulWidget {
  const ProductSearch({Key? key}) : super(key: key);

  @override
  _ProductSearchState createState() => _ProductSearchState();
}

class _ProductSearchState extends State<ProductSearch> {
  List<Product> products = [];
  List<Product> filteredProducts = [];
  TextEditingController _searchController = TextEditingController();

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
        filteredProducts = products;
      });
    } else {
      throw Exception('Failed to fetch products');
    }
  }

  void _filterProducts(String query) {
    setState(() {
      filteredProducts = products
          .where((product) =>
              product.productName.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
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
        filteredProducts[index] = products[index];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Product Search',
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        backgroundColor: Color.fromARGB(217, 222, 85, 85),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Search functionality
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search products...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              onChanged: _filterProducts,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredProducts.length,
              itemBuilder: (context, index) {
                final product = filteredProducts[index];
                return Card(
                  color: const Color.fromARGB(255, 196, 224, 164),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage('assets/product_image.jpg'),
                    ),
                    title: Text(product.productName),
                    subtitle: Text(
                      'Quantity: ${product.quantity}',
                      style: TextStyle(
                        color:
                            product.quantity == 0 ? Colors.red : Colors.black,
                      ),
                    ),
                    trailing: product.quantity == 0
                        ? const SizedBox()
                        : ElevatedButton(
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
          ),
        ],
      ),
    );
  }
}
