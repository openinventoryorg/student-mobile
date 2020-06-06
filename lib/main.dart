import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:openinventory_student_app/controllers/cart.dart';
import 'package:openinventory_student_app/controllers/socket.dart';
import 'package:openinventory_student_app/views/colors.dart';
import 'package:provider/provider.dart';

import './controllers/base_url.dart';
import './controllers/api.dart';
import './controllers/token.dart';
import './routes/router.dart';
import './routes/routes.dart';

/// Dart entry point
void main() {
  final Dio dio = Dio();
  // Register routes
  defineAllRoutes();
  runApp(App(dio: dio));
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
  final List<NavigatorObserver> navigatorObservers;
  final Dio dio;

  const App({Key key, this.navigatorObservers = const [], @required this.dio})
      : assert(navigatorObservers != null),
        super(key: key);

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
          create: (context) => ApiController.fromContext(
            context: context,
            dioService: dio,
          ),
          update: (_, t, b, a) {
            return ApiController(
              baseUrlController: b,
              tokenController: t,
              dioService: dio,
            );
          },
          lazy: false,
          child: ChangeNotifierProvider<CartController>(
            child: ChangeNotifierProxyProvider2<TokenController,
                BaseUrlController, SocketController>(
              create: (context) =>
                  SocketController.fromContext(context: context),
              update: (_, t, b, s) => SocketController(
                baseUrl: b.baseUrl,
                token: t.tokenOfStaff,
              ),
              child: OpenInventoryApp(navigatorObservers: navigatorObservers),
              lazy: false,
            ),
            create: (_) => CartController(),
          ),
        ),
      ),
    );
  }
}

/// Material App Entry point
class OpenInventoryApp extends StatelessWidget {
  final List<NavigatorObserver> navigatorObservers;

  const OpenInventoryApp({Key key, @required this.navigatorObservers})
      : super(key: key);

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
      navigatorObservers: navigatorObservers,
    );
  }
}
