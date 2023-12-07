import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_food_fit/pages/profile.dart';
import 'package:project_food_fit/pages/searchpage.dart';
import 'home.dart';
import 'package:project_food_fit/components/datamanage.dart';

int dataID = 0;




void main() async {
  runApp(RecipeDatabasePage(recipeID: 10));
}

class RecipeDatabasePage extends StatelessWidget {
  RecipeDatabasePage({super.key, required this.recipeID});
  final int recipeID; // holds id

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PreferencesScreen(recipeID: recipeID),
    );
  }
}

class PreferencesScreen extends StatefulWidget {
  final int recipeID;

  PreferencesScreen({required this.recipeID});

  @override
  _PreferencesScreenState createState() => _PreferencesScreenState();
}

class _PreferencesScreenState extends State<PreferencesScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _goBack() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: FutureBuilder(
        future: fetchResource1("*", "id", "=", widget.recipeID),
        builder: (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Text('No data found');
          } else {
            Map<String, dynamic> firstResult = snapshot.data!.first;

            String name = firstResult['name'];
            String description = firstResult['description'];
            int calories = firstResult['calories'];

            return Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Background Image or Grey Box
                    Container(
                      height: 400,
                      color: Colors.grey,
                      width: double.infinity,
                    ),
                    // Editable Text Field for Name
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 15, right: 10, top: 20),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          width: 200,
                          child: Text(
                            name,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Row for Description and Calories
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 15, right: 10, top: 5),
                      child: Row(
                        children: [
                          // Text for Description
                          Expanded(
                            child: Container(
                              child: Text(
                                description,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          // Text for Calories
                          Container(
                            width: 100,
                            child: Text(
                              calories.toString(),
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ],
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
                        //favourite the recipe

                      },
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFFFF785B),
                      ),
                      child: Text(
                        'favourite',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
        },
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
              icon: Icon(Icons.search, color: Color(0xFFFF785B)),
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

