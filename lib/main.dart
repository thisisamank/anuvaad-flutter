import 'package:anuvad/constants/styles.dart';
import 'package:anuvad/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      theme: ThemeData(
        textTheme: TextTheme(
          headline1: GoogleFonts.montserrat(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.grey.shade800,
          ),
        ),
        primaryColor: Colors.white,
        accentColor: BrandColors.secondaryBlue,
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppWidgets.getAppBar(),
      body: Column(
        children: [
          SizedBox(height: 20),
          Center(
              child: Text(
            'Upload Your Video',
            style: Theme.of(context).textTheme.headline1,
          )),
          SizedBox(height: 20),
          Container(
              decoration: BoxDecoration(
                color: BrandColors.lightBlue,
              ),
              width: 250,
              height: 250,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    child: Center(
                        child: Image.asset(
                      'images/folder.png',
                      width: 70,
                    )),
                  ),
                  SizedBox(height: 8),
                  Text('Click here to upload')
                ],
              ))
        ],
      ),
    );
  }
}
