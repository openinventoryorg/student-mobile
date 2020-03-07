import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:smartlab_mobile_frontend/controllers/api_controller.dart';
import 'package:smartlab_mobile_frontend/routes/router.dart';
import 'package:smartlab_mobile_frontend/views/widgets/smart_app_bar.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  static const signInLogo =
      'https://cdn.pixabay.com/photo/2015/12/10/16/39/shield-1086703_960_720.png';
  static const emailRegex = r'^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$';
  bool _hidePassword;
  bool _asyncCallOngoing;
  TextEditingController _emailController;
  TextEditingController _passwordController;

  @override
  void initState() {
    _hidePassword = true;
    _asyncCallOngoing = false;
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    theme = theme.copyWith(primaryColor: theme.accentColor);

    return Scaffold(
      appBar: SmartAppBar(
        title: 'SmartLab',
        subtitle: 'Student Sign-in',
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Theme(
          data: theme,
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 32),
                child: Image.network(
                  signInLogo,
                  height: 175,
                  fit: BoxFit.contain,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: TextField(
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: '150092U@uom.lk',
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: TextField(
                  obscureText: _hidePassword,
                  controller: _passwordController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: 'password',
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: _hidePassword
                          ? Icon(EvaIcons.eye)
                          : Icon(EvaIcons.eyeOff),
                      onPressed: switchPasswordVisibility,
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  RaisedButton(
                    color: Theme.of(context).accentColor,
                    textColor: Colors.white,
                    onPressed: _asyncCallOngoing ? () {} : onSignInPressed,
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Text('Sign-in'),
                        ),
                        buttonIcon(),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

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
      return Icon(EvaIcons.arrowForward);
    }
  }

  void switchPasswordVisibility() {
    setState(() {
      _hidePassword = !_hidePassword;
    });
  }

  void onSignInPressed() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text;

    if (email.isEmpty) {
      showFlushbar('Validation Error', 'Email must be provided');
    } else if (!RegExp(emailRegex).hasMatch(email)) {
      showFlushbar('Validation Error', 'Email is of invalid format');
    } else if (password.isEmpty) {
      showFlushbar('Validation Error', 'Password must be provided');
    } else {
      updateAsyncCallStatus(true);
      try {
        await ApiController.of(context).logIn(email, password);
        AppRouter.freshNavigate(context, '/home');
      } catch (err) {
        showFlushbar('Invalid Data', err.message);
      } finally {
        updateAsyncCallStatus(false);
      }
    }
  }

  void updateAsyncCallStatus(bool ongoing) {
    if (mounted) {
      setState(() {
        _asyncCallOngoing = ongoing;
      });
    }
  }

  void showFlushbar(String title, String subtitle) {
    Flushbar(
      title: title,
      message: subtitle,
      animationDuration: Duration(milliseconds: 200),
      icon: Icon(Icons.error, color: Colors.white),
      backgroundColor: Colors.red,
      leftBarIndicatorColor: Colors.red[800],
      mainButton: FlatButton(
        child: Text('CLOSE'),
        onPressed: () => Navigator.pop(context),
        textColor: Colors.white,
      ),
    )..show(context);
  }
}
