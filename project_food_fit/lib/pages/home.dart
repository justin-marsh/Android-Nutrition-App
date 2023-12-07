import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_food_fit/pages/favourites.dart';
import 'profile.dart';
import 'searchpage.dart';
import 'package:project_food_fit/pages/recipe_template.dart';

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
  List<MealPlanSquare> mealPlanSquares = []; // List to store meal plan squares
  ImageProvider<Object> _profilePicture = AssetImage('assets/profile.png');


  @override
  void initState() {
    super.initState();
    _initializeUser();
    _initializeMealPlanSquares();
  }
  void _initializeMealPlanSquares() {
    // Add initial meal plan squares to the list
    mealPlanSquares = [
      MealPlanSquare('Breakfast', '1000 Cals', 'assets/breakfast.png'),
      MealPlanSquare('Lunch', '1200 Cals', 'assets/lunch.jpg'),
      MealPlanSquare('Snack', '220 Cals', 'assets/snack.png'),
      MealPlanSquare('Dinner', '800 Cals', 'assets/dinner.jpg'),
    ];
  }

  Future<void> _initializeUser() async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      User user = auth.currentUser!;

      // Assuming you have a 'users' collection in Firestore
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('UserInfo')
          .doc(user.uid)
          .get();

      String fullName = userSnapshot['username'];
      _userName = fullName.split(' ')[0];

      // Check if the user has a profile picture URL
      String profilePicture = userSnapshot['profilePicture'] ?? "";

      if (profilePicture.isNotEmpty) {
        // Use the profile picture URL from Firestore
        _profilePicture = NetworkImage(profilePicture);
      } else {
        // Fallback to the default profile picture
        _profilePicture = AssetImage('assets/profile.png');
      }

      setState(() {});
    } catch (error) {
      print('Error initializing user: $error');
    }
  }
  void _deleteMealPlanSquare(MealPlanSquare square) {
    // Delete the specified meal plan square
    setState(() {
      mealPlanSquares.remove(square);
    });
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
              top: 40,
              left: 20,
              child: Container(
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
                    SizedBox(height: 0),
                    Row(
                      children: [
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
                    SizedBox(height: 20.0),
                    // Display meal plan squares dynamically in two columns
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Display the first two meal plan squares in the first column
                        for (var i = 0; i < mealPlanSquares.length && i < 2; i++)
                          RoundedSquare(
                            mealPlanSquares[i].label,
                            mealPlanSquares[i].calories,
                            mealPlanSquares[i].imageAsset,
                            onDelete: () => _deleteMealPlanSquare(mealPlanSquares[i]),
                          ),
                      ],
                    ),
                    SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Display the last two meal plan squares in the second column
                        for (var i = 2; i < mealPlanSquares.length; i++)
                          RoundedSquare(
                            mealPlanSquares[i].label,
                            mealPlanSquares[i].calories,
                            mealPlanSquares[i].imageAsset,
                            onDelete: () => _deleteMealPlanSquare(mealPlanSquares[i]),
                          ),
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
              icon: IconButton(
              icon: Icon(Icons.favorite, color: Colors.grey),

              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FavouritesPage()),
                );
              },
            ),
            label:'',
            ),
            BottomNavigationBarItem(
              icon: IconButton(
                icon: Icon(Icons.person, color: Colors.grey),
                onPressed: () {
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
class MealPlanSquare {
  final String label;
  final String calories;
  final String imageAsset;

  MealPlanSquare(this.label, this.calories, this.imageAsset);
}
class RoundedSquare extends StatefulWidget {
  final String label;
  final String calories;
  final String imageAsset;
  final VoidCallback onDelete;

  RoundedSquare(this.label, this.calories, this.imageAsset, {required this.onDelete});

  @override
  _RoundedSquareState createState() => _RoundedSquareState();
}

class _RoundedSquareState extends State<RoundedSquare> {
  String? selectedOption;

  void _handleMenuItemSelected(String value) {
    setState(() {
      selectedOption = value;
      if (value == 'Delete') {
        // Handle the "Delete" action.
        widget.onDelete(); // Trigger the onDelete callback
      } else if (value == 'Favourite') {
        _storeRecipeInFirestore();
      }
    });
  }

  Future<void> _storeRecipeInFirestore() async {
    try {
      // Access the current user
      FirebaseAuth auth = FirebaseAuth.instance;
      User user = auth.currentUser!;

      // Access the Firestore instance
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Access the 'UserFavourites' collection and use the user's UID as the document ID
      DocumentReference userFavouritesDoc = firestore.collection('UserFavourites').doc(user.uid);

      // Add the recipe data to the user's document
      await FirebaseFirestore.instance.collection('UserFavourites')
          .doc(user.uid)
          .collection('favs')
          .add({
        'label': widget.label,
        'calories': widget.calories,
        'imageAsset': widget.imageAsset,
      });

      // For demonstration purposes, let's print a message.
      print('Recipe added to user\'s favourites');
    } catch (error) {
      // Handle any errors that occur during the process.
      print('Error storing recipe: $error');
    }
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
                value: 'Delete',
                child: Text('Delete'),
              ),
              PopupMenuItem<String>(
                value: 'Favourite',
                child: Text('Favourite'),
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