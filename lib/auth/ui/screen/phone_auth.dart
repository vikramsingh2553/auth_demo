import 'package:auth_demo/auth/ui/screen/otp_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PhoneAuthScreen extends StatefulWidget {
  const PhoneAuthScreen({super.key});

  @override
  State<PhoneAuthScreen> createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Phone Auth'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: TextField(
              controller: phoneController,
              decoration: InputDecoration(
                hintText: "Enter Phone Number",
                suffixIcon: Icon(Icons.phone),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(24)),
              ),
            ),
          ),
          SizedBox(
            height: 16,
          ),
          ElevatedButton(
            onPressed: () async {
              FirebaseAuth.instance.verifyPhoneNumber(
                  verificationCompleted: (PhoneAuthCredential credential) {},
                  verificationFailed: (FirebaseAuthException ex) {},
                  codeSent: (String verificationid, int? resendToken) {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>OtpScreen(verificationid: verificationid,)));
                  },
                  codeAutoRetrievalTimeout: (String verificationId) {},
                  phoneNumber: phoneController.text.toString());
            },
            child: Text('Verify Phone Number'),
          ),
        ],
      ),
    );
  }
}
