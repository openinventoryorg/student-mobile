library view_page_staff_home;

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:openinventory_student_app/controllers/socket.dart';
import 'package:openinventory_student_app/helpers.dart';
import 'package:openinventory_student_app/routes/router.dart';
import 'package:openinventory_student_app/views/colors.dart';
import 'package:openinventory_student_app/views/pages/components/alerts.dart';
import 'package:openinventory_student_app/views/pages/components/connection_ball.dart';
import 'package:openinventory_student_app/views/sections/settings.dart';

class StaffHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool connected = SocketController.of(context, true).isConnected;

    return Scaffold(
        appBar: AppBar(
          title: Text('Open Inventory'),
          actions: <Widget>[ConnectionBall()],
        ),
        body: GridView.count(
          crossAxisCount: 2,
          children: <Widget>[
            (!connected)
                ? disconnectedWidget()
                : HomePageButton(
                    text: 'Scan Barcodes',
                    icon: LineIcons.barcode,
                    onPressed: () => sendBarcodeToWebApp(context),
                  ),
            HomePageButton(
              text: 'Temperory Handover',
              icon: LineIcons.clock_o,
              onPressed: () => AppRouter.navigate(context, '/staff/temp'),
            ),
            HomePageButton(
              text: 'Profile',
              icon: LineIcons.user,
              onPressed: () => AppRouter.navigate(context, '/profile'),
            ),
            HomePageButton(
              text: 'Logout',
              icon: LineIcons.sign_out,
              onPressed: () => SettingsSection.logout(context),
            ),
          ],
        ));
  }

  Widget disconnectedWidget() {
    return Center(
      child: Card(
        color: AppColors.colorC,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            title: Text(
              'You are not connected to the web app. ',
              style: TextStyle(color: Colors.white),
            ),
            subtitle: Text(
              'Recheck your internet connection. If the problem persists try restarting app.',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  void sendBarcodeToWebApp(BuildContext context) async {
    String code = await Helpers.scanQR();
    if (code == null) return;

    SocketController.of(context).sendMessage({'barcode': code});
    Alert.showAlertBox(context, 'Scanned Code: $code');
  }
}

class HomePageButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onPressed;

  const HomePageButton(
      {Key key, @required this.text, @required this.icon, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2),
      child: InkWell(
        onTap: onPressed,
        child: GridTile(
          child: Container(
            color: AppColors.colorB,
            child: Icon(
              icon,
              size: 56,
            ),
          ),
          footer: Container(
            padding: EdgeInsets.all(8),
            color: Theme.of(context).accentColor.withOpacity(0.8),
            child: AutoSizeText(
              text,
              style: _LabCardStyles.title,
              textAlign: TextAlign.center,
              maxLines: 2,
            ),
          ),
        ),
      ),
    );
  }
}

abstract class _LabCardStyles {
  static TextStyle get title => TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w800,
      );
}
