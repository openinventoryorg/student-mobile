import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './controllers/api_controller.dart';
import './controllers/token_controller.dart';
import './routes/router.dart';
import './routes/routes.dart';

void main() {
  defineAllRoutes();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static const baseUrl = 'http://10.0.2.2:3000/api';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TokenController>(
      lazy: false,
      create: (_) => TokenController(),
      child: ProxyProvider<TokenController, ApiController>(
        create: (context) => ApiController.fromContext(
          context: context,
          baseUrl: baseUrl,
        ),
        update: (_, t, a) => ApiController(
          baseUrl: a.baseUrl,
          tokenController: t,
        ),
        lazy: false,
        child: ApiManagedApp(),
      ),
    );
  }
}

class ApiManagedApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SmartLab',
      theme: ThemeData(
        primaryColor: Colors.white,
        accentColor: Color(0xff272e81),
      ),
      onGenerateRoute: AppRouter.generator,
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
    );
  }
}
