import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smartlab_mobile_frontend/controllers/api_controller.dart';
import 'package:smartlab_mobile_frontend/views/browse_page/bowse_page.dart';
import 'package:smartlab_mobile_frontend/views/search_page/search_page.dart';
import 'package:smartlab_mobile_frontend/views/settings_page/settings_page.dart';
import 'package:smartlab_mobile_frontend/views/widgets/flashy_tab_bar.dart';
import 'package:smartlab_mobile_frontend/views/widgets/smart_app_bar.dart';

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
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.computer),
            onPressed: () async {
              try {
                ApiController.of(context).demoCall();
              } catch (err) {
                print('ERROR: $err');
              }
            },
          )
        ],
      ),
      body: PageView(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          BrowsePage(),
          SearchPage(),
          Container(),
          SettingsPage(),
        ],
      ),
      bottomNavigationBar: FlashyTabBar(
        selectedIndex: _selectedIndex,
        showElevation: true,
        onItemSelected: (index) => setState(() {
          _selectedIndex = index;
          _pageController.animateToPage(index,
              duration: Duration(milliseconds: 100), curve: Curves.easeInOut);
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
