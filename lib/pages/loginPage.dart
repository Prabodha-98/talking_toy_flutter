import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/components/my_textfield.dart';
import 'package:mobile_app/components/square_tile.dart';
import 'package:mobile_app/components/my_button.dart';
import 'package:mobile_app/pages/blutooth_off_screen.dart';
import 'package:mobile_app/pages/forget_password1.dart';
import 'package:mobile_app/pages/home_page.dart';
import 'package:mobile_app/pages/my_bluetooth.dart';
import 'package:mobile_app/pages/registration.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mobile_app/config.dart';
import 'package:mobile_app/pages/teddy.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Text editing controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  // final GoogleSignIn googleSignIn = GoogleSignIn();
//   final GoogleSignIn googleSignIn = GoogleSignIn(
//   clientId: kIsWeb ? "488024289434-3sas4s7bjkiethhh0ch6tglra3mfl68v.apps.googleusercontent.com" : null, // replace with your Client ID
// );
final GoogleSignIn googleSignIn = GoogleSignIn();

  bool _isNotValidate = false;
  late SharedPreferences prefs;
  String _contactText = '';

  Future<void> _updateLoginStatus(bool isLoggedIn) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', isLoggedIn);
  }

  Future<void> signInWithGoogle() async {
    try {
      print("signIN");
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser != null) {
        print("googleUser in");
        await _updateLoginStatus(true);
        setState(() {
          // _isLoggedIn = true;
          _contactText = "Signed in as: ${googleUser.displayName}, Email: ${googleUser.email}";
          Navigator.push(context, MaterialPageRoute(builder: (context) => FlutterBlueApp()));
          print(_contactText);
        });
      } else {
        setState(() {
          _contactText = "Sign in aborted by user";
        });
      }
    } catch (error) {
      print('Sign in failed: $error');
      setState(() {
        _contactText = 'Sign in failed';
      });
    }
  }

Future<void> persistLoginState(bool isLoggedIn) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool('isLoggedIn', isLoggedIn);
}

Future<bool> isUserLoggedIn() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool('isLoggedIn') ?? false;
}
  @override
  void initState() {
    //ToyBot: implement initState
    super.initState();
    initSharedPref();
  }

  void initSharedPref() async {
    prefs = await SharedPreferences.getInstance();
  }

  // Sign user in method
  void signUserIn() async {
    // print("cat in sign in fn");
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      var reqBody = {
        "email": emailController.text,
        "password": passwordController.text
      };
//  print('cat $regBody');

      //make a call to our backend
      var response = await http.post(Uri.parse(login),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(reqBody));

      //response decoding json format

      var jsonResponse = jsonDecode(response.body);
      if (jsonResponse['status']) {
        var myToken = jsonResponse['token'];
        prefs.setString('token',myToken );//
        Navigator.push(context,
            // MaterialPageRoute(builder: (context) => homePage(token: myToken)));
            MaterialPageRoute(builder: (context) => FlutterBlueApp()));
      } else {
        print('Something went wrong');
        ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Wrong Password')),
    );
      }  
    }
  }

Future<void> signOutGoogle() async {
    await googleSignIn.signOut();
    await _updateLoginStatus(false);
    setState(() {
      // _isLoggedIn = false;
      _contactText = "User signed out.";
    });
  }
  //Function to navigate to the LoginPage
  void navigateTore(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FlutterBlueApp(),
      ),
    );
  }

  // Function to navigate to the HomePage
  void navigateToHomePage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FlutterBlueApp(),
      ),
    );
  }

// function to navigate to the RegisterPage
// Function to navigate to the RegisterPage
  void navigateToRegisterPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RegisterPage(onTap: signUserIn),
      ),
    );
  }

void navigateToForgetPasswordPage(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => ForgetPasswordScreen(),
    ),
  );
}

  @override
  Widget build(BuildContext context) {
     final ThemeData theme = Theme.of(context);
  final ColorScheme colorScheme = theme.colorScheme;

  return Scaffold(
    // backgroundColor: colorScheme.tertiaryContainer,
    appBar: AppBar(
      backgroundColor: colorScheme.primary,
        // title: SizedBox(
        //   height: 30,
        //   child: Image.asset(
        //     'lib/icons/left.png',
        //     // color: colorScheme.tertiary,
        //   ),
        // ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        child: ListView(
          children: [
            SizedBox(
              height: 70,
              // width: 300,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Sign In',
                      style: TextStyle(
                        color: colorScheme.onPrimaryContainer,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // const SizedBox(height: 5),
                    Text(
                      "Let's sign in with your TOY BOT account",
                      style: TextStyle(
                        color: colorScheme.tertiary,
                        fontSize: 16,
                        height: 2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            MyTextField(
              controller: emailController,
              hintText: "Email",
              obscureText: false,
              isNotValidate:
                  _isNotValidate, // Pass the _isNotValidate flag to control error styling
            ),
            const SizedBox(height: 20),
            MyTextField(
              controller: passwordController,
              hintText: "password",
              isNotValidate:
                  _isNotValidate, // Pass the _isNotValidate flag to control error styling
              obscureText: true,
            ),

            const SizedBox(height: 20),
            
            const SizedBox(height: 25),

            // Sign-in button

            MyButton(
              onTap: () {
                print("cat Button Clicked!");
                signUserIn();
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => homePage()));
              },
            ),

            const SizedBox(height: 25),

             const Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                children: [
                  Expanded(
                    child: Divider(
                      thickness: 0.7,
                      color: Colors.black,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      'Or sign in with',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      thickness: 0.7,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 50),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // google button
                GestureDetector(
  onTap: () async {
    try {
      // Call the Google Sign-In method
       signInWithGoogle();
      // GoogleSignInAccount? user = await _googleSignIn.signIn();

// Other user details as needed
      // User is signed in
      // Navigate to home page, or wherever you want
      // Navigator.push(context, MaterialPageRoute(builder: (context) => FlutterBlueApp()));
    } catch (e) {
      // Handle error
      print(e);
    }
  },
  child: SquareTile(imagePath: 'lib/images/google.png'),
),

                SizedBox(width: 20),

                // apple button
                SquareTile(imagePath: 'lib/images/apple.png'),
                SizedBox(height: 5),
                SizedBox(width: 20),

                // facebook button
                SquareTile(imagePath: 'lib/images/facebook.png'),
              ],
            ),

            const SizedBox(height: 30),

            // Register Now text
            GestureDetector(
              onTap: () {
                navigateToForgetPasswordPage(context); // Call the navigate function
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(''),
                  const SizedBox(width: 4),
                  Text(
                    'Forget Password',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 30),

            // Register Now text
            GestureDetector(
              onTap: () {
                navigateToRegisterPage(context); // Call the navigate function
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Not a member?'),
                  const SizedBox(width: 4),
                  Text(
                    'Register now',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
