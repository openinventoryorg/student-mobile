import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './controllers/base_url_controller.dart';
import './controllers/api_controller.dart';
import './controllers/token_controller.dart';
import './routes/router.dart';
import './routes/routes.dart';

/// Dart entry point
void main() {
  // Register routes
  defineAllRoutes();
  runApp(BaseApp());
}

/// This is the main app entry point.
///
/// The app provider structure is
/// [BaseUrlController]
///     - [TokenController]
///         - [ApiController]
///               - [OpenInventoryApp]
///
/// [OpenInventoryApp] is provided as a proxy provider of
/// other two providers. (which are changed notifier providers)
class BaseApp extends StatelessWidget {
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
          child: OpenInventoryApp(),
        ),
      ),
    );
  }
}

class OpenInventoryApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Open Inventory',
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
