import 'package:auth_demo/auth/provider/auth_provider.dart';
import 'package:auth_demo/auth/ui/screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text("Welcome to Home Screen"),
            SizedBox(),

            TextButton(onPressed: ()async{
          final provider = Provider.of<AuthProvider>(context,listen: false);
                   await provider.logOut();
         if(provider.isError) {
           Navigator.pushReplacement(context,
               MaterialPageRoute(builder: (context) {
                 return LoginScreen();
               }));

         } },
                child: Text('Log Out'))
          ],
        ),

      ),
    );
  }
}
