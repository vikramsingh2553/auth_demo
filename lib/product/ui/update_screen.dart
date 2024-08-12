
import 'package:auth_demo/product/model/product_model.dart';
import 'package:auth_demo/product/provider/product_provider.dart';
import 'package:auth_demo/product/ui/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdateScreen extends StatefulWidget {
  const UpdateScreen({super.key, required String id});

  @override
  State<UpdateScreen> createState() => UpdateScreenState();
}

class UpdateScreenState extends State<UpdateScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController idController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                    hintText: 'Name',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
              const SizedBox(
                height: 12,
              ),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(
                    hintText: 'Description',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
              const SizedBox(
                height: 12,
              ),
              TextField(
                controller: idController,
                decoration: InputDecoration(
                    hintText: 'Id',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
              const SizedBox(
                height: 12,
              ),
              TextField(
                controller: priceController,
                decoration: InputDecoration(
                    hintText: 'Address',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  ProductProvider productProvider =
                  Provider.of<ProductProvider>(context, listen: false);
                  productProvider.updateProduct(ProductModel(
                    productId: idController.text,
                    productName: nameController.text,
                    description: descriptionController.text,
                    price: priceController.text,
                  ));
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HomeScreen(
                            id: '',
                          )));
                },
                child: Text('Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
