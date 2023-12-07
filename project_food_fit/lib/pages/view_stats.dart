import 'package:flutter/material.dart';
import 'package:project_food_fit/pages/profile.dart';
import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart';

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
  TextEditingController usernameController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  int _currentIndex = 0;

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    if (index == 0) {
      // Handle button "Day" click
    } else if (index == 1) {
      // Handle button "Week" click
    } else if (index == 2) {
      // Handle button "Month" click
    } else if (index == 3) {
      // Handle button "Year" click
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
// ADD DATA FOR LINE CHART
  List<FlSpot> generateData() {
    return [
      FlSpot(0, 3),
      FlSpot(1, 1),
      FlSpot(2, 4),
      FlSpot(3, 2),
    ];
  }

  Widget _buildLineChart() {
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
              minX: 0,
              maxX: 3,
              minY: 0,
              maxY: 5,
              lineBarsData: [
                LineChartBarData(
                  spots: generateData(),
                  isCurved: true,
                  colors: [Color(0xFFFF785B)],
                  belowBarData: BarAreaData(
                    show: true,
                    colors: [Color(0xFFFF785B), Color(0xFFFBEDEA).withOpacity(0.1)],
                    gradientColorStops: [0.0, 1.0],
                    gradientFrom: Offset(0, 0),
                    gradientTo: Offset(0, 1),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 16),
        Text(
          '1000',
          style: TextStyle(
            color: Colors.black,
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'Steps',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 16,
          ),
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Text(
                  '8.42',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Distance',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Text(
                  '1,200',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Calories',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Text(
                  '3:42',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Time',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatsButton(String text, bool isPressed) {
    return InkWell(
      onTap: () {
        onTabTapped(['Day', 'Week', 'Month', 'Year'].indexOf(text));
      },
      child: Container(
        width: 70,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: isPressed ? Color(0xFFFF785B).withOpacity(0.5) : Colors.transparent,
              spreadRadius: 2,
              blurRadius: 10,
              offset: Offset(0, 3),
            ),
          ],
          gradient: isPressed
              ? LinearGradient(
            colors: [Color(0xFFFF785B).withOpacity(0.5), Color(0xFFFF785B).withOpacity(0.2)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )
              : null,
          color: isPressed ? Colors.transparent : Colors.white,
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: isPressed ? Colors.white : Colors.grey,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Get current date
    DateTime currentDate = DateTime.now();
    String formattedDate = DateFormat("MMMM dd, yyyy").format(currentDate);

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 60),
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: _goBack,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Profile Picture
                  Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage('assets/profile.png'),
                    ),
                  ),
                  SizedBox(height: 8),
                  // Text "Today" with padding
                  Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      'Today',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      formattedDate,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  // Buttons for Day, Week, Month, Year
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildStatsButton('Day', _currentIndex == 0),
                      _buildStatsButton('Week', _currentIndex == 1),
                      _buildStatsButton('Month', _currentIndex == 2),
                      _buildStatsButton('Year', _currentIndex == 3),
                    ],
                  ),
                  // Line Chart
                  _currentIndex == 0 ? _buildLineChart() : Container(),
                ],
              ),
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
