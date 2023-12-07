import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_food_fit/pages/profile.dart';
import 'package:project_food_fit/pages/recipe_template.dart';
import 'package:project_food_fit/pages/searchpage.dart';
import 'package:project_food_fit/pages/home.dart';

void main() {
  runApp(ViewStatsPage());
}

class ViewStatsPage extends StatelessWidget {
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

  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('UserGoals')
            .doc(user.uid)
            .collection('CalorieIntakes')
            .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            List<DocumentSnapshot> snapshots =
            snapshot.data!.docs.cast<DocumentSnapshot>();

            return SingleChildScrollView(
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 60),
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.arrow_back),
                          onPressed: () {
                            // Navigate back to PreferencesPage
                            _goBack();
                          },
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                            'Today',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                          ),
                        ),

                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildStatsButton('Day', 0),
                            _buildStatsButton('Week', 1),
                            _buildStatsButton('Month', 2),
                          ],
                        ),
                        _buildLineChart(snapshots),
                        _buildStatsText(snapshots),
                      ],
                    ),
                  ],
                ),
              ),
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
    );
  }

  void _goBack() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => ProfilePage()),
    );
  }

  Widget _buildStatsButton(String text, int index) {
    return InkWell(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
      },
      child: Container(
        width: 70,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: _currentIndex == index
                  ? Color(0xFFFF785B).withOpacity(0.5)
                  : Colors.transparent,
              spreadRadius: 2,
              blurRadius: 10,
              offset: Offset(0, 3),
            ),
          ],
          gradient: _currentIndex == index
              ? LinearGradient(
            colors: [
              Color(0xFFFF785B).withOpacity(0.5),
              Color(0xFFFF785B).withOpacity(0.2)
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )
              : null,
          color: _currentIndex == index ? Colors.transparent : Colors.white,
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: _currentIndex == index ? Colors.white : Colors.grey,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLineChart(List<DocumentSnapshot> snapshots) {
    List<FlSpot> generateData(List<DocumentSnapshot> snapshots, int daysToFetch) {
      List<FlSpot> spots = [];
      for (int i = 0; i < daysToFetch; i++) {
        double calorie =
            double.tryParse(snapshots[i]['calorie'] ?? '0.0') ?? 0.0;
        spots.add(FlSpot(i.toDouble(), calorie));
      }
      return spots;
    }

    List<FlSpot> spots = [];

    if (_currentIndex == 0) {
      spots = generateData(snapshots, 3);
    } else if (_currentIndex == 1) {
      int daysToFetch = snapshots.length < 7 ? snapshots.length : 7;
      spots = generateData(snapshots, daysToFetch);
    } else if (_currentIndex == 2) {
      int daysToFetch = snapshots.length < 30 ? snapshots.length : 30;
      spots = generateData(snapshots, daysToFetch);
    }

    return Column(
      children: [
        SizedBox(
          height: 200,
          child: LineChart(
            LineChartData(
              gridData: FlGridData(show: false),
              titlesData: FlTitlesData(show: false),
              borderData: FlBorderData(
                show: false,
                border: Border.all(color: const Color(0xff37434d), width: 1),
              ),
              lineBarsData: [
                LineChartBarData(
                  spots: spots,
                  isCurved: true,
                  colors: [Color(0xFFFF785B)],
                  belowBarData: BarAreaData(
                    show: true,
                    colors: [
                      Color(0xFFFF785B),
                      Color(0xFFFBEDEA).withOpacity(0.1)
                    ],
                    gradientColorStops: [0.0, 1.0],
                    gradientFrom: Offset(0, 0),
                    gradientTo: Offset(0, 1),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatsText(List<DocumentSnapshot> snapshots) {
    double totalCalories = 0.0;

    if (_currentIndex == 0) {
      for (int i = 0; i < 3; i++) {
        totalCalories +=
            double.tryParse(snapshots[i]['calorie'] ?? '0.0') ?? 0.0;
      }
      return _buildStatsTextWidget('              Total Calories (Last 3 Days): $totalCalories');
    } else if (_currentIndex == 1) {
      int daysToFetch = snapshots.length < 7 ? snapshots.length : 7;
      for (int i = 0; i < daysToFetch; i++) {
        totalCalories +=
            double.tryParse(snapshots[i]['calorie'] ?? '0.0') ?? 0.0;
      }
      return _buildStatsTextWidget('                Total Calories (This Week): $totalCalories');
    } else if (_currentIndex == 2) {
      int daysToFetch = snapshots.length < 30 ? snapshots.length : 30;
      for (int i = 0; i < daysToFetch; i++) {
        totalCalories +=
            double.tryParse(snapshots[i]['calorie'] ?? '0.0') ?? 0.0;
      }
      return _buildStatsTextWidget('              Total Calories (This Month): $totalCalories');
    }

    // Default case (today)
    totalCalories = double.tryParse(
        snapshots.isNotEmpty ? snapshots.last['calorie'] ?? '0.0' : '0.0') ??
        0.0;
    return _buildStatsTextWidget('Total Calories (Today): $totalCalories');
  }

  Widget _buildStatsTextWidget(String text) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
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