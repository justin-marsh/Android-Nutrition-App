import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import the intl package for date formatting
import 'package:project_food_fit/pages/recipe_template.dart';
import 'profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'searchpage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late User _user;
  late String _userName = "";

  @override
  void initState() {
    super.initState();
    _initializeUser();
  }

  Future<void> _initializeUser() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    _user = auth.currentUser!;

    // Assuming you have a 'users' collection in Firestore
    DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
        .collection('UserInfo')
        .doc(_user.uid)
        .get();

    // Assuming the 'username' field exists in the user document
    String fullName = userSnapshot['username'];
    _userName = fullName.split(' ')[0];

    setState(() {}); // Update the UI with the retrieved username
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: [
            // Background gradient decoration
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
              top: 40,
              left: 20,
              child: Container(
                // Profile image container
                width: 60.0,
                height: 60.0,
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
            ),
            Positioned(
              top: 100.0,
              left: 10,
              right: 0,
              child: Align(
                alignment: Alignment.topLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // User greeting and activity info
                        Text(
                          'Hello, $_userName!',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Montserrat',
                            fontSize: 30,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Text(
                        // Use DateFormat to format the current date
                        DateFormat('EEEE, MMMM d').format(DateTime.now()),
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 18,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10.0, top: 20),
                      child: Text(
                        'Personal Meal Plan',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat',
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    // Empty SizedBox
                    SizedBox(height: 0),
                    Row(
                      children: [
                        // Buttons for different days
                        ButtonWidget('Day 1', width: 89.0, height: 60.0, borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                        )),
                        ButtonWidget('Day 2', width: 89.0, height: 60.0),
                        ButtonWidget('Day 3', width: 89.0, height: 60.0),
                        ButtonWidget('Day 4', width: 89.0, height: 60.0, borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10.0),
                        )),
                      ],
                    ),
                    Row(
                      children: [
                        ButtonWidget('Day 5', width: 89.0, height: 60.0, borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10.0),
                        )),
                        ButtonWidget('Day 6', width: 89.0, height: 60.0),
                        ButtonWidget('Day 7', width: 89.0, height: 60.0),
                        ButtonWidget('Day 8', width: 89.0, height: 60.0, borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(10.0),
                        )),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20.0, left: 10),
                      child: Text(
                        'Day 1',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 23,
                        ),
                      ),
                    ),
                    Container(
                      height: 3.0,
                      width: 360.0,
                      color: Colors.grey,
                    ),
                    // SizedBox to add vertical space
                    SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Meal plan squares for breakfast and lunch
                        RoundedSquare('Breakfast', '1000 Cals', 'assets/breakfast.png'),
                        RoundedSquare('Lunch', '1200 Cals', 'assets/lunch.jpg'),
                      ],
                    ),
                    // SizedBox to add vertical space
                    SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Meal plan squares for snack and dinner
                        RoundedSquare('Snack', '220 Cals', 'assets/snack.png'),
                        RoundedSquare('Dinner', '800 Cals', 'assets/dinner.jpg'),
                      ],
                    ),
                  ],
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
              icon: Icon(Icons.home, color: Color(0xFFFF785B)),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: IconButton(
                icon: Icon(Icons.search, color: Colors.grey),
                onPressed: () {
                  // Navigate to the profile page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SearchPage()),
                  );
                },
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: CustomPlusIcon(),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite, color: Colors.grey),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: IconButton(
                icon: Icon(Icons.person, color: Colors.grey),
                onPressed: () {
                  // Navigate to the profile page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfilePage()),
                  );
                },
              ),
              label: '',
            ),
          ],
        ),
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

class ButtonWidget extends StatelessWidget {
  final String text;
  final double width;
  final double height;
  final BorderRadius? borderRadius;

  ButtonWidget(this.text, {this.width = 150.0, this.height = 50.0, this.borderRadius});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: EdgeInsets.all(2.0),
      decoration: BoxDecoration(
        color: Color(0xFFFF785B),
        borderRadius: borderRadius ?? BorderRadius.circular(00.0),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class RoundedSquare extends StatefulWidget {
  final String label;
  final String calories;
  final String imageAsset;

  RoundedSquare(this.label, this.calories, this.imageAsset);

  @override
  _RoundedSquareState createState() => _RoundedSquareState();
}

class _RoundedSquareState extends State<RoundedSquare> {
  String? selectedOption;

  void _handleMenuItemSelected(String value) {
    setState(() {
      selectedOption = value;
      // Implement actions for each selected option here.
      if (value == 'Share') {
        // Handle the "Share" action.
      } else if (value == 'Delete') {
        // Handle the "Delete" action.
      } else if (value == 'Save') {
        // Handle the "Save" action.
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 150.0,
          height: 120.0,
          decoration: BoxDecoration(
            border: Border.all(
              color: Color(0xFFFF785B),
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
        Positioned(
          top: 5,
          left: 40,
          child: Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: ClipOval(
              child: Image.asset(
                widget.imageAsset,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 10,
          left: 10,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.label,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                widget.calories,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 5,
          right: 5,
          child: PopupMenuButton<String>(
            onSelected: _handleMenuItemSelected,
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              PopupMenuItem<String>(
                value: 'Share',
                child: Text('Share'),
              ),
              PopupMenuItem<String>(
                value: 'Delete',
                child: Text('Delete'),
              ),
              PopupMenuItem<String>(
                value: 'Save',
                child: Text('Save'),
              ),
            ],
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFFF785B),
              ),
              child: Center(
                child: Icon(
                  Icons.more_horiz,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
