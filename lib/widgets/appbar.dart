import 'package:anuvad/constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppWidgets {
  static AppBar getAppBar() => AppBar(
        elevation: 0,
        title: Text('Logo'),
        actions: [
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: FaIcon(FontAwesomeIcons.github,
                  color: BrandColors.secondaryBlue),
            ),
          )
        ],
      );
}
