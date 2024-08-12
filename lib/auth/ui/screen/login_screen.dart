import 'package:auth_demo/auth/ui/screen/phone_auth.dart';
import 'package:auth_demo/auth/ui/screen/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../product/ui/home_screen.dart';
import '../../model/user_model.dart';
import '../../provider/auth_provider.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isPassword = false;
  bool navigate = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AuthProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 36),
                    const SizedBox(height: 100),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Loging',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Enter your email and password',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 8, right: 8, top: 16),
                      child: TextFormField(
                        controller: emailController,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          hintText: 'Enter your Email',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Email';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            navigate =
                                formKey.currentState?.validate() ?? false;
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 8, right: 8, top: 16),
                      child: TextFormField(
                        controller: passwordController,
                        obscureText: !isPassword,
                        decoration: InputDecoration(
                          hintText: 'Enter Your password',
                          labelText: 'Password',
                          suffixIcon: IconButton(
                            icon: Icon(isPassword
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () {
                              setState(() {
                                isPassword = !isPassword;
                              });
                            },
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter password';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            navigate =
                                formKey.currentState?.validate() ?? false;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Align(
                      alignment: Alignment.centerRight,
                      child: Text('Forgot password?'),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: ElevatedButton(
                          onPressed: () async {
                            UserModel userModel = UserModel(
                                email: emailController.text.trim(),
                                password: passwordController.text.trim());
                            AuthProvider provider = Provider.of<AuthProvider>(
                                context,
                                listen: false);
                            await provider.login(userModel);
                            if (!provider.isError) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomeScreen(id: '',),
                                ),
                              );
                            }
                          },
                          child: Text(
                            'Login',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                            ),
                          )),
                    ),
                    const SizedBox(height: 8),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RegisterScreen(),
                            ),
                          );
                        },
                        child: Text(
                          'Don’t have an account? Signup',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Center(
                      child: ElevatedButton.icon(
                        icon: Image.asset(
                          'assets/download (2).png',
                          height: 24.0,
                          width: 24.0,
                        ),
                        label: const Text(
                          'Sign in with Google',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        onPressed: () async {
                          AuthProvider provider =
                              Provider.of<AuthProvider>(context, listen: false);
                          await provider.googleSignIn();
                          if (!provider.isError) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomeScreen(id: '',),
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.black,
                          backgroundColor: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),

                    Center(
                      child: ElevatedButton.icon(
                        icon: Image.asset(
                          'assets/download (2).png',
                          height: 24.0,
                          width: 24.0,
                        ),
                        label: const Text(
                          'Sign in with Phone',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        onPressed: ()  {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PhoneAuthScreen(),
                              ),
                            );

                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.black,
                          backgroundColor: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
