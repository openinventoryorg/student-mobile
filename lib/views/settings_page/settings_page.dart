import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

import 'package:openinventory_student_app/controllers/token_controller.dart';
import 'package:openinventory_student_app/routes/router.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var user = TokenController.of(context).user;

    if (user == null) {
      // Fallback to logout instead of showing an error
      logout(context);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          child: ListView(
            children: <Widget>[
              Container(
                color: Theme.of(context).accentColor,
                padding: const EdgeInsets.all(16),
                child: Icon(
                  EvaIcons.person,
                  color: Theme.of(context).primaryColor,
                  size: 120,
                ),
              ),
              listTile(EvaIcons.person, user.name, "Name", context),
              listTile(EvaIcons.activity, user.role, "Account Type", context),
              listTile(EvaIcons.at, user.email, "Email", context),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: OutlineButton.icon(
            onPressed: () {
              logout(context);
            },
            icon: Icon(Icons.exit_to_app),
            label: Text('Logout'),
          ),
        ),
      ],
    );
  }

  Widget listTile(
    IconData icon,
    String title,
    String subtitle,
    BuildContext context,
  ) {
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).accentColor),
      title: Text(
        title,
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w700,
        ),
      ),
      subtitle: Text(subtitle),
    );
  }

  /// Logs the user out
  Future<void> logout(BuildContext context) async {
    await TokenController.of(context).logout();
    AppRouter.freshNavigate(context, '/');
  }
}
