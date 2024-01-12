import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile_app/pages/password_reset.dart';
import 'package:mobile_app/config.dart';
import 'package:http/http.dart' as http;

class VerificationCodeScreen extends StatefulWidget {
  @override
  _VerificationCodeScreenState createState() => _VerificationCodeScreenState();
}

class _VerificationCodeScreenState extends State<VerificationCodeScreen> {
  final TextEditingController codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter Verification Code'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: codeController,
              decoration: InputDecoration(
                labelText: 'Verification Code',
                hintText: 'Enter the 6-digit code',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              maxLength: 6,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => verifyCodeAndNavigate1(context),
              child: Text('Verify Code'),
            ),
          ],
        ),
      ),
    );
  }

  void verifyCodeAndNavigate(BuildContext context) {
    // Add your verification logic here
    // If verification is successful, navigate to reset password screen
    String code = codeController.text;
    if (code.length == 6) {
      // Assuming verification is successful
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ResetPasswordScreen(code: code,)),
      );
    } else {
      // Handle error, show a message to the user
      print('Invalid code');
    }
  }
void verifyCodeAndNavigate1(BuildContext context) async {
  String code = codeController.text;
    if (codeController.text.isNotEmpty) {
      var reqBody = {
        "code": codeController.text,
      };
// controversial
  if (code.length == 6) {
    try {
                      var response = await http.post(Uri.parse(check_code),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(reqBody));
                // Add your password reset logic here
                print('code checking: $code');
                print(response);



      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        if (data['isExist'] == true) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ResetPasswordScreen(code: code,)),
          );
        } else {
          // Handle the case where the code does not exist
          print('Invalid code');
        }
      } else {
        // Handle server error
        print('Server error: ${response.statusCode}');
      }
    } catch (e) {
      // Handle network error
      print('Network error: $e');
    }
  } else {
    // Handle error, show a message to the user
    print('Invalid code');
  }
}
}
}




