import 'package:flutter/material.dart';
import 'package:project_food_fit/main.dart';
import 'package:project_food_fit/pages/profile.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PreferencesPage(),
      routes: {
        '/profile': (context) => ProfilePage(),
      },
    );
  }
}

class PreferencesPage extends StatefulWidget {
  @override
  _PreferencesPageState createState() => _PreferencesPageState();
}

class _PreferencesPageState extends State<PreferencesPage> {
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
  };
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
  TextEditingController calorieController = TextEditingController();
  TextEditingController stepController = TextEditingController();

  void showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }


  @override
  void dispose() {
    calorieController.dispose();
    stepController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {



    return Scaffold(

        key: _scaffoldKey,
        appBar: AppBar(
        leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.of(context).pop();
        },
        ),
          title: Text("Edit Preferences"),
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFFFBEDEA), Color(0xFFFFFDFD)],
              stops: [0.4, 1.0],
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 60),
                const Center(
                  child: Padding(
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
                ),
                const Divider(
                  color: Colors.grey,
                  thickness: 2.0,
                  indent: 40,
                  endIndent: 40,
                ),
                Container(
                  padding: EdgeInsets.only(left: 20.0, top: 10.0),
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "Allergies",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: 0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildElevatedButton("Gluten"),
                    SizedBox(width: 10),
                    buildElevatedButton("Dairy"),
                    SizedBox(width: 10),
                    buildElevatedButton("Egg"),
                  ],
                ),
                SizedBox(height: 0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildElevatedButton("Soy"),
                    SizedBox(width: 10),
                    buildElevatedButton("Peanut"),
                    SizedBox(width: 10),
                    buildElevatedButton("Wheat"),
                  ],
                ),
                SizedBox(height: 0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildElevatedButton("Milk"),
                    SizedBox(width: 10),
                    buildElevatedButton("Fish"),
                    SizedBox(width: 10),
                    buildElevatedButton("Tree nuts"),
                  ],
                ),
                SizedBox(height: 0),
                Container(
                  padding: EdgeInsets.only(left: 20.0, top: 20.0),
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "Diet",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: 0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildElevatedButton("Vegan"),
                    SizedBox(width: 10),
                    buildElevatedButton("Paleo"),
                    SizedBox(width: 10),
                    buildElevatedButton("Vegetarian"),
                  ],
                ),
                SizedBox(height: 0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildElevatedButton("Halal"),
                    SizedBox(width: 10),
                    buildElevatedButton("Kosher"),
                    SizedBox(width: 10),
                    buildElevatedButton("Keto"),
                  ],
                ),
                Container(
                  padding: EdgeInsets.only(left: 20.0, top: 20.0),
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "Goals",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                ),

                SingleChildScrollView(
                  child: Container(
                    margin: EdgeInsets.all(20.0),
                    padding: EdgeInsets.only(left:10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey, width: 2.0),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: SingleChildScrollView(
                      child: Row(
                        children: [
                        const Text(
                        "Daily Calorie Intake:",
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          controller: calorieController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Enter calories',
                            hintStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                          ),
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                          ),
                      ),
                        ],
                      ),
                    ),
                  ),
                ),
                SingleChildScrollView(
                  child: Container(
                    margin: EdgeInsets.only(left:20.0, right:20.0),
                    padding: EdgeInsets.only(left:10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey, width: 2.0),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: SingleChildScrollView(
                      child: Row(
                        children: [
                          const Text(
                            "Daily Steps:",
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: TextField(
                              controller: stepController,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Enter steps',
                                hintStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                              ),
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 20.0),
                  child: ElevatedButton(
                    onPressed: () {
                      showSnackbar("Preferences saved!");
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
                ),
              ],
            ),
          ),
        ),

        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home, color: Colors.grey),
              label: '', // Empty label
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search, color: Colors.grey),
              label: '', // Empty label
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add, color: Colors.grey),
              label: '', // Empty label
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite, color: Colors.grey),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person, color: Colors.grey),
              label: '',
            ),
          ],
        ),

    );
  }
}
