import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_food_fit/main.dart';
import 'preferences.dart';
import 'home.dart';


void main() {
  runApp(ProfilePage());
}

class ProfilePage extends StatelessWidget {

  final user = FirebaseAuth.instance.currentUser!;

  // sign user out method
  void signUserOut(BuildContext context) {
    FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => MyHomePage(title: 'FoodFit Plus'),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFFFBEDEA), Color(0xFFFFFDFD)],
                  stops: [0.4, 1.0],
                ),
              ),
            ),
            Positioned(
              top: 100.0, // Adjust the top value to move the image down
              left: 0,
              right: 0,
              child: Align(
                alignment: Alignment.topCenter,
                child: Column(
                  children: [
                    Container(
                      width: 166.0,
                      height: 168.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                          width: 3.0,
                        ),
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          'assets/profile.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0), // Add 10pt padding around the text
                      child: Text(
                        'Alex Smith',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 25,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 330.0, // Adjust the top value to move the icons and text down
              left: 0,
              right: 0,
              child: Align(
                alignment: Alignment.topCenter,
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(40.0), // Add 20pt padding around the content
                    child: Column(
                      children: [
                        _buildIconWithText(Color(0xFFFF785B), Icons.person, 'Edit profile'),
                        SizedBox(height: 40.0), // Add spacing between rows
                        _buildIconWithText(Color(0xFFFF785B), Icons.star, 'View Stats'),
                        SizedBox(height: 40.0), // Add spacing between rows
                        _buildIconWithText(Color(0xFFFF785B), Icons.settings, 'Preferences', () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => PreferencesPage(), // Replace with the actual name of your Preferences page
                          ));
                        }),
                        SizedBox(height: 40.0), // Add spacing between rows
                        _buildIconWithText(Color(0xFFFF785B), Icons.library_books, 'Terms and privacy policy'),
                        SizedBox(height: 40.0), // Add spacing between rows
                        _buildIconWithText(Color(0xFFFF785B), Icons.exit_to_app, 'Logout', () {
                          signUserOut(context);
                        }),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white, 
          selectedFontSize: 0, 
          unselectedFontSize: 0, 
          items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: IconButton(
              icon: Icon(Icons.home, color: Colors.grey),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
            ),
              label: '', // Empty label
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search, color: Colors.grey),
              label: '', // Empty label
            ),
            BottomNavigationBarItem(
              icon: CustomPlusIcon(), 
              label: '', // Empty label
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite, color: Colors.grey),
              label: '', // Empty label
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person, color: Color(0xFFFF785B)),
              label: '', // Empty label
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconWithText(Color iconColor, IconData icon, String text, [VoidCallback? onTap]) {
    return GestureDetector(
      onTap: onTap, 
      child: Row(
        children: [
          Icon(
            icon,
            color: iconColor,
          ),
          SizedBox(width: 20), 
          Expanded(
            child: Text(
              text,
              style: TextStyle(color: Colors.grey),
            ),
          ),
          Icon(
            Icons.chevron_right,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}

class CustomPlusIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48, 
      height: 48, 
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xFFFF785B),
      ),
      child: Center(
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}