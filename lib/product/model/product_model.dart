class ProductModel {
  String productId;
  String productName;
  String description;
  String price;

  ProductModel({
    required this.productId,
    required this.productName,
    required this.description,
     required this.price,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      productId: json['productId'],
      productName: json['productName'],
      description: json['description'],
      price: json['price'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'productName': productName,
      'description': description,
      'price': price,
    };
  }
}
