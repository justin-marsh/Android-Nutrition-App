import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project_food_fit/pages/profile.dart';
import '../main.dart';

class SignUpPage extends StatefulWidget{
  SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordVerifyController = TextEditingController();

  void signUp() async {
    // show loading circle
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    // try sign up
    try { //if confirm and password are the same
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
      );
      // pop the loading circle
      Navigator.pop(context);

      // Navigate to the profile page
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ProfilePage()),
      );
      if(usernameController.text == null){
        usernameNullMessage();
      }
      if (passwordController.text != passwordVerifyController.text) {
        passwordsDontMatchMessage();
      }
    } on FirebaseAuthException catch (e) {
      // pop the loading circle
      Navigator.pop(context);
      // WRONG EMAIL
      if (e.code == 'email-already-in-use') {
        // show error to user
        wrongEmailMessage();
      }


    }
  }

  // wrong email message popup
  void wrongEmailMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          backgroundColor: Color(0xFFF96343),
          title: Center(
            child: Text(
              'Email Already Exists',
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }
  void passwordsDontMatchMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          backgroundColor: Color(0xFFF96343),
          title: Center(
            child: Text(
              'Passwords Don\'t Match',
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }
  // wrong password message popup
  void wrongPasswordMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          backgroundColor: Color(0xFFF96343),
          title: Center(
            child: Text(
              'Incorrect Password',
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }

  void usernameNullMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          backgroundColor: Color(0xFFF96343),
          title: Center(
            child: Text(
              'Please provide a username',
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }

  void EmptyFieldMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          backgroundColor: Color(0xFFF96343),
          title: Center(
            child: Text(
              'Email is empty or invalid',
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = Color(0xFFFBEDEA);
    Color boxColor = Color(0xFFFEF9F9);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 200,
            left: 0,
            right: 0,
            child: Container(
              height: 800,
              decoration: BoxDecoration(
                color: boxColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
              ),
            ),
          ),

          // New button in the top left corner
          Positioned(
            top: 250, // Adjusted top margin to align with the logo
            left: 20,
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
              ),
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyHomePage(title: 'FoodFit Plus',)),
                  );
                },
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
              ),
            ),
          ),

          Container(
            padding: EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(0.0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Image.asset('assets/logo.png', height: 250),
                          const Text(
                            'Sign Up',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Color(0xFFF96343),
                              fontSize: 24,
                              fontFamily: 'Montserrat',
                            ),
                          ),
                          SizedBox(height: 30),
                        ],
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: RoundedInputField(
                        hintText: "Username",
                        icon: Icons.person,
                        controller: usernameController,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: RoundedInputField(
                        hintText: "Email",
                        icon: Icons.email,
                        controller: emailController,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: RoundedInputField(
                        hintText: "Password",
                        icon: Icons.lock,
                        obscureText: true,
                        controller: passwordController,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: RoundedInputField(
                        hintText: "Confirm Password",
                        icon: Icons.lock,
                        obscureText: true,
                        controller: passwordVerifyController,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  RoundedButton(
                    text: "Sign Up",
                    press: () {
                      if (emailController.text.isNotEmpty &&
                          passwordController.text.length > 6) {
                        signUp();
                      } else {
                        debugPrint('LOG : Email is empty or invalid');
                      }
                    },
                  ),
                ],
              ),
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
  final TextEditingController controller;

  RoundedInputField({
    required this.hintText,
    required this.icon,
    this.obscureText = false,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final OutlineInputBorder focusedBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: BorderSide(
        color: Color(0xFFF96343),
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
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: Icon(icon),
            border: InputBorder.none,
            focusedBorder: focusedBorder,
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
