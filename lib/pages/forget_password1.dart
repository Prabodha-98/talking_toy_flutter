import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile_app/config.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_app/pages/password_reset.dart';
import 'package:mobile_app/pages/token_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
      final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ForgetPasswordScreen(),
    );
  }
}

class ForgetPasswordScreen extends StatefulWidget {
  @override
  _ForgetPasswordScreenState createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forget Password'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                hintText: 'Enter your email',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (emailController.text.isNotEmpty) {
      var reqBody = {
        "email": emailController.text,
      };
                // Implement the logic to handle password reset
                String email = emailController.text;
                
                var response = await http.post(Uri.parse(forget_password_request_reset),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(reqBody));
                // Add your password reset logic here
                print('Reset password for: $email');
                print(response);
    //              if (response.statusCode == 200) {
    //                 var jsonResponse = jsonDecode(response.body);
    //   if (jsonResponse['status']) {
    //     var myToken = jsonResponse['message'];
    //                ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(content: Text(myToken)),
    // );
     Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => VerificationCodeScreen(),
    ),
  );
    }
      // Handle successful response
      print('Password reset request successful');
    // } else {
    //   // Handle error response
    //   print('Error: ${response.statusCode}');
    // }
              },
              child: Text('Reset Password'),
            ),
          ],
        ),
      ),
    );
  }
}
