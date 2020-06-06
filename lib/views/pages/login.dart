/// Login page which handles user login
library view_page_login;

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:line_icons/line_icons.dart';

import 'package:openinventory_student_app/controllers/api.dart';
import 'package:openinventory_student_app/controllers/base_url.dart';
import 'package:openinventory_student_app/controllers/token.dart';
import 'package:openinventory_student_app/routes/router.dart';
import 'package:openinventory_student_app/views/colors.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  static const emailRegex = r'^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$';
  bool _hidePassword;
  bool _asyncCallOngoing;
  TextEditingController _baseUrlController;
  TextEditingController _emailController;
  TextEditingController _passwordController;

  @override
  void initState() {
    _hidePassword = true;
    _asyncCallOngoing = false;
    _baseUrlController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _baseUrlController.text = BaseUrlController.of(context).baseUrl;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          signInLogo(context),
          form(context),
          SizedBox(height: 32),
        ],
      ),
    );
  }

  /// Login Screen Icon
  Widget signInLogo(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2.5,
      child: Center(
        child: Icon(
          Icons.lock_open,
          size: 154,
          color: AppColors.colorC,
        ),
      ),
    );
  }

  /// Form widget
  Widget form(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: <Widget>[
          formTextBox(
            hint: 'https://myorganization.com',
            label: 'Organization Url',
            controller: _baseUrlController,
            prefix: LineIcons.server,
            keyboard: TextInputType.emailAddress,
          ),
          formTextBox(
            hint: '150092U@uom.lk',
            label: 'Email',
            controller: _emailController,
            prefix: LineIcons.at,
            keyboard: TextInputType.url,
          ),
          formTextBox(
            hint: 'password',
            label: 'Password',
            controller: _passwordController,
            obscureText: _hidePassword,
            keyboard: TextInputType.text,
            prefix: LineIcons.lock,
            suffix: IconButton(
              icon: _hidePassword
                  ? Icon(LineIcons.eye_slash)
                  : Icon(LineIcons.eye),
              onPressed: switchPasswordVisibility,
            ),
          ),
          Builder(
            builder: (context) => RaisedButton(
              color: AppColors.colorD,
              textColor: Colors.white,
              onPressed:
                  _asyncCallOngoing ? () {} : () => onSignInPressed(context),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text('Sign-in'),
                  ),
                  buttonIcon(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Text box builder helper method.
  Widget formTextBox(
      {@required String hint,
      @required String label,
      @required TextEditingController controller,
      @required TextInputType keyboard,
      @required IconData prefix,
      bool obscureText = false,
      Widget suffix}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: TextField(
        obscureText: obscureText,
        controller: controller,
        keyboardType: keyboard,
        decoration: InputDecoration(
          hintText: hint,
          labelText: label,
          border: OutlineInputBorder(),
          suffixIcon: suffix,
          prefixIcon: Icon(prefix),
        ),
      ),
    );
  }

  /// Icon of the sign in button
  Widget buttonIcon() {
    if (_asyncCallOngoing) {
      return SizedBox(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(Colors.white),
          strokeWidth: 2,
        ),
        width: 24,
        height: 24,
      );
    } else {
      return Icon(LineIcons.arrow_right);
    }
  }

  /// Toggles the password visibility on/off
  void switchPasswordVisibility() {
    setState(() {
      _hidePassword = !_hidePassword;
    });
  }

  /// Log the user in using the text box values.
  /// If failed, shows a flush bar.
  void onSignInPressed(BuildContext context) async {
    String baseUrl = _baseUrlController.text.trim();
    String email = _emailController.text.trim();
    String password = _passwordController.text;
    if (baseUrl.isEmpty) {
      showSnackBar(context, 'Organization Url must be provided');
    } else if (email.isEmpty) {
      showSnackBar(context, 'Email must be provided');
    } else if (!RegExp(emailRegex).hasMatch(email)) {
      showSnackBar(context, 'Email is of invalid format');
    } else if (password.isEmpty) {
      showSnackBar(context, 'Password must be provided');
    } else {
      updateAsyncCallStatus(true);
      try {
        await BaseUrlController.of(context).setBaseUrl(baseUrl);
        // Small delay to changes to propagate
        await Future.delayed(Duration(milliseconds: 300));
        await ApiController.of(context).logIn(email, password);
        if (TokenController.of(context).tokenOfStaff == null) {
          AppRouter.freshNavigate(context, '/home');
        } else {
          AppRouter.freshNavigate(context, '/staff');
        }
      } catch (err) {
        showSnackBar(context, err.toString());
      } finally {
        updateAsyncCallStatus(false);
      }
    }
  }

  /// Updates the state of async calls.
  /// (To make sure not to send 2 async calls at once
  /// and to show an indicator)
  void updateAsyncCallStatus(bool ongoing) {
    if (mounted) {
      setState(() {
        _asyncCallOngoing = ongoing;
      });
    }
  }

  /// Shows a error message flush bar
  void showSnackBar(BuildContext context, String subtitle) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(subtitle),
      backgroundColor: Colors.red,
    ));
  }
}
