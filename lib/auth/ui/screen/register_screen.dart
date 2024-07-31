import 'package:auth_demo/auth/model/user_model.dart';
import 'package:auth_demo/auth/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Account'),
      ),
      body: Consumer<AuthProvider>(builder: (context, provider, child) {

        if(provider.isLoading){
          return Center(child: CircularProgressIndicator(),);
        }
        return Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: 'Input Email',
                ),
              ),
              SizedBox(
                height: 16,
              ),
              TextField(
                obscureText: true,
                controller: passwordController,
                decoration: InputDecoration(
                  hintText: 'Input Password',
                ),
              ),
              SizedBox(
                height: 16,
              ),
              TextField(
                obscureText: true,
                controller: confirmPasswordController,
                decoration: InputDecoration(
                  hintText: 'Input Confirm Password',
                ),
              ),
              SizedBox(
                height: 16,
              ),
              ElevatedButton(
                  onPressed: () async {
                    if (passwordController.text !=
                        confirmPasswordController.text) {
                      Fluttertoast.showToast(msg: 'Password does not match ');
                    } else {
                      UserModel userModel = UserModel(
                          email: emailController.text,
                          password: passwordController.text);
                      AuthProvider provider = Provider.of<AuthProvider>(
                          context, listen: false);

                      await provider.createAccount(userModel);

                      if (!provider.isError) {
                        Navigator.pop(context);
                      }
                    }
                  },
                  child: Text('Create Account'))
            ],
          ),
        );
      }),
    );
  }
}
