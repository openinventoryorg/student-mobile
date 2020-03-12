/// Home page which contains bottom navigation bar
library view_page_home;

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiver/time.dart';

import 'package:openinventory_student_app/views/sections/browse.dart';
import 'package:openinventory_student_app/views/sections/search.dart';
import 'package:openinventory_student_app/views/sections/settings.dart';
import 'package:openinventory_student_app/views/widgets/flashy_tab_bar.dart';
import 'package:openinventory_student_app/views/widgets/smart_app_bar.dart';

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
      appBar: SmartAppBar(
        title: 'SmartLab',
        subtitle: 'Smart Inventory System',
      ),
      body: PageView(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          BrowseSection(),
          SearchSection(),
          Container(),
          SettingsSection(),
        ],
      ),
      bottomNavigationBar: FlashyTabBar(
        selectedIndex: _selectedIndex,
        showElevation: true,
        onItemSelected: (index) => setState(() {
          _selectedIndex = index;
          _pageController.animateToPage(index,
              duration: aMillisecond * 100, curve: Curves.easeInOut);
        }),
        items: [
          FlashyTabBarItem(
            icon: Icon(EvaIcons.home),
            title: Text('Browse'),
          ),
          FlashyTabBarItem(
            icon: Icon(EvaIcons.search),
            title: Text('Search'),
          ),
          FlashyTabBarItem(
            icon: Icon(EvaIcons.book),
            title: Text('History'),
          ),
          FlashyTabBarItem(
            icon: Icon(EvaIcons.settings),
            title: Text('Settings'),
          ),
        ],
      ),
    );
  }
}
