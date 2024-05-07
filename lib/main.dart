import 'package:flutter/material.dart';
import 'package:online_retail_shop/add_product.dart';
import 'package:online_retail_shop/product_list.dart';
import 'package:online_retail_shop/product_search.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: const Text(
            'Online shop',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Color.fromARGB(217, 222, 85, 85),
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.search,
                color: Color.fromARGB(255, 254, 254, 254),
                size: 30.0,
              ),
              onPressed: () {
                Navigator.push(
                  _scaffoldKey.currentContext!,
                  MaterialPageRoute(
                      builder: (context) => const ProductSearch()),
                );
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.add,
                color: Color.fromARGB(255, 254, 254, 254),
                size: 30.0,
              ),
              onPressed: () {
                Navigator.push(
                  _scaffoldKey.currentContext!,
                  MaterialPageRoute(
                      builder: (context) => const AddProductPage()),
                );
              },
            ),
          ],
        ),
        body: const ProductList(),
      ),
    );
  }
}
