import 'package:flutter/material.dart';
import 'package:mobile_app/components/my_textfield.dart';
import 'package:mobile_app/components/square_tile.dart';
import 'package:mobile_app/components/my_button.dart';
import 'package:mobile_app/pages/home_page.dart';
import 'package:mobile_app/pages/registration.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mobile_app/config.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Text editing controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _isNotValidate = false;
  late SharedPreferences prefs;

  @override
  void initState(){
    //ToyBot: implement initState
    super.initState();
    initSharedPref();
  }

  void initSharedPref()async{
    prefs = await SharedPreferences.getInstance();
  }
  



  // Sign user in method
  void signUserIn() async {
    // print("cat in sign in fn");
      if(emailController.text.isNotEmpty && passwordController.text.isNotEmpty){
     
    var reqBody = {
      "email":emailController.text,
      "password":passwordController.text
    };
//  print('cat $regBody');
 
    //make a call to our backend
    var response = await http.post(Uri.parse(login),
    headers: {"Content-Type":"application/json" },
    body:jsonEncode(reqBody)
    );
     
     //response decoding json format

     var jsonResponse = jsonDecode(response.body);
    if(jsonResponse['status']){
        var myToken = jsonResponse['token'];
        prefs.setString('token', myToken);
        Navigator.push(context,MaterialPageRoute(builder: (context)=>homePage(token: myToken)));


    }else{ 
      print('Something went wrong');
    }
      }
  }

  //Function to navigate to the LoginPage
  void navigateTore(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
    );
  }

    


  // Function to navigate to the HomePage
  void navigateToHomePage(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => homePage(),
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: SizedBox(
          height: 30,
          child: Image.asset(
            'lib/icons/left.png',
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        child: ListView(
          children: [
            SizedBox(
              height: 70,
              // width: 300,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Sign In',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // const SizedBox(height: 5),
                  Text(
                    "Let's sign in with your TOY BOT account",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      height: 2,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            MyTextField(
              controller: emailController,
              hintText: "Email",
              obscureText: false,
              isNotValidate: _isNotValidate, // Pass the _isNotValidate flag to control error styling

            ),
            const SizedBox(height: 20),
            MyTextField(
              controller: passwordController,
              hintText: "password",
              isNotValidate: _isNotValidate, // Pass the _isNotValidate flag to control error styling
              obscureText: true,
              
            ),


            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: SizedBox(
                height: 20.0,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset('lib/icons/check.png'),
                      const SizedBox(height: 50.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "By continuing you accept our ",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                              ),
                              TextSpan(
                                text: "Privacy Policy",
                                style: TextStyle(
                                  color: Colors
                                      .blue, // You can change the color to your desired link color
                                  fontSize: 14,
                                  decoration: TextDecoration.underline,
                                ),
                                // Add a GestureRecognizer here for handling taps on the "Privacy Policy" link.
                              ),
                            ],
                          ),
                        ),
                      )
                    ]
                    ),
              ),
            ),
              const SizedBox(height: 20),


            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: SizedBox(
                height: 20.0,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset('lib/icons/empty.png'),
                      const SizedBox(height: 50.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "By continuing you accept our ",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                              ),
                              TextSpan(
                                text: "Terms & Conditions",
                                style: TextStyle(
                                  color: Colors
                                      .blue, // You can change the color to your desired link color
                                  fontSize: 14,
                                  decoration: TextDecoration.underline,
                                ),
                                // Add a GestureRecognizer here for handling taps on the "Privacy Policy" link.
                              ),
                            ],
                          ),
                        ),
                      )
                      
                    ]
                    
                    ),
              ),
             
            ),

            const SizedBox(height: 25),

            // Sign-in button

    
     
       
      
         


MyButton(
  onTap: () {
    print("cat Button Clicked!");
    signUserIn();
    Navigator.push(context, MaterialPageRoute(builder: (context)=>homePage()));
  },
  
  
),


            const SizedBox(height: 25),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Forgot Password?',
                    style: TextStyle(color: Colors.green),
                    
                    
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),

            // or continue with
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                children: [
                  Expanded(
                    child: Divider(
                      thickness: 0.7,
                      color: Colors.black,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
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
                  SquareTile(imagePath: 'lib/images/google.png'),
            
                  SizedBox(width: 20),
                
                  // apple button
                  SquareTile(imagePath: 'lib/images/apple.png'),
                  SizedBox(height: 5),
                  SizedBox(width: 20),
            
                  // facebook button
                  SquareTile(imagePath: 'lib/images/facebook.png'),
                  ],
                  ) ,

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
