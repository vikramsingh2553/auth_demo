
import 'package:auth_demo/product/model/product_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static const String productsKey = 'products';

  Future<SharedPreferences> getPreferences() async {
    return await SharedPreferences.getInstance();
  }

  Future<void> saveProducts(List<ProductModel> products) async {
    final prefs = await getPreferences();
    List<String> productsList =
    products.map((product) => product.toJson()).cast<String>().toList();
    await prefs.setStringList(productsKey, productsList);
  }

  Future<void> addProduct(ProductModel product) async {
    final prefs = await getPreferences();
    List<String>? productsList = prefs.getStringList(productsKey) ?? [];
    productsList.add(product.toJson() as String);
    await prefs.setStringList(productsKey, productsList);
  }

  Future<void> deleteProduct(String productId) async {
    final prefs = await getPreferences();
    List<String>? productsList = prefs.getStringList(productsKey) ?? [];
    productsList.removeWhere((productJson) {
      final product =
      ProductModel.fromJson(productJson as Map<String, dynamic>);
      return product.productId == productId;
    });
    await prefs.setStringList(productsKey, productsList);
  }

  Future<List<ProductModel>> getProducts() async {
    final prefs = await getPreferences();
    List<String>? productsList = prefs.getStringList(productsKey);
    if (productsList == null) return [];
    return productsList
        .map((productJson) =>
        ProductModel.fromJson(productJson as Map<String, dynamic>))
        .toList();
  }
}
