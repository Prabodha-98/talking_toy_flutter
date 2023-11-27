import 'package:flutter/material.dart';
import 'package:mobile_app/components/my_textfield.dart';
import 'package:mobile_app/components/my_button.dart';
import 'package:mobile_app/components/square_tile.dart';
import 'package:mobile_app/pages/registration.dart';
import 'package:jwt_decoder/jwt_decoder.dart';


class homePage extends StatefulWidget{
  final token;
  const homePage({@required this.token,Key? key}) : super(key: key);

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage>{

  late String email;
@override
void initState(){
  //ToyBot: implement initState
  
  super.initState();
    if (widget.token == null) {
    // Handle the null case, e.g., redirect or show an error
  } else {
    // Continue with your logic
  Map<String,dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
  email = jwtDecodedToken['email'];
  }
}





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple,
       body: Align(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0), // Add left padding to the image
              child: Image.asset(
            'lib/images/teddy.png',
            // color: Colors.white,
            height: 300, // Set the desired height
            width: 300, // Set the desired width
          ),
            ),
          SizedBox(height: 10), // Add some space between the image and text

            
          Text(
            'Device Information',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 40), // Add space between texts
          Text(
            'Battery level',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 40), // Add space between texts
          Text(
            'Text commands',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 40), // Add space between texts
          Text(
            'Voice commands',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 40), // Add some space between the text elements
          Text(
            'Activity summary',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 40), // Add space between texts
          Text(
            'Last activity summary',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 40), // Add space between texts
          TextButton(
            onPressed: () {
              // Add action when the button is pressed
            },
            child: Text(
              'View Full Summary',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),

          // Add some space between the text elements
          // Add other widgets here that you want to include in the body
          // Example:
          // MyTextField(),
          // MyButton(),
          // SquareTile(),
        ],
      ),
    ),
    );
  }
}