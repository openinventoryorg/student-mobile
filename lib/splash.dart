import 'package:flutter/material.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';

import './controllers/token_controller.dart';
import './routes/router.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String userEmail;

  @override
  void initState() {
    super.initState();
    _authenticate();
  }

  void _authenticate() async {
    String currentUserEmail = await _getCurrentEmail();
    setState(() {
      userEmail = currentUserEmail;
    });
    await Future.delayed(Duration(seconds: 1));

    String targetRoute;
    if (currentUserEmail == null) {
      targetRoute = "/login";
    } else {
      targetRoute = "/home";
    }

    if (mounted) {
      AppRouter.freshNavigate(context, targetRoute);
    }
  }

  Future<String> _getCurrentEmail() {
    return TokenController.of(context).emailNotificationCompleter.future;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          SpinKitDualRing(
            color: Theme.of(context).accentColor,
            size: MediaQuery.of(context).size.height * 0.1,
          ),
          if (userEmail != null)
            Positioned(
              child: Text(
                userEmail,
                style: TextStyle(color: Theme.of(context).accentColor),
              ),
              bottom: 16,
            ),
        ],
      ),
    );
  }
}
