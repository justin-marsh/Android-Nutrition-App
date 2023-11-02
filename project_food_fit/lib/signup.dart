import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SignUpPage(),
    );
  }
}

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Color backgroundColor = Color(0xFFFBEDEA);
    Color boxColor = Color(0xFFFEF9F9); // Define the box color

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: <Widget>[
          // Background Box
          Positioned(
            top: 200, // Adjust the top value to move the box downward
            left: 0,
            right: 0,
            child: Container(
              height: 800, // Set the height of the box
              decoration: BoxDecoration(
                color: boxColor, // Set the box color
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
              ),
            ),
          ),

          // Content
          Container(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(0.0),
                  child: Column(
                    children: <Widget>[
                      Image.asset('assets/logo.png', height: 250),
                      const Text(
                        'Sign Up',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Color(0xFFF96343), // Set the text color
                          fontSize: 24, // Set the font size
                          fontFamily: 'Montserrat', // Set the font family
                        ),
                      ),
                      SizedBox(height: 30), // Add space after the "Sign Up" text
                    ],
                  ),
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.all(10.0), // Add desired padding here
                    child: RoundedInputField(
                      hintText: "Username",
                      icon: Icons.person,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Center(
                  child: Padding(
                    padding: EdgeInsets.all(10.0), // Add desired padding here
                    child: RoundedInputField(
                      hintText: "Email",
                      icon: Icons.email,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Center(
                  child: Padding(
                    padding: EdgeInsets.all(10.0), // Add desired padding here
                    child: RoundedInputField(
                      hintText: "Password",
                      icon: Icons.lock,
                      obscureText: true,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Center(
                  child: Padding(
                    padding: EdgeInsets.all(10.0), // Add desired padding here
                    child: RoundedInputField(
                      hintText: "Confirm Password",
                      icon: Icons.lock,
                      obscureText: true,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                RoundedButton(
                  text: "Sign Up",
                  press: () {
                    // Add your sign-up logic here
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}



class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final bool obscureText;

  RoundedInputField({required this.hintText, required this.icon, this.obscureText = false});

  @override
  Widget build(BuildContext context) {
    final OutlineInputBorder focusedBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: BorderSide(
        color: Color(0xFFF96343), // Set the border color when focused
      ),
    );

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.white,
      ),
      child: SizedBox(
        width: 300,
        child: TextField(
          obscureText: obscureText,
          decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: Icon(icon),
            border: InputBorder.none,
            focusedBorder: focusedBorder, // Apply the focused border
          ),
        ),
      ),
    );
  }
}


class RoundedButton extends StatelessWidget {
  final String text;
  final Function() press;

  RoundedButton({required this.text, required this.press});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 40,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: Color(0xFFF96343),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
        onPressed: press,
        child: Text(
          text,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
