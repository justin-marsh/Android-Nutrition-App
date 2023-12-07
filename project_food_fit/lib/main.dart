import 'package:flutter/material.dart';
import 'pages/signup.dart';
import 'pages/signin.dart';
import 'package:firebase_core/firebase_core.dart';
import 'components/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, //resolves flutter api outdated errors, makes app more stable
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          // Handle error
        }

        if (snapshot.connectionState == ConnectionState.done) {
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

        return CircularProgressIndicator();
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title});
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
            stops: [0.4, 1.0],
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
                  'Welcome to FoodFit Plus',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    fontFamily: 'Montserrat',
                  ),
                ),
              ),
              // Welcome text paragraph
              const Padding(
                padding: EdgeInsets.only(left: 55.0, right: 55.0, top: 18.0),
                child: Text(
                  'Discover a healthier you with FoodFit Plus. Elevate your nutrition game, track your meals, and achieve your fitness goals with our user-friendly app. Get started today!',
                  style: TextStyle(
                    fontSize: 1,
                    fontWeight: FontWeight.w300,
                    color: Colors.white,
                    fontFamily: 'Montserrat',
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              // Continue button
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Container(
                  width: 270,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigate to the sign-up page when the button is pressed
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignInPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    // Add arrow icon in button
                    child: Text(
                      'Sign In',
                      style: TextStyle(
                        fontSize: 18,
                        color: Color(0xFF6A6A6A),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),

              // New button for Sign In
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Container(
                  width: 270,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigate to the sign-in page when the button is pressed
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 18,
                        color: Color(0xFF6A6A6A),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
