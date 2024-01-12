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
import 'package:mobile_app/pages/teddy.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'pages/loginPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token'); // Get the token from SharedPreferences
  bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false; // Get the token from SharedPreferences
  print('token'); 
  print(token);

  runApp(MyApp(token: token,isLoggedIn: isLoggedIn,)); // Pass the token to MyApp
  // runApp(MyApp(token: prefs.getString('token'),)); // Pass the token to MyApp with a default value ('' in case of null).
    //  runApp(MyApp(token: token ?? '')); // Use the null-aware operator to provide a default value if token is null.
}

class MyApp extends StatelessWidget {
  final  String? token; // Change the type to non-nullable String
  final bool? isLoggedIn;
  const MyApp({
     @required 
     this.token,this.isLoggedIn,
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
  
//   @override
// Widget build(BuildContext context) {
//     final ColorScheme colorScheme = ColorScheme.fromSeed(
//       brightness: MediaQuery.platformBrightnessOf(context),
//       seedColor: Colors.indigo,
//     );
//   if (token == null || token!.isEmpty) {
//     // If token is null or empty, go to the login page
//     return MaterialApp(
//       title: 'Your App Name',
//       // theme: ThemeData(
//       //   primarySwatch: Colors.purple,
//       //   visualDensity: VisualDensity.adaptivePlatformDensity,
//       // ),
//       theme: ThemeData(
//         colorScheme: colorScheme,
//         floatingActionButtonTheme: FloatingActionButtonThemeData(
//           backgroundColor: colorScheme.tertiary,
//           foregroundColor: colorScheme.onTertiary,
//         ),
//       ),
//       home: LoginPage(),
//     );
//   }

//   // If token is not null or empty, continue as before
//   return MaterialApp(
//     title: 'Your App Name',
//     theme: ThemeData(
//         colorScheme: colorScheme,
//         floatingActionButtonTheme: FloatingActionButtonThemeData(
//           backgroundColor: colorScheme.tertiary,
//           foregroundColor: colorScheme.onTertiary,
//         ),
//       ),
    
//     home: JwtDecoder.isExpired(token!) ? LoginPage() : homePage(token: token),
//   );
// }

@override
Widget build(BuildContext context) {
  
  // Determine the brightness of the platform.
  final Brightness brightness = MediaQuery.platformBrightnessOf(context);
  
  // Define the primary color based on the screenshots provided.
  final Color primaryColor = Color(0xFFFF6D00); // Vibrant orange color
  
  // Create a ColorScheme based on the primary color.
  final ColorScheme colorScheme = ColorScheme.fromSeed(
    seedColor: primaryColor,
    brightness: brightness,
  );
  
  // Use the colorScheme to define the ThemeData.
  final ThemeData themeData = ThemeData(
    colorScheme: colorScheme,
    primaryColor: primaryColor,
    scaffoldBackgroundColor: colorScheme.background,
    cardColor: colorScheme.surface,
    buttonTheme: ButtonThemeData(
      buttonColor: colorScheme.primary,
      textTheme: ButtonTextTheme.primary,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: colorScheme.primary,
      iconTheme: IconThemeData(color: colorScheme.onPrimary),
      titleTextStyle: TextStyle(
        color: colorScheme.onPrimary,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
    ),
    textTheme: TextTheme(
      bodyText1: TextStyle(color: colorScheme.onSurface),
      bodyText2: TextStyle(color: colorScheme.onSurface),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: colorScheme.secondary,
      foregroundColor: colorScheme.onSecondary,
    ),
    // ... other theme data definitions
  );
  
  // Use the themeData for the MaterialApp.
  if ((token == null || token!.isEmpty)||!isLoggedIn!) {
  return MaterialApp(
    title: 'Borcelle Food Ordering App',
    theme: themeData,
    //  home:  LoginPage(),
     home:  LoginPage(),
    // Replace 'YourActualHomePageWidget' with the actual widget class for your home page.
  );
} else {
   return MaterialApp(
    title: 'Your App Name',
    theme: ThemeData(
        colorScheme: colorScheme,
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: colorScheme.tertiary,
          foregroundColor: colorScheme.onTertiary,
        ),
      ),
    
    home: JwtDecoder.isExpired(token!) ? LoginPage() : homePage(token: token),
  );
}
}



}









