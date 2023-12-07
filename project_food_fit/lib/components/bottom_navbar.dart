import 'package:flutter/material.dart';
import 'package:project_food_fit/pages/favourites.dart';
import 'package:project_food_fit/pages/recipe_template.dart';
import 'package:project_food_fit/pages/searchpage.dart';
import 'package:project_food_fit/pages/home.dart';
import 'package:project_food_fit/pages/profile.dart';

Widget buildBottomNavigationBar(BuildContext context) {
  return BottomNavigationBar(
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
        label: '', // Empty label
      ),
      BottomNavigationBarItem(
        icon: CustomPlusIcon(),
        label: '', // Empty label
      ),
      BottomNavigationBarItem(
        icon: IconButton(
          icon: Icon(Icons.favorite, color: Colors.grey),
          onPressed: () {
            // Navigate to the profile page
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FavouritesPage()),
            );
          },
        ),
        label: '', // Empty label
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
        label: '', // Empty label
      ),
    ],
  );
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
