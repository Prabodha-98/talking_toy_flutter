// import 'package:flutter/material.dart';
// import 'package:jwt_decoder/jwt_decoder.dart';
// import 'package:mobile_app/pages/home_page.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'pages/loginPage.dart';
// // import 'package:device_preview/device_preview.dart';


// void main() async {
//   runApp(MyApp());
//   WidgetsFlutterBinding.ensureInitialized();
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   runApp(MyApp(token: prefs.getString('token'),));

// }

// class MyApp extends StatelessWidget {
//   final token;
//   const MyApp({
//     @required this.token,
//     Key? key,
  
//     }): super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       // locale: DevicePreview.locale(context),
//       // builder: DevicePreview.appBuilder,
//       title: 'Your App Name',
//       theme: ThemeData(
//         primarySwatch: Colors.purple,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       // home: (JwtDecoder.isExpired(token) ==false)?homePage(token:token):LoginPage()
//       home: LoginPage(),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:mobile_app/pages/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'pages/loginPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token'); // Get the token from SharedPreferences
  print('token');
  print(token);

  runApp(MyApp(token: token)); // Pass the token to MyApp
  // runApp(MyApp(token: prefs.getString('token'),)); // Pass the token to MyApp with a default value ('' in case of null).
    //  runApp(MyApp(token: token ?? '')); // Use the null-aware operator to provide a default value if token is null.
}

class MyApp extends StatelessWidget {
  final  String? token; // Change the type to non-nullable String
  const MyApp({
     @required 
     this.token,
     Key? key, // Provide a default value for the token parameter
  }) : super(key: key);

  // @override
  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //     title: 'Your App Name',
  //     theme: ThemeData(
  //       primarySwatch: Colors.brown,
  //       visualDensity: VisualDensity.adaptivePlatformDensity,
  //     ),
  //     home: (JwtDecoder.isExpired(token ?? '') == false)?homePage(token: token):LoginPage(),
      
  //   );
  // }//
  
  @override
Widget build(BuildContext context) {
  if (token == null || token!.isEmpty) {
    // If token is null or empty, go to the login page
    return MaterialApp(
      title: 'Your App Name',
      theme: ThemeData(
        primarySwatch: Colors.brown,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginPage(),
    );
  }

  // If token is not null or empty, continue as before
  return MaterialApp(
    title: 'Your App Name',
    theme: ThemeData(
      primarySwatch: Colors.brown,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    ),
    home: JwtDecoder.isExpired(token!) ? LoginPage() : homePage(token: token),
  );
}

}






