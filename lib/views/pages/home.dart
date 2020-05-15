/// Home page which contains bottom navigation bar
library view_page_home;

import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import 'package:openinventory_student_app/views/sections/browse.dart';
import 'package:openinventory_student_app/views/sections/history.dart';
import 'package:openinventory_student_app/views/sections/search.dart';
import 'package:openinventory_student_app/views/sections/settings.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex;
  PageController _pageController;

  @override
  void initState() {
    _selectedIndex = 0;
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Open Inventory'),
        centerTitle: true,
      ),
      body: PageView(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          BrowseSection(),
          SearchSection(),
          HistorySection(),
          SettingsSection(),
        ],
      ),
      bottomNavigationBar: FancyBottomNavigation(
        tabs: [
          TabData(iconData: LineIcons.home, title: "Home"),
          TabData(iconData: LineIcons.search, title: "Search"),
          TabData(iconData: LineIcons.book, title: "History"),
          TabData(iconData: LineIcons.gear, title: "Settings")
        ],
        initialSelection: _selectedIndex,
        onTabChangedListener: (index) => setState(() {
          _selectedIndex = index;
          _pageController.animateToPage(index,
              duration: Duration(milliseconds: 100), curve: Curves.easeInOut);
        }),
      ),
    );
  }
}
