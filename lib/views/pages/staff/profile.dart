import 'package:flutter/material.dart';
import 'package:openinventory_student_app/views/pages/components/connection_ball.dart';
import 'package:openinventory_student_app/views/sections/settings.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Open Inventory'),
        actions: <Widget>[ConnectionBall()],
      ),
      body: SettingsSection(),
    );
  }
}
