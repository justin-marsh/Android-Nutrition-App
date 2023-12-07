import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_food_fit/pages/home.dart';
import 'package:project_food_fit/pages/recipe_template.dart';
import 'package:project_food_fit/pages/preferences.dart';
import 'package:project_food_fit/pages/profile.dart';
import 'package:project_food_fit/pages/searchpage.dart';


class FavouritesPage extends StatefulWidget {
  @override
  _FavouritesPageState createState() => _FavouritesPageState();
}

class _FavouritesPageState extends State<FavouritesPage> {
  late User _user;
  late String _userName = "";
  List<MealPlanSquare> favouriteMealPlanSquares = [];
  final user = FirebaseAuth.instance.currentUser!;
  @override
  void initState() {
    super.initState();
    _initializeUser();
    _initializeFavouriteMealPlanSquares();
  }

  void _initializeFavouriteMealPlanSquares() async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Adjust the path to retrieve favorites
      QuerySnapshot favouritesSnapshot = await firestore
          .collection('UserFavourites')
          .doc(user.uid)
          .collection('favs')
          .get();

      // Map the documents to MealPlanSquare objects
      favouriteMealPlanSquares = favouritesSnapshot.docs
          .map((fav) => MealPlanSquare(
        fav['label'],
        fav['calories'],
        fav['imageAsset'],
      ))
          .toList();

      setState(() {});
    } catch (error) {
      print('Error initializing favourites: $error');
    }
  }


  Future<void> _initializeUser() async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      User user = auth.currentUser!;

      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('UserInfo')
          .doc(user.uid)
          .get();

      String fullName = userSnapshot['username'];
      _userName = fullName.split(' ')[0];

      setState(() {});
    } catch (error) {
      print('Error initializing user: $error');
    }
  }
  void _goBack() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFFBEDEA), Color(0xFFFFFDFD)],
            stops: [0.4, 1.0],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: _goBack,
            ),

            SizedBox(height: 40.0),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
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
                  // ... other widgets
                ],
              ),
            ),
            SizedBox(height: 20.0),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'Here are your favourite meals.',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 18,
                  color: Colors.grey,
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 10.0,
                  childAspectRatio: 0.8,
                ),
                itemCount: favouriteMealPlanSquares.length,
                itemBuilder: (context, index) {
                  return RoundedSquare(
                    favouriteMealPlanSquares[index].label,
                    favouriteMealPlanSquares[index].calories,
                    favouriteMealPlanSquares[index].imageAsset,
                    onDelete: () => _deleteFavouriteMealPlanSquare(
                      favouriteMealPlanSquares[index],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedFontSize: 0,
        unselectedFontSize: 0,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.grey),
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
              icon: Icon(Icons.favorite, color: Color(0xFFFF785B)),

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
    );
  }

  void _deleteFavouriteMealPlanSquare(MealPlanSquare square) {
    // Implement logic to remove the meal plan square from favourites in Firestore
    setState(() {
      favouriteMealPlanSquares.remove(square);
    });
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
class MealPlanSquare {
  final String label;
  final String calories;
  final String imageAsset;

  MealPlanSquare(this.label, this.calories, this.imageAsset);
}

class RoundedSquare extends StatelessWidget {
  final String label;
  final String calories;
  final String imageAsset;
  final VoidCallback onDelete;

  RoundedSquare(
      this.label, this.calories, this.imageAsset, {required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset(
            imageAsset,
            width: 80.0,
            height: 80.0,
            fit: BoxFit.cover,
          ),
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            '${calories} cal',
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }
}