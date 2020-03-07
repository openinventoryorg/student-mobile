import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:smartlab_mobile_frontend/controllers/token_controller.dart';
import 'package:smartlab_mobile_frontend/routes/router.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var user = TokenController.of(context).user;

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
              _buildListTile(EvaIcons.person, user.name, "Name", context),
              _buildListTile(
                  EvaIcons.activity, user.role, "Account Type", context),
              _buildListTile(EvaIcons.at, user.email, "Email", context),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: OutlineButton.icon(
            onPressed: () async {
              await TokenController.of(context).logout();
              AppRouter.freshNavigate(context, '/');
            },
            icon: Icon(Icons.exit_to_app),
            label: Text('Logout'),
          ),
        ),
      ],
    );
  }

  Widget _buildListTile(
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
}
