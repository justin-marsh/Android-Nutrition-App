import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_food_fit/components/bottom_navbar.dart';
import 'package:project_food_fit/main.dart';
import 'package:project_food_fit/pages/recipe_template.dart';
import 'preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_food_fit/pages/view_stats.dart';
import 'package:project_food_fit/pages/edit_profile.dart';

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
      home: FutureBuilder(
        future: fetchUserInfo(),
        builder: (context, AsyncSnapshot<String> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else {
            return Scaffold(
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
                    top: 100.0,
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
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                              snapshot.data ?? '', // Display the fetched username
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
                    top: 330.0,
                    left: 0,
                    right: 0,
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.all(40.0),
                          child: Column(
                            children: [
                              _buildIconWithText(Color(0xFFFF785B), Icons.person, 'Edit profile', () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => EditProfilePage(),
                                ));
                              }),
                              SizedBox(height: 40.0),
                              _buildIconWithText(Color(0xFFFF785B), Icons.star, 'View Stats', () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ViewStatsPage(),
                                ));
                              }),
                              SizedBox(height: 40.0),
                              _buildIconWithText(Color(0xFFFF785B), Icons.settings, 'Preferences', () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => PreferencesPage(),
                                ));
                              }),
                              SizedBox(height: 40.0),
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
            bottomNavigationBar: buildBottomNavigationBar(context), // Call the function
            );
          }
        },
      ),
    );
  }

  Future<String> fetchUserInfo() async {
    try {
      String uid = user.uid;
      DocumentSnapshot userInfoSnapshot =
      await FirebaseFirestore.instance.collection('UserInfo').doc(uid).get();

      if (userInfoSnapshot.exists) {
        return userInfoSnapshot['username'];
      } else {
        return ''; // Default value if the username is not found
      }
    } catch (e) {
      print("Error fetching user info: $e");
      return ''; // Default value in case of an error
    }
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
    return GestureDetector(
      onTap: () {
        // Navigate to the RecipePage when the "+" button is clicked
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RecipePage()),
        );
      },
      child: Container(
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
      ),
    );
  }
}

