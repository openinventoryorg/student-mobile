import 'package:flutter/material.dart';

class SmartAppBar extends AppBar {
  SmartAppBar({
    @required String title,
    @required String subtitle,
    List<Widget> actions,
    Widget bottom,
  }) : super(
          title: Column(
            children: <Widget>[
              Text(title, style: AppBarStyles.appBarTitle),
              Text(subtitle, style: AppBarStyles.appBarSubtitle),
            ],
          ),
          centerTitle: true,
          actions: actions,
          bottom: bottom,
          elevation: 1,
        );
}

abstract class AppBarStyles {
  static TextStyle get appBarTitle => TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w800,
      );

  static TextStyle get appBarSubtitle => TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
      );
}
