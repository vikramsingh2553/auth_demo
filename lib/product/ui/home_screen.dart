// import 'package:auth_demo/auth/provider/auth_provider.dart';
// import 'package:auth_demo/auth/ui/screen/login_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Home'),
//         backgroundColor: Colors.cyan,
//       ),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const Text(
//                 "Welcome to Home Screen",
//                 style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.cyan,
//                 ),
//               ),
//               const SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () async {
//                   final provider =
//                       Provider.of<AuthProvider>(context, listen: false);
//                   await provider.logout();
//                   if (!provider.isError) {
//                     Navigator.pushReplacement(context,
//                         MaterialPageRoute(builder: (context) {
//                       return const LogInScreen();
//                     }));
//                   }
//                 },
//                 style: ElevatedButton.styleFrom(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                 ),
//                 child: const Text(
//                   'Log Out',
//                   style: TextStyle(fontSize: 16),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:auth_demo/product/core/shared_pref_service.dart';
import 'package:auth_demo/product/provider/product_provider.dart';
import 'package:auth_demo/product/ui/add_screen.dart';
import 'package:auth_demo/product/ui/update_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required String id});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final SharedPreferencesService prefsService = SharedPreferencesService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ProductProvider>(
        builder: (context, productProvider, child) {
          return ListView.builder(
            itemCount: productProvider.products.length,
            itemBuilder: (context, index) {
              final product = productProvider.products[index];
              return Padding(
                padding: EdgeInsets.all(16),
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            product.productName,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () async {
                                  await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          UpdateScreen(id: product.productId),
                                    ),
                                  );
                                  await prefsService.addProduct(product);
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () {
                                  _deleteProduct(context, product.productId);
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(product.description),
                      const SizedBox(height: 8),
                      Text('ID: ${product.productId}'),
                      const SizedBox(height: 8),
                      Text(product.price),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddScreen()),
          );
          await prefsService.saveProducts(
              Provider.of<ProductProvider>(context, listen: false).products);
        },
      ),
    );
  }

  Future<void> _deleteProduct(BuildContext context, String productId) async {
    final productProvider =
    Provider.of<ProductProvider>(context, listen: false);
    await productProvider.deleteProduct(productId);
    await prefsService.deleteProduct(productId);
  }
}
