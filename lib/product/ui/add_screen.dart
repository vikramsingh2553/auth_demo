import 'package:auth_demo/product/model/product_model.dart';
import 'package:auth_demo/product/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController idController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SafeArea(
          child: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                    hintText: "Product Name",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)
                    )
                ),
              ),
              SizedBox(height: 10,),
              TextField(
                controller: idController,
                decoration: InputDecoration(
                    hintText: "ID",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)
                    )
                ),
              ),SizedBox(height: 10,),
              TextField(
                keyboardType: TextInputType.phone,
                controller: priceController,
                decoration: InputDecoration(
                    hintText: "Price",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)
                    )
                ),
              ),SizedBox(height: 10,),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(
                    hintText: "Description",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)
                    )
                ),
              ),
              SizedBox(height: 20,),
              ElevatedButton(
                onPressed: () {
                  ProductProvider productProvider = Provider.of<ProductProvider>(context, listen: false);
                  productProvider.addProduct(ProductModel(
                    productId: idController.text,
                    productName: nameController.text,
                    description: descriptionController.text,
                    price: priceController.text,
                  ));
                  Navigator.pop(context);
                },
                child: Text('Add Product'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}