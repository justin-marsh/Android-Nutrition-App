import 'package:flutter/material.dart';
import 'package:project_food_fit/pages/home.dart';
import 'package:project_food_fit/pages/profile.dart';

void main() {
  runApp(EditProfilePage());
}

class EditProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PreferencesScreen(),
    );
  }
}

class PreferencesScreen extends StatefulWidget {
  @override
  _PreferencesScreenState createState() => _PreferencesScreenState();
}

class _PreferencesScreenState extends State<PreferencesScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  int _currentIndex = 0;

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    if (index == 0) {
    } else if (index == 4) {
      // Navigate to Profile page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ProfilePage()),
      );
    }
  }
  void showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void _goBack() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => ProfilePage()),
    );
  }

  void _changeProfilePicture() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Upload a Profile Picture'),
          content: Text('Do you want to upload a new profile picture?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                print('Uploading profile picture...');
                Navigator.of(context).pop();
              },
              child: Text('Upload'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFFFBEDEA), Color(0xFFFFFDFD)],
              stops: [0.4, 1.0],
            ),
          ),
          child: Column(
            children: [
              SizedBox(height: 60),
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: _goBack,
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      "Edit Profile",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(
                color: Colors.grey,
                thickness: 2.0,
                indent: 40,
                endIndent: 40,
              ),
              // Use Row to align the image and text
              Row(
                children: [
                  // Profile Picture
                  Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: GestureDetector(
                      onTap: _changeProfilePicture,
                      child: CircleAvatar(
                        radius: 90,
                        backgroundImage: AssetImage('assets/profile.png'),
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  // Text
                  Text(
                    "Alex Smith",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              buildTextFieldRow("Username:", usernameController, "Alex_Smith"),
              buildTextFieldRow("Date of Birth:", dobController, "2nd April 1998"),
              buildTextFieldRow("Email:", emailController, "alex@gmail.com"),
              buildSaveButton(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: onTabTapped,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedFontSize: 0,
        unselectedFontSize: 0,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: IconButton(
              icon: Icon(Icons.home, color: Colors.grey),
              onPressed: () {
                onTabTapped(0);
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
            icon: IconButton(
              icon: Icon(Icons.person, color: Color(0xFFFF785B)),
              onPressed: () {
                onTabTapped(4);
              },
            ),
            label: '',
          ),
        ],
      ),
    );
  }

  Widget buildSectionHeader(String title) {
    return Container(
      padding: EdgeInsets.only(left: 20.0, top: 10.0),
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget buildTextFieldRow(String label, TextEditingController controller, String hintText) {
    return Container(
      margin: EdgeInsets.all(20.0),
      padding: EdgeInsets.only(left: 10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey, width: 2.0),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hintText,
                hintStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),
              ),
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSaveButton() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20.0),
      child: ElevatedButton(
        onPressed: () {
          showSnackbar("Profile settings saved!");
        },
        style: ElevatedButton.styleFrom(
          primary: Color(0xFFFF785B),
          onPrimary: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          minimumSize: Size(200, 40),
        ),
        child: const Text(
          "Save",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
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
