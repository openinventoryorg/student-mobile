import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:openinventory_student_app/controllers/cart.dart';
import 'package:openinventory_student_app/views/colors.dart';
import 'package:provider/provider.dart';

import './controllers/base_url.dart';
import './controllers/api.dart';
import './controllers/token.dart';
import './routes/router.dart';
import './routes/routes.dart';

/// Dart entry point
void main() {
  // Register routes
  defineAllRoutes();
  runApp(App());
}

/// This is the main app entry point.
///
/// The app provider structure is
/// [BaseUrlController]
///     - [TokenController]
///         - [ApiController]
///             - [CartController]
///               - [OpenInventoryApp]
///
/// [OpenInventoryApp] is provided as a proxy provider of
/// other two providers. (which are changed notifier providers)
class App extends StatelessWidget {
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
          child: ChangeNotifierProvider<CartController>(
            child: OpenInventoryApp(),
            create: (_) => CartController(),
          ),
        ),
      ),
    );
  }
}

/// Material App Entry point
class OpenInventoryApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Open Inventory',
      theme: ThemeData(
        fontFamily: GoogleFonts.lato().fontFamily,
        scaffoldBackgroundColor: Colors.white,
        accentColor: AppColors.colorC,
        primaryColor: AppColors.colorD,
      ),
      onGenerateRoute: AppRouter.generator,
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
    );
  }
}
