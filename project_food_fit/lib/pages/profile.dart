import 'package:flutter/material.dart';
import 'preferences.dart';

void main() {
  runApp(ProfilePage());
}

class ProfilePage extends StatelessWidget {
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
                        _buildIconWithText(Color(0xFFFF785B), Icons.exit_to_app, 'Logout'),
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
          backgroundColor: Colors.white, // Set the background color to white
          selectedFontSize: 0, // Adjust font size for labels
          unselectedFontSize: 0, // Adjust font size for labels
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home, color: Colors.grey),
              label: '', // Empty label
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search, color: Colors.grey),
              label: '', // Empty label
            ),
            BottomNavigationBarItem(
              icon: CustomPlusIcon(), // Use the custom plus icon
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
      onTap: onTap, // Call the callback when the row is tapped, if provided
      child: Row(
        children: [
          Icon(
            icon,
            color: iconColor,
          ),
          SizedBox(width: 20), // Adjust the spacing between icon and text
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
      width: 48, // Adjust the size of the icon
      height: 48, // Adjust the size of the icon
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
