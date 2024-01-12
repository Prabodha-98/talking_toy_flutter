import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:mobile_app/pages/home_page.dart';
import 'package:mobile_app/pages/loginPage.dart';
import 'package:shared_preferences/shared_preferences.dart';


class homePage extends StatefulWidget{
  final token;
  const homePage({@required this.token,Key? key}) : super(key: key);

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage>{

  late SharedPreferences prefs;

  late String email;
@override
void initState(){
  //ToyBot: implement initState
  
  super.initState();
  initSharedPref();
    if (widget.token == null) {
    // Handle the null case, e.g., redirect or show an error
  } else {
    // Continue with your logic
  Map<String,dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
  email = jwtDecodedToken['email'];
  }
}

  void initSharedPref() async {
    prefs = await SharedPreferences.getInstance();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings, color: Colors.white),
            onPressed: () {
              // Navigate to settings page or open settings dialog
                Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SettingPage()),
                );
            },
          ),
          IconButton(
            icon: Icon(Icons.logout, color: Colors.white),
            onPressed: () {
              // Handle logout logic
              // //add logout button and Settings but to the top right
              logout();
            },
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.purple.shade700,
              Colors.purple.shade400,
            ],
          ),  
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Spacer(),
            // Align(
            //   alignment: Alignment.topCenter,
            //   child: CircleAvatar(
            //     radius: 30, // Adjust the radius
            //     backgroundColor: Colors.blue.shade200, // Adjust the color
            //   ),
            // ),
            
          
            SizedBox(height: 20),
            Image.asset('lib/images/teddy.png',
            height :300), // Path to your teddy image
            Text(
              "I'm Tommy",
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            LinearProgressIndicator(
              value: 0.98, // Adjust the progress bar value
              backgroundColor: Colors.grey.shade400,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
            ),
            SizedBox(height: 30),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Hi, How are you?',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                // Action when button is pressed
              },
              child: Text('View History'),
              style: TextButton.styleFrom(
                primary: Colors.white,
                textStyle: TextStyle(fontSize: 18),
              ),
            ),

            
            Spacer(),
            // Bottom navigation bar placeholder
            BottomNavigationBar(
              backgroundColor: Colors.transparent,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                  backgroundColor: Colors.transparent,
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.store),
                  label: 'App Store',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.devices),
                  label: 'Devices',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.more_horiz),
                  label: 'More',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

    void logout() async{
    print('logout');
    prefs.remove('token');
               Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
          );
  }
}



// void main() {
//   runApp(MaterialApp(home: TeddyPage()));
// }


