import 'package:anuvad/constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class AppWidgets {
  static AppBar getAppBar() => AppBar(
        elevation: 0,
        leadingWidth: 35,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset(
              'images/logo.png',
              height: 30,
            ),
            Spacer(),
            Text(
              "ANUVAAD",
              style: TextStyle(
                color: BrandColors.primaryBlue,
                fontSize: 32,
                fontFamily: 'Samkarn',
              ),
            ),
            Spacer()
          ],
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
