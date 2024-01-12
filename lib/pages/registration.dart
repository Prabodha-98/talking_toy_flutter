import 'package:flutter/material.dart';
import 'package:mobile_app/components/my_button.dart';
import 'package:mobile_app/components/my_textfield.dart';
import 'package:mobile_app/components/square_tile.dart';
import 'package:mobile_app/pages/home_page.dart';
import 'package:mobile_app/pages/loginPage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mobile_app/config.dart';
import 'package:mobile_app/pages/teddy.dart';




class RegisterPage extends StatelessWidget {
  final Function()? onTap;
  RegisterPage({Key? key, required this.onTap}) : super(key: key);




  // Text editing controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
    final TextEditingController ageController = TextEditingController();
  bool _isNotValidate = false;

  
  // Sign user in method
  void signUserIn(BuildContext context) async {
    print("cat in sign in fn");
      if(emailController.text.isNotEmpty && passwordController.text.isNotEmpty){
     
    var regBody = {
      "email":emailController.text,
      "password":passwordController.text
    };
//  print('cat $regBody');
 
    //make a call to our backend
    var response = await http.post(Uri.parse(registration),
    headers: {"Content-Type":"application/json" },
    body:jsonEncode(regBody)
    );
     
     //response decoding json format

     var jsonResponse = jsonDecode(response.body);
    print(jsonResponse['status']);

    if(jsonResponse['status']){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
      
    }else{
      print("SomeThing Went Wrong");
      // print('cat $jsonResponse');
    }}

      
      else{
        setState((){
          _isNotValidate = true;
        });
      } 
  }

  

  // Function to navigate to the LoginPage
  void navigateToLoginPage(BuildContext context) {
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

  @override
  Widget build(BuildContext context) {
    // MediaQuery for responsive design
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.purple,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Padding(
          padding: EdgeInsets.only(top: 10.0),
          child: GestureDetector(
            onTap: () {
              // Navigate to the login page when the image is tapped
              navigateToLoginPage(context);
            },
            child: SizedBox(
              height: 30,
              child: Image.asset(
                'lib/icons/left.png',
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
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
                    'Sign Up',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Let's sign in with your TOY BOT account",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      height: 2,
                    ),
                  ),
                ]
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              child: MyTextField(
                controller: emailController,
                hintText: "Email",
                obscureText: false,
              ),
              width: screenWidth * 0.5, // 80% of screen width
            ),
            const SizedBox(height: 20),
            MyTextField(
              controller: ageController,
              hintText: "Child Age",
              obscureText: false,
            ),
  const SizedBox(height: 20),

  MyTextField(
              controller: passwordController,
              hintText: "New Password",
              obscureText: true,
            ),
  const SizedBox(height: 20),

  MyTextField(
              controller: confirmPasswordController,
              hintText: "Confirm Password",
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
                                  color: const Color.fromRGBO(158, 158, 158, 1),
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

           MyButton(
  onTap: () {
    // Navigate to the login page when the button is tapped
    // navigateToHomePage(context);
    signUserIn(context);
  },
),
            const SizedBox(height: 30),

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
          
          signUserIn(context); // Call the navigate function
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Already have an account'),
            const SizedBox(width: 4),
            Text(
              'Sign Up',
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
          ]
        )
        ,
      ),
      // Add the rest of your widget tree here
    );
            
  }
  
  
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
  
  void setState(Null Function() param0) {}
}
 

 
