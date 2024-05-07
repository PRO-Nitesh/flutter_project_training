import 'package:flutter/material.dart';
import 'package:online_retail_shop/product_entity.dart';

class PurchasePage extends StatefulWidget {
  final Product product;
  final Function(Product, int) onPurchase;

  const PurchasePage({
    Key? key,
    required this.product,
    required this.onPurchase,
  }) : super(key: key);

  @override
  State<PurchasePage> createState() => _PurchasePageState();
}

class _PurchasePageState extends State<PurchasePage> {
  int _quantity = 1;

  void _incrementQuantity() {
    setState(() {
      if (_quantity < widget.product.quantity) {
        _quantity++;
      }
    });
  }

  void _decrementQuantity() {
    if (_quantity > 1) {
      setState(() {
        _quantity--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Purchase ${widget.product.productName}'),
          backgroundColor: Color.fromARGB(217, 234, 210, 149)),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            width: 400,
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 2.0),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 196, 224, 164),
              borderRadius: BorderRadius.circular(18.0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Product Details',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16.0),
                Image.asset(
                  'assets/product_image.jpg',
                  height: 200,
                  width: 200,
                ),
                const SizedBox(height: 16.0),
                Text(
                  'Product Name: ${widget.product.productName}',
                  style: const TextStyle(fontSize: 20.0),
                ),
                const SizedBox(height: 8.0),
                Text(
                  'Quantity Available: ${widget.product.quantity}',
                  style: const TextStyle(fontSize: 16.0),
                ),
                const SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: _decrementQuantity,
                      icon: const Icon(Icons.remove),
                    ),
                    Text('$_quantity'),
                    IconButton(
                      onPressed: _incrementQuantity,
                      icon: const Icon(Icons.add),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    widget.onPurchase(widget.product, _quantity);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'You bought $_quantity ${widget.product.productName}',
                          style: const TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Colors.green,
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    );
                    Navigator.pop(context);
                  },
                  child: const Text('Purchase'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
