import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Function()? onTap;

  const MyButton({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return GestureDetector(
    //   onTap: onTap,
    //   child: Container(
    //     padding: const EdgeInsets.all(20),
    //     margin: const EdgeInsets.symmetric(horizontal: 25),
    //     decoration: BoxDecoration(
    //       color: Colors.transparent, // Make the background transparent
    //       borderRadius: BorderRadius.circular(15),
    //       border: Border.all(
    //         color: Colors.white, // Add a white border
    //         width: 1.0, // Set the border width as desired
    //       ),
    //     ),
        

    //     child: const Center(
    //       child: Text(
    //         "Sign In",
    //         style: TextStyle(
    //           color: Color.fromARGB(255, 111, 8, 8),
    //           fontWeight: FontWeight.bold,
    //           fontSize: 18,
    //         ),
    //       ),
    //     ),
    //   ),
    // );
    return GestureDetector(
  onTap: onTap,
  child: Container(
    padding: const EdgeInsets.all(20),
    margin: const EdgeInsets.symmetric(horizontal: 25),
    decoration: BoxDecoration(
      color: Colors.transparent, // Keep the background transparent
      borderRadius: BorderRadius.circular(15),
      border: Border.all(
        color: Theme.of(context).colorScheme.onSurface, // Use the onSurface color for the border
        width: 1.0,
      ),
    ),
    child: Center(
      child: Text(
        "Sign In",
        style: TextStyle(
          color: Theme.of(context).colorScheme.primary, // Use the primary color for the text
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    ),
  ),
);

  }
}

