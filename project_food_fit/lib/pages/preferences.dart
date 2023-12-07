import 'package:project_food_fit/components/bottom_navbar.dart';
import 'package:project_food_fit/pages/profile.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_food_fit/pages/recipe_template.dart';
void main() {
  runApp(PreferencesPage());
}

class PreferencesPage extends StatelessWidget {
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
  Map<String, bool?> buttonStates = {
    "Gluten": false,
    "Dairy": false,
    "Egg": false,
    "Soy": false,
    "Peanut": false,
    "Wheat": false,
    "Milk": false,
    "Fish": false,
    "Tree nuts": false,
    "Vegan": false,
    "Paleo": false,
    "Vegetarian": false,
    "Halal": false,
    "Kosher": false,
    "Keto": false,
  };

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController calorieController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Fetch and update button states when the widget is initialized
    loadUserPreferences();
  }

  Future<void> loadUserPreferences() async {
    try {
      String? uid = await getCurrentUserUID();
      if (uid != null) {
        // Fetch allergies from Firebase
        DocumentSnapshot allergiesSnapshot = await FirebaseFirestore.instance.collection('Allergies').doc(uid).get();
        Map<String, dynamic>? allergiesData = allergiesSnapshot.data() as Map<String, dynamic>?;

        // Fetch diet preferences from Firebase
        DocumentSnapshot dietSnapshot = await FirebaseFirestore.instance.collection('Diet').doc(uid).get();
        Map<String, dynamic>? dietData = dietSnapshot.data() as Map<String, dynamic>?;

        // Fetch calorie intakes from Firebase
        QuerySnapshot calorieIntakesSnapshot = await FirebaseFirestore.instance.collection('UserGoals').doc(uid).collection('CalorieIntakes').get();

        setState(() {
          // Toggle button states based on fetched data
          buttonStates.updateAll((key, value) {
            bool fetchedValue = allergiesData != null && allergiesData.containsKey(key)
                ? allergiesData[key]
                : dietData != null && dietData.containsKey(key)
                ? dietData[key]
                : value ?? false;

            return fetchedValue;
          });

          // Update calorie intakes

        });
      }
    } catch (e) {
      print("Error loading user preferences: $e");
    }
  }


  void toggleButtonState(String key) {
    setState(() {
      buttonStates[key] = !(buttonStates[key] ?? false);
    });
  }

  ElevatedButton buildElevatedButton(String text) {
    final isSelected = buttonStates[text] ?? false;
    return ElevatedButton(
      onPressed: () {
        toggleButtonState(text);
      },
      style: ElevatedButton.styleFrom(
        primary: isSelected ? Color(0xFFFF785B) : Colors.white,
        onPrimary: isSelected ? Colors.white : Colors.grey,
        onSurface: isSelected ? Colors.white : Colors.grey,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        minimumSize: Size(110, 30),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.black,
        ),
      ),
    );
  }

  void showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  Future<void> saveUserPreferences(String uid) async {
    // Save allergies to Firebase under 'Allergies' collection
    await FirebaseFirestore.instance.collection('Allergies').doc(uid).set({
      for (var entry in buttonStates.entries) if (entry.key != 'Vegan' &&
          entry.key != 'Paleo' && entry.key != 'Vegetarian' &&
          entry.key != 'Halal' && entry.key != 'Kosher' &&
          entry.key != 'Keto') entry.key: entry.value,
    });

    // Save diet preferences to Firebase under 'Diet' collection
    await FirebaseFirestore.instance.collection('Diet').doc(uid).set({
      for (var entry in buttonStates.entries) if (entry.key == 'Vegan' ||
          entry.key == 'Paleo' || entry.key == 'Vegetarian' ||
          entry.key == 'Halal' || entry.key == 'Kosher' ||
          entry.key == 'Keto') entry.key: entry.value,
    });

    // Save calorie intake to Firebase under 'UserGoals' collection


      await FirebaseFirestore.instance.collection('UserGoals')
          .doc(uid)
          .collection('CalorieIntakes')
          .add({
        'calorie': calorieController.text,
        'timestamp': FieldValue.serverTimestamp(),
      });

  }
  Future<String?> getCurrentUserUID() async {
    User? user = FirebaseAuth.instance.currentUser;
    return user?.uid;
  }

  void _goBack() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => ProfilePage()),
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
                      "Edit Preferences",
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
              buildSectionHeader("Allergies"),
              buildButtonRow(["Gluten", "Dairy", "Egg"]),
              buildButtonRow(["Soy", "Peanut", "Wheat"]),
              buildButtonRow(["Milk", "Fish", "Tree nuts"]),
              buildSectionHeader("Diet"),
              buildButtonRow(["Vegan", "Paleo", "Vegetarian"]),
              buildButtonRow(["Halal", "Kosher", "Keto"]),
              buildSectionHeader("Goals"),
              buildTextFieldRow("Daily Calorie Intake:", calorieController, "Enter calories"),
              buildSaveButton(() async {
                String? uid = await getCurrentUserUID();
                if (uid != null) {
                  await saveUserPreferences(uid);
                  showSnackbar("User preferences saved!");
                } else {
                  showSnackbar("Error: User not authenticated");
                }
              }),
            ],
          ),
        ),
      ),
      bottomNavigationBar: buildBottomNavigationBar(context), // Call the function
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

  Widget buildButtonRow(List<String> buttons) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: buttons
          .map((text) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: buildElevatedButton(text),
      ))
          .toList(),
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

  Widget buildSaveButton(VoidCallback onPressed) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20.0),
      child: ElevatedButton(
        onPressed: onPressed,
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



