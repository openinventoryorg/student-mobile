import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartlab_mobile_frontend/controllers/base_url_controller.dart';

import './controllers/api_controller.dart';
import './controllers/token_controller.dart';
import './routes/router.dart';
import './routes/routes.dart';

void main() {
  defineAllRoutes();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BaseUrlController>(
      lazy: false,
      create: (_) => BaseUrlController(),
      child: ChangeNotifierProvider<TokenController>(
        lazy: false,
        create: (_) => TokenController(),
        child:
            ProxyProvider2<TokenController, BaseUrlController, ApiController>(
          create: (context) => ApiController.fromContext(context: context),
          update: (_, t, b, a) => ApiController(
            baseUrlController: b,
            tokenController: t,
          ),
          lazy: false,
          child: ApiManagedApp(),
        ),
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
