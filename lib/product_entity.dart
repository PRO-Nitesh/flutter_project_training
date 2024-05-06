class Product {
  final String productId;
  final String productName;
  final int quantity;
  final bool isActive;

  Product({
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.isActive,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productId: json['ProductId'] ?? '',
      productName: json['ProductName'] ?? '',
      quantity: json['Quantity'],
      isActive: json['IsActive'],
    );
  }
}
