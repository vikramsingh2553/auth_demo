import 'package:auth_demo/auth/provider/auth_provider.dart';
import 'package:auth_demo/auth/service/auth_service.dart';
import 'package:auth_demo/auth/ui/screen/login_screen.dart';
import 'package:auth_demo/product/provider/product_provider.dart'; // Import ProductProvider
import 'package:auth_demo/product/ui/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AuthService());
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => ProductProvider()), // Add ProductProvider
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: HomeScreen(id: '',),
      ),
    );
  }
}
