import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class AppWidgets {
  static AppBar getAppBar() => AppBar(
        elevation: 0,
        title: Row(
          children: [
            Image.asset(
              'images/logo.png',
              height: 30,
            ),
            Center(
              child: Text(
                "ANUVAAD",
                style: TextStyle(
                    color: Color(0xFF025EF6),
                    fontSize: 48,
                    fontFamily: 'Samkarn'),
              ),
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        ),
        actions: [
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: GestureDetector(
                  onTap: () {
                    launch('https://github.com/thisisamank/anuvaad-flutter');
                  },
                  child: FaIcon(FontAwesomeIcons.github)),
            ),
          )
        ],
      );
}
