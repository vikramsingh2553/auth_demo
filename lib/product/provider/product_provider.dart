
import 'package:auth_demo/product/model/product_model.dart';
import 'package:auth_demo/product/service/product_service.dart';
import 'package:flutter/material.dart';

class ProductProvider with ChangeNotifier {
  final ProductService _productService = ProductService();
  List<ProductModel> _products = [];

  List<ProductModel> get products => _products;

  Future<void> fetchProducts() async {
    try {
      _products = await _productService.getProduct();
      notifyListeners();
    } catch (e) {
      print("Error fetching products: $e");
    }
  }

  Future<void> addProduct(ProductModel productModel) async {
    try {
      await _productService.addProduct(productModel);
      _products.add(productModel);
      notifyListeners();
    } catch (e) {
      print("Error adding product: $e");
    }
  }

  Future<void> deleteProduct(String id) async {
    try {
      await _productService.deleteProduct(id);
      _products.removeWhere((product) => product.productId == id);
      notifyListeners();
    } catch (e) {
      print("Error deleting product: $e");
    }
  }
  Future<void> updateProduct(ProductModel productModel) async {
    try {
      await _productService.updateProduct(productModel);
      int index = _products
          .indexWhere((product) => product.productId == productModel.productId);
      if (index != -1) {
        _products[index] = productModel;
        notifyListeners();
      }
    } catch (e) {
      print("Error updating product: $e");
    }
  }
}
