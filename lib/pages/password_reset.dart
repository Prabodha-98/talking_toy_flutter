import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile_app/config.dart';
import 'package:mobile_app/pages/loginPage.dart';
import 'package:mobile_app/pages/home_page.dart';
import 'package:http/http.dart' as http;

class ResetPasswordScreen extends StatefulWidget {
  final String code; // Add this line

  ResetPasswordScreen({Key? key, required this.code}) : super(key: key); // Modify the constructor to accept the code

  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // You can use widget.code here
    print("The passed code is: ${widget.code}");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reset Password  ${widget.code}'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: 'New Password',
                hintText: 'Enter new password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            TextField(
              controller: confirmPasswordController,
              decoration: InputDecoration(
                labelText: 'Confirm Password',
                hintText: 'Confirm new password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
             onPressed: () async {
  String newPassword = passwordController.text;
  String confirmPassword = confirmPasswordController.text;

  // Check if the password fields are not empty
  if (newPassword.isEmpty || confirmPassword.isEmpty) {
    // Show an error message or handle it appropriately
    print('Please enter all fields');
    return;
  }

  // Check if passwords match
  if (newPassword != confirmPassword) {
    // Show an error message or handle it appropriately
    print('Passwords do not match');
    return;
  }

  // If you have any password validation rules, apply them here

  // If everything is valid, proceed to reset the password
  try {
     var reqBody = {
  "token": widget.code,
  "newPassword": newPassword
};
                var response = await http.post(Uri.parse(forget_password_reset),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(reqBody));
                // Add your password reset logic here
                print('code checking: $newPassword');
                print(response);



      if (response.statusCode == 200) {
        // var data = jsonDecode(response.body);

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
          );

      } else {
        // Handle server error
        print('Server error: ${response.statusCode}');
      }

  } catch (e) {
    // Handle any exceptions
    print('Error: $e');
  }
},

              child: Text('Reset Password'),
            ),
          ],
        ),
      ),
    );
  }
}
