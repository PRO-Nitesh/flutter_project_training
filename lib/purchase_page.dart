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
      _quantity++;
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
        backgroundColor: Color.fromARGB(197, 136, 255, 253),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            width: 400,
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 2.0),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 210, 198, 198),
              borderRadius: BorderRadius.circular(18.0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.product.productName,
                  style: const TextStyle(fontSize: 24.0),
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
                const SizedBox(height: 6.0),
                ElevatedButton(
                  onPressed: () {
                    widget.onPurchase(widget.product, _quantity);
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
