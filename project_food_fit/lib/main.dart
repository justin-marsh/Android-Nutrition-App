import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FoodFit Plus',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.red,
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MyHomePage(title: 'FoodFit Plus'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(widget.title),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Color(0xFFF96343)],
            stops: [0.4, 1.0], // Adjust the white section's height in the gradient
          ),
        ),
        child: Center(
          child: Column(
            children: <Widget>[
              // Add logo image
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Image.asset('assets/logo.png', width: 340),
              ),
              const SizedBox(height: 20),
              // Welcome text title
              const Padding(
                padding: EdgeInsets.all(0.0),
                child: Text(
                  'Welcome to FoodFit Plus', style: TextStyle(fontSize: 29,
                    fontWeight: FontWeight.w700, color: Colors.white, fontFamily: 'Montserrat',
                  ),
                ),
              ),
              //Welcome text paragraph
              const Padding(
                padding: EdgeInsets.only(left: 55.0, right: 55.0, top: 18.0),
                child: Text(
                  'Discover a healthier you with FoodFit Plus. Elevate your nutrition game, track your meals, and achieve your fitness goals with our user-friendly app. Get started today!',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w300,
                    color: Colors.white, fontFamily: 'Montserrat',
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              //Continue button
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Container(
                  width: 270,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () {
                      // Add button's functionality here
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    //Add arrow icon in button
                    child: const Icon(
                      Icons.arrow_forward, size: 30, color: Color(0xFF6A6A6A),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
