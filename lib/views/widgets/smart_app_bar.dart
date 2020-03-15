/// Appbar with two lines of text
library widget_smart_app_bar;

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
              Text(title, style: _AppBarStyles.appBarTitle),
              Text(subtitle, style: _AppBarStyles.appBarSubtitle),
            ],
          ),
          centerTitle: true,
          actions: actions,
          bottom: bottom,
        );
}

abstract class _AppBarStyles {
  static TextStyle get appBarTitle => TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w800,
      );

  static TextStyle get appBarSubtitle => TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
      );
}
