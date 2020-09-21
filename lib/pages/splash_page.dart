import 'package:detector_app/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 2,
      navigateAfterSeconds: HomePage(),
      title: Text(
        'Dog and Cat',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 30.0,
          color: Color(0xFFE99600)
        ),
      ),
      image: Image.asset('assets/cat.png'),
      backgroundColor: Colors.black,
      photoSize: 50.0,
      loaderColor: Color(0xFFEEDA28), 
    );
  }
}