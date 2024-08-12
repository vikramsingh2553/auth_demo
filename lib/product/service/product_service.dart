


import 'package:auth_demo/product/model/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductService {
  final CollectionReference productCollection =
  FirebaseFirestore.instance.collection('product');

  Future<void> addProduct(ProductModel productModel) async {
    String productId = productCollection.doc().id;
    productModel.productId = productId;
    await productCollection.doc(productId).set(productModel.toJson());
  }

  Future<void> deleteProduct(String id) async {
    await productCollection.doc(id).delete();
  }

  Future<List<ProductModel>> getProduct() async {
    QuerySnapshot snapshot = await productCollection.get();
    return snapshot.docs.map((doc) {
      return ProductModel.fromJson(doc.data() as Map<String, dynamic>);
    }).toList();
  }

  Future<void> updateProduct(ProductModel productModel) async {
    await productCollection
        .doc(productModel.productId)
        .update(productModel.toJson());
  }
}
