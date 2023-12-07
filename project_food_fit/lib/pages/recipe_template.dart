import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_food_fit/pages/profile.dart';
import 'package:project_food_fit/pages/searchpage.dart';
import 'home.dart';
import 'package:project_food_fit/components/datamanage.dart';

void main() async{
  final db = await createTables();
  runApp(RecipePage());
}

class RecipePage extends StatelessWidget {
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
  int _currentIndex = 0;
  String? imagePath; // Use "?" to indicate that it can be null
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController =
  TextEditingController(); // New controller for description
  TextEditingController caloriesController =
  TextEditingController(); // Controller for calories
  TextEditingController ingredientsController =
  TextEditingController(); // Controller for ingredients

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    if (index == 0) {
      // Navigate to HomePage
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else if (index == 1) {
      // Navigate to SearchPage
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SearchPage()),
      );
    } else if (index == 4) {
      // Navigate to Profile page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ProfilePage()),
      );
    }
  }

  void _goBack() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        imagePath = pickedFile.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Background Image or Grey Box
              Container(
                height: 400,
                color: Colors.grey,
                child: imagePath != null
                    ? Image.file(
                  File(imagePath!),
                  height: 400,
                  width: double.infinity,
                  fit: BoxFit.cover,
                )
                    : Center(
                  child: GestureDetector(
                    onTap: _pickImage,
                    child: Icon(
                      Icons.add,
                      size: 48,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              // Editable Text Field for Name
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 10, top: 20),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    width: 200,
                    child: TextField(
                      controller: nameController,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.start,
                      decoration: InputDecoration(
                        hintText: 'Add Name Here',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),
              // Row for Description and Calories
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 10, top: 5),
                child: Row(
                  children: [
                    // Editable Text Field for Description
                    Expanded(
                      child: Container(
                        child: TextField(
                          controller: descriptionController,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                          textAlign: TextAlign.start,
                          decoration: InputDecoration(
                            hintText: 'Description',
                            hintStyle: TextStyle(
                              color: Colors.grey,
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    // Editable Text Field for Calories
                    Container(
                      width: 100,
                      child: TextField(
                        controller: caloriesController,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.start,
                        decoration: InputDecoration(
                          hintText: 'Calories',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Text for Ingredients
              Padding(
                padding: const EdgeInsets.only(left: 15, top: 5),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Ingredients',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              // Editable Text Field for Ingredients
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 10, top: 5),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    width: 200,
                    child: TextField(
                      controller: ingredientsController,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.start,
                      decoration: InputDecoration(
                        hintText: 'Add Ingredients Here',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: 20,
            left: 10,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: _goBack,
              color: Colors.white,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.only(bottom: 20),
              child: ElevatedButton(
                onPressed: () {
                  Random random = Random();

                  checkDatabase().then((pathExists) {
                    if (pathExists) {
                      // If database exists, call addRecipe

                        addRecipes(Recipe(
                          name: nameController.text,
                          description: descriptionController.text,
                          calories: int.parse(caloriesController.text),
                          difficulty: 0,
                          ingredients: ingredientsController.text.split(', '),
                          diet: [],
                        ));

                    } else {
                      // If database doesn't exist, create it and then call addRecipe
                      createTables().then((_) {
                        addRecipes(Recipe(
                          name: nameController.text,
                          description: descriptionController.text,
                          calories: int.parse(caloriesController.text),
                          difficulty: 0,
                          ingredients: ingredientsController.text.split(', '),
                          diet: [],
                        ));
                      });
                    }
                  });
                },
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFFFF785B),
                ),
                child: Text(
                  'Save',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
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
            icon: IconButton(
              icon: Icon(Icons.search, color: Colors.grey),
              onPressed: () {
                onTabTapped(1);
              },
            ),
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

