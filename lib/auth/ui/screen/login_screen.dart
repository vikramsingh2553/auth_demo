import 'package:auth_demo/auth/model/user_model.dart';
import 'package:auth_demo/auth/provider/auth_provider.dart';
import 'package:auth_demo/auth/ui/screen/register_screen.dart';
import 'package:auth_demo/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Account'),
      ),
      body: Consumer<AuthProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                TextField(
                  obscureText: false,
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
                  decoration: const InputDecoration(
                    hintText: 'Input Password',
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                ElevatedButton(
                    onPressed: ()async {
                      UserModel userModel = UserModel(
                          email: emailController.text,
                          password: passwordController.text);
                      AuthProvider authProvider = Provider.of<AuthProvider>(
                          context, listen: false);

                      await authProvider.login(userModel);
                      if(!authProvider.isError) {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) {
                              return HomeScreen();
                            }));
                      }},
                    child: Text('Login')),
                SizedBox(
                  height: 16,
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return RegisterScreen();
                      }));
                    },
                    child: Text('Register'))
              ],
            ),
          );
        },
      ),
    );
  }
}
