import 'package:flutter/material.dart';
import 'package:mobile_app/components/my_textfield.dart';
import 'package:mobile_app/components/my_button.dart';
import 'package:mobile_app/components/square_tile.dart';
import 'package:mobile_app/pages/loginPage.dart';
import 'package:mobile_app/pages/registration.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SettingPage extends StatefulWidget{
  final token;
  const SettingPage({@required this.token,Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage>{

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
        title: Text('SETTINGS'),
        centerTitle: true, 
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
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
              Expanded( // This will take all available space, making the ListView scrollable.
            child: ListView(
              children: [
                ListTile(
                  title: Text('Your Profile & Family', style: TextStyle(color: Colors.white)),
                  onTap: () {
                    // Navigate to Profile & Family settings
                  },
                ),
                ListTile(
                  title: Text('Account Settings', style: TextStyle(color: Colors.white)),
                  onTap: () {
                    // Navigate to Account settings
                  },
                ),
                ListTile(
                  title: Text('Device Settings', style: TextStyle(color: Colors.white)),
                  onTap: () {
                    // Navigate to Device settings
                  },
                ),
                ListTile(
                  title: Text('App Settings', style: TextStyle(color: Colors.white)),
                  onTap: () {
                    // Navigate to App settings
                  },
                ),
              ],
            ),
          ),
            
          
            // Path to your teddy image
           
            
            

         
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


